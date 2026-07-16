@ECHO OFF

CALL C:\Xilinx\Vivado\2020.2\settings64.bat

SET DIR_HW=..\..\hw\impl.zed
SET DIR_XSA=%DIR_HW%\xsa
SET DIR_WORKSPACE=..\workspace.zed

IF NOT EXIST %DIR_XSA% (
   ECHO "%DIR_XSA% does not exist."
   GOTO END
)
IF EXIST %DIR_WORKSPACE% (
   RMDIR /S/Q %DIR_WORKSPACE%
)

SET DESIGN=zed
SET DESIGN_NAME=design_%DESIGN%
SET DIR_WRAP=%DIR_WORKSPACE%/%DESIGN_NAME%_wrapper/export/%DESIGN_NAME%_wrapper/sw/%DESIGN_NAME%_wrapper/standalone_domain
SET TARGET=dma_test.elf
SET DIR_OBJ=obj
SET DIR_SRC=src
SET SRCS=%DIR_SRC%/helloworld.c %DIR_SRC%/dma_axi_api.c %DIR_SRC%/platform.c
SET OBJS=%DIR_OBJ%/helloworld.o %DIR_OBJ%/dma_axi_api.o %DIR_OBJ%/platform.o

SET GCC=arm-none-eabi-gcc
SET DEPFLAGS=-MMD
SET DEFINES=
SET CFLAGS=-Wall -O0 -g3 -c -fmessage-length=0 -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard
SET INCDIRS=-I%DIR_SRC% -I%DIR_WRAP%/bspinclude/include -I%DIR_WORKSPACE%/%DESIGN_NAME%_wrapper/ps7_cortexa9_0/standalone_domain/bsp/ps7_cortexa9_0/include
SET LDFLAGS=-mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -Wl,-build-id=none -specs=%DIR_SRC%/Xilinx.spec -Wl,-T -Wl,%DIR_SRC%/lscript.ld
SET LIBS=-L%DIR_WRAP%/bsplib/lib -Wl,--start-group,-lxil,-lgcc,-lc,--end-group

echo %GCC% %DEFINES% %DEPFLAGS% %CFLAGS% %INCDIRS% -o %DIR_OBJ%/helloworld.o %DIR_SRC%/helloworld.c
%GCC% %DEFINES% %DEPFLAGS% %CFLAGS% %INCDIRS% -o %DIR_OBJ%/helloworld.o %DIR_SRC%/helloworld.c
%GCC% %DEFINES% %DEPFLAGS% %CFLAGS% %INCDIRS% -o %DIR_OBJ%/dma_axi_api.o %DIR_SRC%/dma_axi_api.c
%GCC% %DEFINES% %DEPFLAGS% %CFLAGS% %INCDIRS% -o %DIR_OBJ%/platform.o %DIR_SRC%/platform.c
%GCC% -o %TARGET% %OBJS% %LDFLAGS% %LIBS%

:END
    PAUSE -1
