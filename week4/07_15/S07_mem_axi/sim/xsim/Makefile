#------------------------------------------------------------------
SHELL           = /bin/sh
MAKEFILE        = Makefile
#-------------------------------------------------------------------------------
ifeq ($(MAKECMDGOALS),$(findstring $(MAKECMDGOALS), "" "all" "elab" "sim"))
    ifndef XILINX_VIVADO
       $(error XILINX_VIVADO environment variable not defined)
    else
        export VIVADO         = $(XILINX_VIVADO)/bin/vivado
        export VIVADO_VERSION = $(shell vivado -version | sed -n 1p | cut -d" " -f 2 | cut -c 2-7)
        export VIVADO_VER     = vivado.$(VIVADO_VERSION)
    endif
endif

#-------------------------------------------------------------------------------
export GUI        ?= 0
export OPTIONS    ?= 

#-------------------------------------------------------------------------------
all: elab sim

elab:
	xelab -d SIM=1 -prj xsim.prj -debug typical top -s top

sim:
	@if [ "$(GUI)" = "0" ]; then\
		xsim top -t xsim_run.tcl $(OPTIONS);\
	else\
		xsim top -gui -t xsim_run.tcl $(OPTIONS);\
	fi
	@if [ -f xsim.log ]; then\
		if grep -q ERROR xsim.log; then\
			echo "\033[0;31mSimulation result ERROR.\033[0m";\
		else\
			echo "\033[0;33mOK = NO ERROR.\033[0m";\
		fi;\
	fi

clean:
	/bin/rm -f  top.wdb
	/bin/rm -f  wave.vcd
	/bin/rm -f  webtalk_*.backup.jou
	/bin/rm -f  webtalk_*.backup.log
	/bin/rm -f  webtalk.jou
	/bin/rm -f  webtalk.log
	/bin/rm -f  xelab.log
	/bin/rm -f  xelab.pb
	/bin/rm -fr .Xil/
	/bin/rm -f  xsim_*.backup.jou
	/bin/rm -f  xsim_*.backup.log
	/bin/rm -fr xsim.dir/
	/bin/rm -f  xsim.jou
	/bin/rm -f  xsim.log
	/bin/rm -f  xvlog.log
	/bin/rm -f  xvlog.pb
	/bin/rm -f  hs_err_pid27828.log

cleanup clobber: clean

cleanupall distclean: cleanup
