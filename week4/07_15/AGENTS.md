# Repository Guidelines

## Project Structure & Module Organization

This directory contains the `S07_mem_axi` AXI memory exercise. Put synthesizable Verilog in `S07_mem_axi/rtl/verilog/`; the current starting point is `mem_axi_trainee.v`. Testbench code and the AXI bus-functional model live in `S07_mem_axi/bench/verilog/`. XSim manifests, Tcl, and launch scripts are under `sim/xsim/`, while Vivado synthesis scripts are under `syn/vivado.z7/`. `07_15_study.md` is reserved for session notes, not HDL.

The simulation manifest expects completed working files named `mem_axi.v`, `top.sv`, and `bfm_axi_tasks.sv`. Preserve the `_trainee` files as exercise templates unless a task explicitly asks to edit them directly.

## Build, Test, and Development Commands

Run commands from PowerShell:

- `cd S07_mem_axi\sim\xsim; .\RunSimulation.bat` — elaborate `top` and run the batch XSim test.
- `.\RunSimulation.bat GUI` — open the design in the XSim GUI for waveform inspection.
- `cd S07_mem_axi\syn\vivado.z7; .\RunSynthesis.bat` — synthesize `mem_axi` in Vivado batch mode; pass `GUI` for the graphical flow.
- `.\Clean.bat` in either tool directory — remove generated logs, databases, and work products.

The batch files currently reference Vivado 2021.2 for simulation and 2020.2 for synthesis. Use matching installations or adjust only your local tool setup.

## Coding Style & Naming Conventions

Follow the existing four-space indentation and aligned port/parameter lists. Use lowercase snake case for modules, tasks, and signals (`mem_axi`, `test_raw`, `s_axi_awvalid`); use uppercase snake case for parameters and macros (`AXI_WIDTH_DATA`, `NET_DELAY`). Keep AXI channel names and ready/valid directionality consistent with the interface. Prefer synthesizable Verilog in `rtl/` and SystemVerilog testbench constructs in `bench/`.

## Testing Guidelines

Tests are self-checking BFM tasks, not a separate unit-test framework. Add directed tasks named `test_<behavior>`, cover reset, single-beat transfers, bursts, byte strobes, and backpressure, and report mismatches with `$display` containing `Error`. A passing change should complete all read-after-write tests without `ERROR` in `xsim.log`. No coverage threshold is currently defined.

## Commit & Pull Request Guidelines

Recent history uses short imperative subjects such as `Add AXI...` and `Update ...`; keep each commit scoped to one exercise or behavior. Pull requests should describe the RTL change, list simulation/synthesis commands run, and call out untested cases. Attach a waveform or Vivado screenshot only when timing or GUI configuration is relevant. Do not commit generated `.Xil`, `xsim.dir`, logs, wave dumps, netlists, or secret files excluded by the repository `.gitignore`.
