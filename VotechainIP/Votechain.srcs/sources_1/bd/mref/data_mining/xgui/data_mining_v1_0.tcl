# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "BW" -parent ${Page_0}
  ipgui::add_param $IPINST -name "msgAddr_BW" -parent ${Page_0}
  ipgui::add_param $IPINST -name "nAddr_BW" -parent ${Page_0}
  ipgui::add_param $IPINST -name "wAddr_BW" -parent ${Page_0}


}

proc update_PARAM_VALUE.BW { PARAM_VALUE.BW } {
	# Procedure called to update BW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BW { PARAM_VALUE.BW } {
	# Procedure called to validate BW
	return true
}

proc update_PARAM_VALUE.msgAddr_BW { PARAM_VALUE.msgAddr_BW } {
	# Procedure called to update msgAddr_BW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.msgAddr_BW { PARAM_VALUE.msgAddr_BW } {
	# Procedure called to validate msgAddr_BW
	return true
}

proc update_PARAM_VALUE.nAddr_BW { PARAM_VALUE.nAddr_BW } {
	# Procedure called to update nAddr_BW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.nAddr_BW { PARAM_VALUE.nAddr_BW } {
	# Procedure called to validate nAddr_BW
	return true
}

proc update_PARAM_VALUE.wAddr_BW { PARAM_VALUE.wAddr_BW } {
	# Procedure called to update wAddr_BW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.wAddr_BW { PARAM_VALUE.wAddr_BW } {
	# Procedure called to validate wAddr_BW
	return true
}


proc update_MODELPARAM_VALUE.BW { MODELPARAM_VALUE.BW PARAM_VALUE.BW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BW}] ${MODELPARAM_VALUE.BW}
}

proc update_MODELPARAM_VALUE.wAddr_BW { MODELPARAM_VALUE.wAddr_BW PARAM_VALUE.wAddr_BW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.wAddr_BW}] ${MODELPARAM_VALUE.wAddr_BW}
}

proc update_MODELPARAM_VALUE.nAddr_BW { MODELPARAM_VALUE.nAddr_BW PARAM_VALUE.nAddr_BW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.nAddr_BW}] ${MODELPARAM_VALUE.nAddr_BW}
}

proc update_MODELPARAM_VALUE.msgAddr_BW { MODELPARAM_VALUE.msgAddr_BW PARAM_VALUE.msgAddr_BW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.msgAddr_BW}] ${MODELPARAM_VALUE.msgAddr_BW}
}

