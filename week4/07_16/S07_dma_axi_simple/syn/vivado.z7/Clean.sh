#!/bin/sh
if [ -d work            ]; then \rm -rf work;         fi
if [ -d xst             ]; then \rm -rf xst;          fi
if [ -d _xmsgs          ]; then \rm -rf _xmsgs;       fi
if [ -f compile.log     ]; then \rm -f compile.log;   fi
if [ -f ngc2edif.log    ]; then \rm -f ngc2edif.log;  fi
if [ -f compile.ngc     ]; then \rm -f compile.ngc;   fi
if [ -f xilinx.log      ]; then \rm -f xilinx.edif;   fi
if [ -f mod_adder.dcp   ]; then \rm -f mod_adder.dcp; fi
if [ -f vivado.jou      ]; then \rm -f vivado.jou;    fi
if [ -f vivado_*.jou    ]; then \rm -f vivado_*.jou;  fi
if [ -f eth_handler.dcp ]; then \rm -f eth_handler.dcp; fi

\rm -f *.edif
\rm -f *.xncf
\rm -f *.lso
\rm -f *.ngc
\rm -f *.ngr
\rm -f *.nlf
\rm -f *.log
\rm -f *.blc
\rm -f *.xrpt

if [ -d xlnx_auto_0_xdb ]; then \rm -rf xlnx_auto_0_xdb; fi
if [ -f xlnx_auto_0.ise ]; then \rm -f xlnx_auto_0.ise;  fi 
if [ -f x_list.txt      ]; then \rm -f x_list.txt;       fi 
if [ -f xx_list.txt     ]; then \rm -f xx_list.txt;      fi 
if [ -f fifo32x1024.ngo ]; then \rm -f fifo32x1024.ngo;  fi
if [ -f fifo32x512.ngo  ]; then \rm -f fifo32x512.ngo;   fi
if [ -f hif.ngo         ]; then \rm -f hif.ngo;          fi
if [ -f usbhif8core.ngo ]; then \rm -f usbhif8core.ngo;  fi
