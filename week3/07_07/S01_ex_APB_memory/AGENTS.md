# Repository Guidelines

## Project Structure & Module Organization

This repository is a small Verilog memory design exercise. RTL source lives in `rtl/verilog/`, with the main module in `memory.v`. Behavioral simulation scaffolding lives in `bench/verilog/`: `top.v` instantiates the DUT and tester, and `tester.v` drives read/write checks. Simulation projects are under `sim/` for RTL simulation and `sim.gate/` for gate-level simulation. Vivado synthesis files are under `syn/`, with the Zynq-7000 batch flow in `syn/vivado.z7/`.

Generated simulator outputs such as `*.log`, `*.jou`, `*.wdb`, `wave.vcd`, `.Xil/`, and `xsim.dir/` should be treated as build artifacts. Avoid editing them by hand.

## Build, Test, and Development Commands

- `make -C sim/xsim`: elaborates and runs the RTL XSIM simulation using `xsim.prj` and `xsim_run.tcl`.
- `make -C sim.gate/xsim`: runs the gate-level XSIM flow when synthesized netlists are available.
- `make -C syn/vivado.z7`: runs Vivado batch synthesis for the `memory` module. Requires `XILINX_VIVADO` and Vivado on `PATH`.
- `make clean` or `make -C sim/xsim clean`: removes generated logs, waveforms, and simulator work directories.
- `Clean.sh`, `Clean.csh`, and `Clean.bat`: platform-specific cleanup wrappers.

## Coding Style & Naming Conventions

Use Verilog-2001 style consistent with the existing files. Indent with four spaces. Keep module and signal names lowercase with underscores only when helpful, for example `dataW`, `dataR`, `ADD_WIDTH`, and `DAT_WIDTH` follow the current lesson style. Put parameters at the top of modules and use explicit net/register widths. Prefer nonblocking assignments in clocked `always @(posedge clk)` blocks.

## Testing Guidelines

Add behavioral checks in `bench/verilog/tester.v` and instantiate new DUT wiring through `bench/verilog/top.v`. Keep tests self-checking with clear `$display("[PASS] ...")` and `$display("[FAIL] ...")` messages. After RTL changes, run `make -C sim/xsim` and inspect both console output and `wave.vcd` when debugging timing behavior.

## Commit & Pull Request Guidelines

No Git history is present in this directory, so follow a simple imperative commit style such as `Add memory read-after-write test` or `Fix gated write timing`. Pull requests should describe the RTL or testbench change, list commands run, and include waveform screenshots only when signal timing is relevant.

## Agent-Specific Instructions

Keep generated Vivado and XSIM artifacts out of source edits unless the task explicitly targets them. When changing RTL, update or add a focused testbench check in the same change whenever practical.
