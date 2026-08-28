@echo off
call C:\Xilinx\Vivado\2020.2\bin\vivado.bat -mode gui -source "%~dp0open_result_gui.tcl" -tclargs mac_accum
