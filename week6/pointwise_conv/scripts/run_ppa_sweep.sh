#!/usr/bin/env bash
set -uo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
DESIGN_DIR=$(cd -- "$SCRIPT_DIR/.." && pwd)

POINTS_CSV="1,2,4,8,16,32,64"
PERIOD_NS="10.0"
RESULTS_DIR="$DESIGN_DIR/ppa_results"
STAGE="impl"
SWEEP_JOBS=1
VIVADO_THREADS=4
KEEP_DCP=0
RUN_CYCLE_MODEL=1
FORCE=0

usage() {
    echo "Usage: $0 [options]"
    echo "  --points LIST       Comma/space-separated values (default: 1,2,4,8,16,32,64)"
    echo "  --period-ns NS      Clock constraint in ns (default: 10.0)"
    echo "  --results DIR       Result directory (default: pointwise_conv/ppa_results)"
    echo "  --jobs N            Concurrent sweep points (default: 1)"
    echo "  --threads N         Maximum Vivado threads per point (default: 4)"
    echo "  --synth-only        Stop after OOC synthesis"
    echo "  --no-cycle-model    Skip start-to-done_w RTL control model"
    echo "  --no-sim            Alias for --no-cycle-model"
    echo "  --keep-dcp          Save each routed checkpoint"
    echo "  --force             Re-run successful matching points"
    echo "  -h, --help          Show this help"
}

while (($#)); do
    case "$1" in
        --points)
            POINTS_CSV=${2:?missing value for --points}
            shift 2
            ;;
        --period-ns)
            PERIOD_NS=${2:?missing value for --period-ns}
            shift 2
            ;;
        --results)
            RESULTS_DIR=${2:?missing value for --results}
            shift 2
            ;;
        --jobs)
            SWEEP_JOBS=${2:?missing value for --jobs}
            shift 2
            ;;
        --threads)
            VIVADO_THREADS=${2:?missing value for --threads}
            shift 2
            ;;
        --synth-only)
            STAGE="synth"
            shift
            ;;
        --no-cycle-model|--no-sim)
            RUN_CYCLE_MODEL=0
            shift
            ;;
        --keep-dcp)
            KEEP_DCP=1
            shift
            ;;
        --force)
            FORCE=1
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage >&2
            exit 2
            ;;
    esac
done

if ! command -v vivado >/dev/null 2>&1; then
    echo "vivado is not available in PATH" >&2
    exit 2
fi
if ! [[ $SWEEP_JOBS =~ ^[1-9][0-9]*$ ]]; then
    echo "--jobs must be a positive integer" >&2
    exit 2
fi
if ! [[ $VIVADO_THREADS =~ ^[1-9][0-9]*$ ]]; then
    echo "--threads must be a positive integer" >&2
    exit 2
fi

POINTS_TEXT=${POINTS_CSV//,/ }
read -r -a POINTS <<< "$POINTS_TEXT"
if ((${#POINTS[@]} == 0)); then
    echo "--points must contain at least one value" >&2
    exit 2
fi
for point in "${POINTS[@]}"; do
    if ! [[ $point =~ ^[0-9]+$ ]] || ((point < 1 || point > 64)); then
        echo "invalid PARALLEL_CH: $point (expected 1..64)" >&2
        exit 2
    fi
    if ((64 % point != 0)); then
        echo "invalid PARALLEL_CH: $point (current RTL requires a divisor of 64)" >&2
        exit 2
    fi
done

mkdir -p -- "$RESULTS_DIR"
RESULTS_DIR=$(cd -- "$RESULTS_DIR" && pwd)

run_cycle_model() {
    local point_dir=$1
    local point=$2
    local cycle_dir="$point_dir/cycles"

    mkdir -p -- "$cycle_dir"
    if ! python3 "$SCRIPT_DIR/model_ppa_cycles.py" \
        --parallel "$point" \
        --output-dir "$cycle_dir" \
        > "$cycle_dir/model.log" 2>&1; then
        return 1
    fi
    [[ -s "$cycle_dir/cycle_count.txt" ]]
}

run_point() {
    local point=$1
    local point_dir="$RESULTS_DIR/p$point"
    local status_file="$point_dir/status.env"

    mkdir -p -- "$point_dir"
    if ((FORCE == 0)) \
        && [[ -f $status_file ]] \
        && rg -q '^status=SUCCESS$' "$status_file" \
        && rg -q "^period_ns=$PERIOD_NS$" "$status_file" \
        && rg -q "^stage=$STAGE$" "$status_file"; then
        echo "[P=$point] already complete; skipping"
    else
        echo "[P=$point] Vivado $STAGE started"
        if ! vivado \
            -mode batch \
            -source "$SCRIPT_DIR/ppa_sweep_point.tcl" \
            -log "$point_dir/vivado.log" \
            -journal "$point_dir/vivado.jou" \
            -tclargs \
                "$point" \
                "$point_dir" \
                "$PERIOD_NS" \
                "$STAGE" \
                "$KEEP_DCP" \
                "$VIVADO_THREADS" \
            > "$point_dir/console.log" 2>&1; then
            echo "[P=$point] FAILED (see $point_dir/console.log)" >&2
            return 1
        fi
        echo "[P=$point] Vivado $STAGE complete"
    fi

    if ((RUN_CYCLE_MODEL == 1)); then
        if ((FORCE == 0)) && [[ -s "$point_dir/cycles/cycle_count.txt" ]]; then
            echo "[P=$point] cycle model already complete; skipping"
        else
            echo "[P=$point] cycle model started"
            if ! run_cycle_model "$point_dir" "$point"; then
                echo "[P=$point] cycle model FAILED (see $point_dir/cycles/model.log)" >&2
                return 1
            fi
            echo "[P=$point] cycle model complete"
        fi
    fi
}

overall_status=0
for point in "${POINTS[@]}"; do
    run_point "$point" &
    while :; do
        mapfile -t running_jobs < <(jobs -pr)
        if ((${#running_jobs[@]} < SWEEP_JOBS)); then
            break
        fi
        if ! wait -n; then
            overall_status=1
        fi
    done
done

while :; do
    mapfile -t running_jobs < <(jobs -pr)
    if ((${#running_jobs[@]} == 0)); then
        break
    fi
    if ! wait -n; then
        overall_status=1
    fi
done

python3 "$SCRIPT_DIR/collect_ppa_results.py" \
    --results "$RESULTS_DIR" \
    --points "${POINTS[@]}"

for point in "${POINTS[@]}"; do
    point_dir="$RESULTS_DIR/p$point"
    status_file="$point_dir/status.env"
    if [[ ! -f $status_file ]] \
        || ! rg -q '^status=SUCCESS$' "$status_file" \
        || ! rg -q "^period_ns=$PERIOD_NS$" "$status_file" \
        || ! rg -q "^stage=$STAGE$" "$status_file"; then
        overall_status=1
    fi
    if ((RUN_CYCLE_MODEL == 1)) && [[ ! -s "$point_dir/cycles/cycle_count.txt" ]]; then
        overall_status=1
    fi
done

if ((overall_status != 0)); then
    echo "One or more sweep points failed." >&2
    exit 1
fi

echo "PPA sweep complete: $RESULTS_DIR/summary.csv"
