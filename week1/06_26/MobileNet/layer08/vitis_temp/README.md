# Layer08 Vitis hardware verification

`main.c` is the actual FPGA verification application recovered from project
history. It uses AXI GPIO to:

1. assert and release accelerator reset;
2. pulse accelerator start;
3. wait for the hardware `done` signal;
4. read all 12,544 result-RAM entries;
5. compare every entry against the deterministic golden model.

The input/golden model is the project's synthetic verification pattern, not a
PyTorch or ImageNet inference sample.

## Vitis 2020.2

1. Copy `main.c` into `mobilenetV2_test/src/main.c`.
2. Clean and build `mobilenetV2_test`.
3. Initialize the PS/PL bridge completely with the project's `run_ocm.tcl`.
   Do not stop the FSBL after an arbitrary delay; that can leave the HPM AXI
   clock/reset path unusable.
4. Program the matching bitstream and launch `Debug/mobilenetV2_test.elf` on
   `psu_cortexa53_0`.
5. Open `psu_uart_1` in Tera Term at 115200 baud, 8-N-1, no flow control.

`PASS: all 12544 results match golden` is printed only when hardware asserts
`done` and all result values match. `HEARTBEAT: TIMEOUT` is a real failure and
must not be reported as a passing hardware run.

From an XSCT prompt, the verified project artifacts can be run with:

```tcl
cd {C:/Users/user/Documents/JH/project_mobilenetV2}
source run_ocm.tcl
```

## Current observed board result (2026-08-24)

The timeout was reproduced when an FSBL was stopped after a fixed five-second
delay. A diagnostic build showed AXI GPIO register accesses stalling before the
accelerator could be controlled. Running the complete `psu_init.tcl` sequence
(`run_ocm.tcl`) fixed the PS-to-PL HPM AXI clock/reset initialization. Channel 2
is synthesized as fixed input (`C_ALL_INPUTS_2=1`), so the software also no
longer writes its TRI2 direction register.

The final physical GPIO diagnostic read was:

```text
SIGNATURE=0x0001d108
WRITE_ADDR=0x000130ff
STATUS=0x00019555
```

`STATUS[16]=1` proves `done=1`; the lower diagnostic bits show that start, PW1,
depthwise, interconnect write completion, PW2, and result-ready were all seen.
`WRITE_ADDR[13:0]=12543` is the final result address. The final OCM verification
state was `0x4C38A551` with error count `0`, confirming that all 12,544 hardware
results matched the golden model.
