#!/usr/bin/env python3
"""Cycle-accurate control model for pointwise start-to-done_w latency."""

from __future__ import annotations

import argparse
from pathlib import Path


IN_CH = 64
OUT_CH = 384
PIXELS = 196
TOTAL_OUTPUTS = OUT_CH * PIXELS


def model_cycles(parallel: int) -> int:
    """Reproduce the sequential control/valid behavior of the current RTL."""
    state = "IDLE"
    ic_cnt = 0
    oc_cnt = 0
    pix_cnt = 0
    en_mul_d = False
    last_d = False
    mac_result_valid = False
    output_wr_addr = 0
    done_w = False

    def tick(start: bool) -> None:
        nonlocal state, ic_cnt, oc_cnt, pix_cnt
        nonlocal en_mul_d, last_d, mac_result_valid
        nonlocal output_wr_addr, done_w

        en_mul = state == "MAC"
        ic_last = ic_cnt >= IN_CH - parallel
        oc_last = oc_cnt == OUT_CH - 1
        pix_last = pix_cnt == PIXELS - 1

        next_state = state
        if state == "IDLE" and start:
            next_state = "LOAD"
        elif state == "LOAD":
            next_state = "MAC"
        elif state == "MAC" and ic_last:
            next_state = "DONE" if oc_last and pix_last else "LOAD"
        elif state == "DONE":
            next_state = "IDLE"

        next_ic = ic_cnt
        next_oc = oc_cnt
        next_pix = pix_cnt
        if en_mul:
            next_ic = 0 if ic_last else ic_cnt + parallel
            if ic_last:
                next_oc = 0 if oc_last else oc_cnt + 1
                if oc_last:
                    next_pix = 0 if pix_last else pix_cnt + 1

        next_mac_result_valid = en_mul_d and last_d
        next_done_w = False
        next_output_wr_addr = output_wr_addr
        if mac_result_valid:
            if output_wr_addr == TOTAL_OUTPUTS - 1:
                next_output_wr_addr = 0
                next_done_w = True
            else:
                next_output_wr_addr = output_wr_addr + 1

        state = next_state
        ic_cnt = next_ic
        oc_cnt = next_oc
        pix_cnt = next_pix
        en_mul_d = en_mul
        last_d = en_mul and ic_last
        mac_result_valid = next_mac_result_valid
        output_wr_addr = next_output_wr_addr
        done_w = next_done_w

    # The edge that samples start is cycle zero, matching the intended RTL
    # testbench measurement convention.
    tick(start=True)
    cycles = 0
    timeout = TOTAL_OUTPUTS * (IN_CH // parallel + 2) + 100
    while not done_w:
        tick(start=False)
        cycles += 1
        if cycles > timeout:
            raise RuntimeError("cycle model timed out")

    expected = TOTAL_OUTPUTS * (IN_CH // parallel + 1) + 2
    if cycles != expected:
        raise RuntimeError(f"model/formula mismatch: {cycles} != {expected}")
    return cycles


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--parallel", type=int, required=True)
    parser.add_argument("--output-dir", type=Path, required=True)
    args = parser.parse_args()

    if args.parallel < 1 or args.parallel > IN_CH or IN_CH % args.parallel:
        parser.error("parallel must be a divisor of 64 in the range 1..64")

    cycles = model_cycles(args.parallel)
    args.output_dir.mkdir(parents=True, exist_ok=True)
    (args.output_dir / "cycle_count.txt").write_text(f"{cycles}\n")
    (args.output_dir / "cycle_source.txt").write_text("rtl_control_model\n")
    print(f"PPA_RTL_MODEL_CYCLES={cycles}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
