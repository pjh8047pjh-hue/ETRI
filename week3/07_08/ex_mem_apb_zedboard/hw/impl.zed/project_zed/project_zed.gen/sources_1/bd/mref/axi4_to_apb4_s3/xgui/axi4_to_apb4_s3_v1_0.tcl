# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "ADDR_PBASE0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ADDR_PBASE1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ADDR_PBASE2" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AXI_WIDTH_ADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AXI_WIDTH_DATA" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AXI_WIDTH_ID" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AXI_WIDTH_STRB" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CLOCK_SYNC" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NUM_PSLAVE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PSIZE0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PSIZE1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PSIZE2" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WIDTH_PAD" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WIDTH_PDA" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WIDTH_PDS" -parent ${Page_0}


}

proc update_PARAM_VALUE.ADDR_PBASE0 { PARAM_VALUE.ADDR_PBASE0 } {
	# Procedure called to update ADDR_PBASE0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADDR_PBASE0 { PARAM_VALUE.ADDR_PBASE0 } {
	# Procedure called to validate ADDR_PBASE0
	return true
}

proc update_PARAM_VALUE.ADDR_PBASE1 { PARAM_VALUE.ADDR_PBASE1 } {
	# Procedure called to update ADDR_PBASE1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADDR_PBASE1 { PARAM_VALUE.ADDR_PBASE1 } {
	# Procedure called to validate ADDR_PBASE1
	return true
}

proc update_PARAM_VALUE.ADDR_PBASE2 { PARAM_VALUE.ADDR_PBASE2 } {
	# Procedure called to update ADDR_PBASE2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADDR_PBASE2 { PARAM_VALUE.ADDR_PBASE2 } {
	# Procedure called to validate ADDR_PBASE2
	return true
}

proc update_PARAM_VALUE.AXI_WIDTH_ADDR { PARAM_VALUE.AXI_WIDTH_ADDR } {
	# Procedure called to update AXI_WIDTH_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_WIDTH_ADDR { PARAM_VALUE.AXI_WIDTH_ADDR } {
	# Procedure called to validate AXI_WIDTH_ADDR
	return true
}

proc update_PARAM_VALUE.AXI_WIDTH_DATA { PARAM_VALUE.AXI_WIDTH_DATA } {
	# Procedure called to update AXI_WIDTH_DATA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_WIDTH_DATA { PARAM_VALUE.AXI_WIDTH_DATA } {
	# Procedure called to validate AXI_WIDTH_DATA
	return true
}

proc update_PARAM_VALUE.AXI_WIDTH_ID { PARAM_VALUE.AXI_WIDTH_ID } {
	# Procedure called to update AXI_WIDTH_ID when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_WIDTH_ID { PARAM_VALUE.AXI_WIDTH_ID } {
	# Procedure called to validate AXI_WIDTH_ID
	return true
}

proc update_PARAM_VALUE.AXI_WIDTH_STRB { PARAM_VALUE.AXI_WIDTH_STRB } {
	# Procedure called to update AXI_WIDTH_STRB when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_WIDTH_STRB { PARAM_VALUE.AXI_WIDTH_STRB } {
	# Procedure called to validate AXI_WIDTH_STRB
	return true
}

proc update_PARAM_VALUE.CLOCK_SYNC { PARAM_VALUE.CLOCK_SYNC } {
	# Procedure called to update CLOCK_SYNC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLOCK_SYNC { PARAM_VALUE.CLOCK_SYNC } {
	# Procedure called to validate CLOCK_SYNC
	return true
}

proc update_PARAM_VALUE.NUM_PSLAVE { PARAM_VALUE.NUM_PSLAVE } {
	# Procedure called to update NUM_PSLAVE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM_PSLAVE { PARAM_VALUE.NUM_PSLAVE } {
	# Procedure called to validate NUM_PSLAVE
	return true
}

proc update_PARAM_VALUE.PSIZE0 { PARAM_VALUE.PSIZE0 } {
	# Procedure called to update PSIZE0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PSIZE0 { PARAM_VALUE.PSIZE0 } {
	# Procedure called to validate PSIZE0
	return true
}

proc update_PARAM_VALUE.PSIZE1 { PARAM_VALUE.PSIZE1 } {
	# Procedure called to update PSIZE1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PSIZE1 { PARAM_VALUE.PSIZE1 } {
	# Procedure called to validate PSIZE1
	return true
}

proc update_PARAM_VALUE.PSIZE2 { PARAM_VALUE.PSIZE2 } {
	# Procedure called to update PSIZE2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PSIZE2 { PARAM_VALUE.PSIZE2 } {
	# Procedure called to validate PSIZE2
	return true
}

proc update_PARAM_VALUE.WIDTH_PAD { PARAM_VALUE.WIDTH_PAD } {
	# Procedure called to update WIDTH_PAD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WIDTH_PAD { PARAM_VALUE.WIDTH_PAD } {
	# Procedure called to validate WIDTH_PAD
	return true
}

proc update_PARAM_VALUE.WIDTH_PDA { PARAM_VALUE.WIDTH_PDA } {
	# Procedure called to update WIDTH_PDA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WIDTH_PDA { PARAM_VALUE.WIDTH_PDA } {
	# Procedure called to validate WIDTH_PDA
	return true
}

proc update_PARAM_VALUE.WIDTH_PDS { PARAM_VALUE.WIDTH_PDS } {
	# Procedure called to update WIDTH_PDS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WIDTH_PDS { PARAM_VALUE.WIDTH_PDS } {
	# Procedure called to validate WIDTH_PDS
	return true
}


proc update_MODELPARAM_VALUE.AXI_WIDTH_ID { MODELPARAM_VALUE.AXI_WIDTH_ID PARAM_VALUE.AXI_WIDTH_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_WIDTH_ID}] ${MODELPARAM_VALUE.AXI_WIDTH_ID}
}

proc update_MODELPARAM_VALUE.AXI_WIDTH_ADDR { MODELPARAM_VALUE.AXI_WIDTH_ADDR PARAM_VALUE.AXI_WIDTH_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_WIDTH_ADDR}] ${MODELPARAM_VALUE.AXI_WIDTH_ADDR}
}

proc update_MODELPARAM_VALUE.AXI_WIDTH_DATA { MODELPARAM_VALUE.AXI_WIDTH_DATA PARAM_VALUE.AXI_WIDTH_DATA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_WIDTH_DATA}] ${MODELPARAM_VALUE.AXI_WIDTH_DATA}
}

proc update_MODELPARAM_VALUE.AXI_WIDTH_STRB { MODELPARAM_VALUE.AXI_WIDTH_STRB PARAM_VALUE.AXI_WIDTH_STRB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_WIDTH_STRB}] ${MODELPARAM_VALUE.AXI_WIDTH_STRB}
}

proc update_MODELPARAM_VALUE.NUM_PSLAVE { MODELPARAM_VALUE.NUM_PSLAVE PARAM_VALUE.NUM_PSLAVE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM_PSLAVE}] ${MODELPARAM_VALUE.NUM_PSLAVE}
}

proc update_MODELPARAM_VALUE.WIDTH_PAD { MODELPARAM_VALUE.WIDTH_PAD PARAM_VALUE.WIDTH_PAD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WIDTH_PAD}] ${MODELPARAM_VALUE.WIDTH_PAD}
}

proc update_MODELPARAM_VALUE.WIDTH_PDA { MODELPARAM_VALUE.WIDTH_PDA PARAM_VALUE.WIDTH_PDA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WIDTH_PDA}] ${MODELPARAM_VALUE.WIDTH_PDA}
}

proc update_MODELPARAM_VALUE.WIDTH_PDS { MODELPARAM_VALUE.WIDTH_PDS PARAM_VALUE.WIDTH_PDS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WIDTH_PDS}] ${MODELPARAM_VALUE.WIDTH_PDS}
}

proc update_MODELPARAM_VALUE.ADDR_PBASE0 { MODELPARAM_VALUE.ADDR_PBASE0 PARAM_VALUE.ADDR_PBASE0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADDR_PBASE0}] ${MODELPARAM_VALUE.ADDR_PBASE0}
}

proc update_MODELPARAM_VALUE.PSIZE0 { MODELPARAM_VALUE.PSIZE0 PARAM_VALUE.PSIZE0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PSIZE0}] ${MODELPARAM_VALUE.PSIZE0}
}

proc update_MODELPARAM_VALUE.ADDR_PBASE1 { MODELPARAM_VALUE.ADDR_PBASE1 PARAM_VALUE.ADDR_PBASE1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADDR_PBASE1}] ${MODELPARAM_VALUE.ADDR_PBASE1}
}

proc update_MODELPARAM_VALUE.PSIZE1 { MODELPARAM_VALUE.PSIZE1 PARAM_VALUE.PSIZE1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PSIZE1}] ${MODELPARAM_VALUE.PSIZE1}
}

proc update_MODELPARAM_VALUE.ADDR_PBASE2 { MODELPARAM_VALUE.ADDR_PBASE2 PARAM_VALUE.ADDR_PBASE2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADDR_PBASE2}] ${MODELPARAM_VALUE.ADDR_PBASE2}
}

proc update_MODELPARAM_VALUE.PSIZE2 { MODELPARAM_VALUE.PSIZE2 PARAM_VALUE.PSIZE2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PSIZE2}] ${MODELPARAM_VALUE.PSIZE2}
}

proc update_MODELPARAM_VALUE.CLOCK_SYNC { MODELPARAM_VALUE.CLOCK_SYNC PARAM_VALUE.CLOCK_SYNC } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLOCK_SYNC}] ${MODELPARAM_VALUE.CLOCK_SYNC}
}

