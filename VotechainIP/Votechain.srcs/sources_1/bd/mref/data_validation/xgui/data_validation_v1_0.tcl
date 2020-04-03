# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "CHECK" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COLLECT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CONF" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RESULT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "STOP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "STORE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WAIT" -parent ${Page_0}


}

proc update_PARAM_VALUE.CHECK { PARAM_VALUE.CHECK } {
	# Procedure called to update CHECK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CHECK { PARAM_VALUE.CHECK } {
	# Procedure called to validate CHECK
	return true
}

proc update_PARAM_VALUE.COLLECT { PARAM_VALUE.COLLECT } {
	# Procedure called to update COLLECT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLLECT { PARAM_VALUE.COLLECT } {
	# Procedure called to validate COLLECT
	return true
}

proc update_PARAM_VALUE.CONF { PARAM_VALUE.CONF } {
	# Procedure called to update CONF when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CONF { PARAM_VALUE.CONF } {
	# Procedure called to validate CONF
	return true
}

proc update_PARAM_VALUE.RESULT { PARAM_VALUE.RESULT } {
	# Procedure called to update RESULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RESULT { PARAM_VALUE.RESULT } {
	# Procedure called to validate RESULT
	return true
}

proc update_PARAM_VALUE.STOP { PARAM_VALUE.STOP } {
	# Procedure called to update STOP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.STOP { PARAM_VALUE.STOP } {
	# Procedure called to validate STOP
	return true
}

proc update_PARAM_VALUE.STORE { PARAM_VALUE.STORE } {
	# Procedure called to update STORE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.STORE { PARAM_VALUE.STORE } {
	# Procedure called to validate STORE
	return true
}

proc update_PARAM_VALUE.WAIT { PARAM_VALUE.WAIT } {
	# Procedure called to update WAIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WAIT { PARAM_VALUE.WAIT } {
	# Procedure called to validate WAIT
	return true
}


proc update_MODELPARAM_VALUE.WAIT { MODELPARAM_VALUE.WAIT PARAM_VALUE.WAIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WAIT}] ${MODELPARAM_VALUE.WAIT}
}

proc update_MODELPARAM_VALUE.STOP { MODELPARAM_VALUE.STOP PARAM_VALUE.STOP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.STOP}] ${MODELPARAM_VALUE.STOP}
}

proc update_MODELPARAM_VALUE.COLLECT { MODELPARAM_VALUE.COLLECT PARAM_VALUE.COLLECT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLLECT}] ${MODELPARAM_VALUE.COLLECT}
}

proc update_MODELPARAM_VALUE.RESULT { MODELPARAM_VALUE.RESULT PARAM_VALUE.RESULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RESULT}] ${MODELPARAM_VALUE.RESULT}
}

proc update_MODELPARAM_VALUE.STORE { MODELPARAM_VALUE.STORE PARAM_VALUE.STORE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.STORE}] ${MODELPARAM_VALUE.STORE}
}

proc update_MODELPARAM_VALUE.CHECK { MODELPARAM_VALUE.CHECK PARAM_VALUE.CHECK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CHECK}] ${MODELPARAM_VALUE.CHECK}
}

proc update_MODELPARAM_VALUE.CONF { MODELPARAM_VALUE.CONF PARAM_VALUE.CONF } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CONF}] ${MODELPARAM_VALUE.CONF}
}

