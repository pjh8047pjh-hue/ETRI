# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

This is a **Xilinx Vivado** FPGA project (`project_top_counter.xpr`), not a software application. It implements a start/hold stopwatch (MM:SS, BCD) displayed on a multiplexed 2-digit-pair seven-segment display, targeting an **Ultra96** board (Zynq UltraScale+, part `xczu3eg-sbva484-1-e`).

There is no software build system (npm/make/etc.) — everything is driven through Vivado, either the GUI or its Tcl console.

## Working with this repo

- Open `project_top_counter.xpr` in Vivado to work on the design.
- Editable RTL lives under `project_top_counter.srcs/sources_1/imports/...` — Vivado preserves each source file's original absolute path from wherever it was imported from (hence the nested `Documents/JH/...` and `Documents/카카오톡 받은 파일/...` paths). There is no flat `src/` directory.
- Constraints (pin/IO mapping) are in `project_top_counter.srcs/constrs_1/imports/Downloads/ultra96_training_kit.xdc`.
- The `clk_wiz_0` IP (Clocking Wizard, 40 MHz in → 100 MHz out) is defined in `project_top_counter.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci`.
- Directories `project_top_counter.cache/`, `.gen/`, `.hw/`, `.ip_user_files/`, `.runs/`, `.sim/` are Vivado-managed build artifacts (synthesis/implementation runs, generated IP output products, simulation scripts). Never hand-edit files in these — regenerate them from Vivado instead (Reset Run / Generate Output Products).
- There are no testbenches or a `.sim` fileset in this project currently; verification has been visual/on-hardware only.

### Typical Vivado Tcl commands (console or batch mode)

```tcl
open_project project_top_counter.xpr
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
```

## Architecture

Signal/module hierarchy (top-down), all in Verilog:

```
top.v
├─ clk_wiz_0 (IP)   40 MHz clk -> clk_100 (100 MHz), driven by rst
├─ FSM.v            start/hold control -> run_en (cstate)
├─ counter.v         run_en -> BCD digits: sec_1, sec_10, min_1, min_10
└─ top_bcd2ssd.v     BCD digits -> ssd1/ssd2 (7-seg) + cat_1/cat_2 (digit-select)
   └─ bcd2ssd.v (x4)  single BCD nibble -> 7-seg pattern (combinational)
```

- `top.v` inverts the board's active-high `rst` before feeding `FSM` (`.rst(~sys_rst)`), since `FSM` treats `rst == 1'b0` as reset. Keep this inversion in mind when tracing reset behavior across module boundaries.
- `counter.v` free-runs a cycle counter (`cnt`, comparing against `10**8 - 1` for a 1-second tick at 100 MHz) and increments cascading BCD digits (`sec_1` → `sec_10` → `min_1` → `min_10`, rolling over at 10/10/6/6 respectively) only while `en` (i.e., `run_en` from the FSM) is high.
- `top_bcd2ssd.v` multiplexes both digit pairs (seconds ssd1, minutes ssd2) on a shared ~500,000-cycle divider (`clk_bcd2ssd`/`bcd2ssd_sel`), so the ones/tens digit swap for seconds and minutes happens in lockstep rather than independently.

### Things to watch when editing the RTL

- `counter.v` mixes non-blocking assignment for `cnt` (clocked block) with blocking assignment for the BCD digits (a separate `always @(*)` block), and declares `tick` only via `assign` (implicit wire, relying on default nettype) — be careful if adding new signals or refactoring these blocks, since intent/timing here is easy to get subtly wrong.
- `FSM.v`'s state-transition block is sensitive only to `hold` (`always @(hold)`), not to `start` or `cstate` — so `start` only takes effect on the next `hold` edge, not immediately. Confirm whether this is the desired behavior before changing surrounding logic.
- `top_bcd2ssd.v` also relies on implicit wire declarations for the `bcd2ssd` instance outputs (`ssd_s1`, `ssd_s10`, `ssd_m1`, `ssd_m10`), declared after first use — legal in Verilog but worth knowing if `default_nettype none` is ever introduced.
