#!/usr/bin/env python3
"""Collect per-point Vivado reports into one PPA comparison CSV."""

from __future__ import annotations

import argparse
import csv
import math
import re
from pathlib import Path


TOTAL_MAC = 14 * 14 * 64 * 384
TARGET_MS = 0.8


def read_env(path: Path) -> dict[str, str]:
    values: dict[str, str] = {}
    if not path.is_file():
        return values
    for line in path.read_text(errors="replace").splitlines():
        if "=" in line:
            key, value = line.split("=", 1)
            values[key.strip()] = value.strip()
    return values


def number(value: str | None) -> float | None:
    if value is None:
        return None
    cleaned = value.strip().replace(",", "")
    if not cleaned or cleaned.lower() in {"n/a", "na", "-"}:
        return None
    try:
        return float(cleaned)
    except ValueError:
        return None


def pipe_cells(line: str) -> list[str]:
    return [cell.strip() for cell in line.strip().strip("|").split("|")]


def report_row_value(path: Path, labels: tuple[str, ...]) -> float | None:
    if not path.is_file():
        return None
    normalized_labels = {label.rstrip("*").strip() for label in labels}
    for line in path.read_text(errors="replace").splitlines():
        if not line.lstrip().startswith("|"):
            continue
        cells = pipe_cells(line)
        if len(cells) < 2:
            continue
        label = cells[0].rstrip("*").strip()
        if label in normalized_labels:
            return number(cells[1])
    return None


def parse_timing_summary(path: Path) -> tuple[float | None, float | None]:
    if not path.is_file():
        return None, None
    lines = path.read_text(errors="replace").splitlines()
    for index, line in enumerate(lines):
        if "WNS(ns)" not in line or "TNS(ns)" not in line:
            continue
        # Vivado 2020.2's text report uses a whitespace table here rather than
        # the pipe-delimited format used by utilization and power reports.
        for candidate in lines[index + 1 : index + 8]:
            match = re.match(
                r"^\s*(-?\d+(?:\.\d+)?)\s+(-?\d+(?:\.\d+)?)\s+", candidate
            )
            if match:
                return float(match.group(1)), float(match.group(2))
        headers = pipe_cells(line)
        for candidate in lines[index + 1 : index + 8]:
            if not candidate.lstrip().startswith("|"):
                continue
            values = pipe_cells(candidate)
            if len(values) != len(headers):
                continue
            mapped = dict(zip(headers, values))
            wns = number(mapped.get("WNS(ns)"))
            tns = number(mapped.get("TNS(ns)"))
            if wns is not None:
                return wns, tns
    return None, None


def fmt(value: object, digits: int = 6) -> object:
    if value is None:
        return ""
    if isinstance(value, float):
        if not math.isfinite(value):
            return ""
        return f"{value:.{digits}f}"
    return value


def collect_point(results_dir: Path, parallel: int) -> dict[str, object]:
    point_dir = results_dir / f"p{parallel}"
    status = read_env(point_dir / "status.env")
    successful = status.get("status") == "SUCCESS"
    stage = status.get("stage", "")
    implemented = successful and stage == "impl"
    util_path = (
        point_dir / "utilization.rpt"
        if implemented
        else point_dir / "utilization_synth.rpt"
    )
    if not successful:
        util_path = Path("/__missing_ppa_report__")

    wns, tns = (
        parse_timing_summary(point_dir / "timing_summary.rpt")
        if implemented
        else (None, None)
    )
    if wns is None:
        wns = number(status.get("wns_ns"))
    period_ns = number(status.get("period_ns"))
    fmax_mhz = number(status.get("estimated_fmax_mhz"))
    if fmax_mhz is None and wns is not None and period_ns is not None:
        critical_period = period_ns - wns
        if critical_period > 0:
            fmax_mhz = 1000.0 / critical_period

    cycle_dir = point_dir / "cycles"
    cycle_path = cycle_dir / "cycle_count.txt"
    actual_cycles: int | None = None
    if cycle_path.is_file():
        match = re.search(r"\d+", cycle_path.read_text(errors="replace"))
        if match:
            actual_cycles = int(match.group())
    cycle_source = ""
    cycle_source_path = cycle_dir / "cycle_source.txt"
    if cycle_source_path.is_file():
        cycle_source = cycle_source_path.read_text(errors="replace").strip()

    ideal_cycles = math.ceil(TOTAL_MAC / parallel)
    actual_time_ms = None
    if actual_cycles is not None and fmax_mhz:
        actual_time_ms = actual_cycles / (fmax_mhz * 1000.0)
    ideal_time_ms = None
    if fmax_mhz:
        ideal_time_ms = ideal_cycles / (fmax_mhz * 1000.0)

    power_path = point_dir / "power.rpt" if implemented else Path("/__missing_ppa_report__")
    dynamic_power = report_row_value(power_path, ("Dynamic (W)",))
    static_power = report_row_value(power_path, ("Device Static (W)", "Static (W)"))
    total_power = report_row_value(power_path, ("Total On-Chip Power (W)",))
    energy_mj = None
    if total_power is not None and actual_time_ms is not None:
        energy_mj = total_power * actual_time_ms

    multiplier_utilization = None
    if actual_cycles:
        multiplier_utilization = 100.0 * TOTAL_MAC / (parallel * actual_cycles)

    return {
        "P": parallel,
        "status": status.get("status", "MISSING"),
        "stage": stage,
        "ideal_cycles": ideal_cycles,
        "actual_cycles": actual_cycles,
        "cycle_source": cycle_source,
        "period_ns": period_ns,
        "WNS_ns": wns,
        "TNS_ns": tns,
        "timing_met": "O" if wns is not None and wns >= 0 else "X" if wns is not None else "",
        "Fmax_MHz": fmax_mhz,
        "ideal_time_ms": ideal_time_ms,
        "actual_time_ms": actual_time_ms,
        "target_0p8ms": (
            "O" if actual_time_ms is not None and actual_time_ms <= TARGET_MS
            else "X" if actual_time_ms is not None
            else ""
        ),
        "target_margin_ms": (
            TARGET_MS - actual_time_ms if actual_time_ms is not None else None
        ),
        "speedup": None,
        "parallel_efficiency_pct": None,
        "multiplier_utilization_pct": multiplier_utilization,
        "DSP": report_row_value(util_path, ("DSPs",)),
        "LUT": report_row_value(util_path, ("CLB LUTs",)),
        "FF": report_row_value(util_path, ("CLB Registers",)),
        "LUTRAM": report_row_value(util_path, ("LUT as Memory",)),
        "BRAM_tile": report_row_value(util_path, ("Block RAM Tile",)),
        "dynamic_power_W": dynamic_power,
        "static_power_W": static_power,
        "total_power_W": total_power,
        "energy_per_inference_mJ": energy_mj,
        "EDP_mJ_ms": (
            energy_mj * actual_time_ms
            if energy_mj is not None and actual_time_ms is not None
            else None
        ),
        "performance_per_W_inf_s_W": (
            1000.0 / actual_time_ms / total_power
            if actual_time_ms and total_power
            else None
        ),
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--results", type=Path, required=True)
    parser.add_argument("--points", type=int, nargs="+", required=True)
    args = parser.parse_args()

    rows = [collect_point(args.results, point) for point in args.points]
    baseline = next(
        (row for row in rows if row["P"] == 1 and row["actual_time_ms"]), None
    )
    if baseline:
        baseline_time = float(baseline["actual_time_ms"])
        for row in rows:
            if row["actual_time_ms"]:
                speedup = baseline_time / float(row["actual_time_ms"])
                row["speedup"] = speedup
                row["parallel_efficiency_pct"] = 100.0 * speedup / int(row["P"])

    fieldnames = list(rows[0].keys()) if rows else []
    args.results.mkdir(parents=True, exist_ok=True)
    output_path = args.results / "summary.csv"
    with output_path.open("w", newline="") as output_file:
        writer = csv.DictWriter(output_file, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow({key: fmt(value) for key, value in row.items()})

    print(output_path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
