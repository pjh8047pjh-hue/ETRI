# Layer08 temporary Vitis self-test

`main.c` is a temporary standalone application. It runs two tests:

1. A fixed Q3.12 MAC example (`0x3800` expected output)
2. Write/readback of four samples from the real Layer08 IFM COE

It does not start the Layer08 accelerator. The default build uses a volatile
CPU-visible array so that it can run before the AXI BRAM address is known.

## Run without a board

Open Vitis's integrated terminal and run the prebuilt Windows preview:

```powershell
cd C:\Users\user\Documents\JH\week1\06_26\MobileNet\layer08\vitis_temp
.\layer08_vitis_preview.exe
```

This requires no JTAG, UART, XSA, or board connection. The visible output is
kept identical to the UART build; this command itself is still a PC execution
rather than a hardware run.

## Vitis Unified IDE

1. If a platform is not ready, create **File > New Component > Platform** from
   the Vivado `.xsa`, select the processor and `standalone` OS, then build it.
2. Create **File > New Component > Application**.
3. Select that platform and its `standalone` processor domain.
4. Choose an empty application, then import this `main.c` into **Sources**.
5. Remove or exclude the template's existing `main.c` if it has one.
6. Build the application.
7. Connect JTAG and UART, program the FPGA if necessary, and launch the
   application on hardware.
8. Open the serial terminal using the UART and baud rate selected by the
   platform/BSP. The last line should be `FINAL    : PASS`.

## Switch to a confirmed AXI BRAM

Find the correct BRAM controller base-address symbol in the generated
`xparameters.h`, then change the two definitions near the top of `main.c`:

```c
#define USE_LAYER08_BRAM       1
#define LAYER08_BRAM_BASEADDR  XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR
```

The symbol above is only an example. Do not enable it until the address and
16-bit lane mapping of the intended Layer08 IFM BRAM have been confirmed.
