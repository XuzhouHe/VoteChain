
################################################################
# This is a generated script based on design: votechain1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2018.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source votechain1_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# BRAM, button_debounce, controller, data_mining, data_validation

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z020clg484-1
   set_property BOARD_PART digilentinc.com:zedboard:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name votechain1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set BTNC_0 [ create_bd_port -dir I BTNC_0 ]
  set BTND_0 [ create_bd_port -dir I BTND_0 ]
  set BTNL_0 [ create_bd_port -dir I BTNL_0 ]
  set BTNR_0 [ create_bd_port -dir I BTNR_0 ]
  set BTNU_0 [ create_bd_port -dir I BTNU_0 ]
  set LD_0 [ create_bd_port -dir O -from 7 -to 0 LD_0 ]
  set S_AXI_ARESETN_0 [ create_bd_port -dir I -type rst S_AXI_ARESETN_0 ]
  set clk [ create_bd_port -dir I -type clk clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
 ] $clk
  set receiving_0 [ create_bd_port -dir I receiving_0 ]
  set system_onQ_0 [ create_bd_port -dir I system_onQ_0 ]
  set user_ID_0 [ create_bd_port -dir I -from 7 -to 0 user_ID_0 ]

  # Create instance: BRAM_0, and set properties
  set block_name BRAM
  set block_cell_name BRAM_0
  if { [catch {set BRAM_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $BRAM_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: button_debounce_0, and set properties
  set block_name button_debounce
  set block_cell_name button_debounce_0
  if { [catch {set button_debounce_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $button_debounce_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: controller_0, and set properties
  set block_name controller
  set block_cell_name controller_0
  if { [catch {set controller_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $controller_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: data_mining_0, and set properties
  set block_name data_mining
  set block_cell_name data_mining_0
  if { [catch {set data_mining_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $data_mining_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: data_validation_0, and set properties
  set block_name data_validation
  set block_cell_name data_validation_0
  if { [catch {set data_validation_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $data_validation_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net BRAM_0_config_bram_done [get_bd_pins BRAM_0/config_bram_done] [get_bd_pins controller_0/config_bram_done]
  connect_bd_net -net BRAM_0_dm_read_data [get_bd_pins BRAM_0/dm_read_data] [get_bd_pins data_mining_0/dm_read_data]
  connect_bd_net -net BTNC_0_1 [get_bd_ports BTNC_0] [get_bd_pins button_debounce_0/BTNC]
  connect_bd_net -net BTND_0_1 [get_bd_ports BTND_0] [get_bd_pins button_debounce_0/BTND]
  connect_bd_net -net BTNL_0_1 [get_bd_ports BTNL_0] [get_bd_pins button_debounce_0/BTNL]
  connect_bd_net -net BTNR_0_1 [get_bd_ports BTNR_0] [get_bd_pins button_debounce_0/BTNR]
  connect_bd_net -net BTNU_0_1 [get_bd_ports BTNU_0] [get_bd_pins button_debounce_0/BTNU]
  connect_bd_net -net S_AXI_ACLK_0_1 [get_bd_ports clk] [get_bd_pins BRAM_0/S_AXI_ACLK] [get_bd_pins button_debounce_0/clk] [get_bd_pins controller_0/S_AXI_ACLK] [get_bd_pins data_mining_0/S_AXI_ACLK] [get_bd_pins data_validation_0/S_AXI_ACLK]
  connect_bd_net -net S_AXI_ARESETN_0_1 [get_bd_ports S_AXI_ARESETN_0] [get_bd_pins BRAM_0/S_AXI_ARESETN] [get_bd_pins button_debounce_0/rst] [get_bd_pins controller_0/S_AXI_ARESETN] [get_bd_pins data_mining_0/S_AXI_ARESETN] [get_bd_pins data_validation_0/S_AXI_ARESETN]
  connect_bd_net -net button_debounce_0_votes [get_bd_pins button_debounce_0/votes] [get_bd_pins data_validation_0/vote]
  connect_bd_net -net controller_0_bram_addr [get_bd_pins BRAM_0/controller_addr] [get_bd_pins controller_0/bram_addr]
  connect_bd_net -net controller_0_bram_data [get_bd_pins BRAM_0/controller_data] [get_bd_pins controller_0/bram_data]
  connect_bd_net -net controller_0_configQ [get_bd_pins BRAM_0/configQ] [get_bd_pins controller_0/configQ] [get_bd_pins data_mining_0/configQ] [get_bd_pins data_validation_0/configQ]
  connect_bd_net -net controller_0_control_ena [get_bd_pins BRAM_0/controller_ena] [get_bd_pins controller_0/control_ena]
  connect_bd_net -net controller_0_enableDM_Q [get_bd_pins controller_0/enableDM_Q] [get_bd_pins data_mining_0/enableDM_Q]
  connect_bd_net -net controller_0_enableDV_Q [get_bd_pins controller_0/enableDV_Q] [get_bd_pins data_validation_0/enableDV_Q]
  connect_bd_net -net data_mining_0_bram_addrQ [get_bd_pins BRAM_0/dm_addr] [get_bd_pins data_mining_0/bram_addrQ]
  connect_bd_net -net data_mining_0_bram_data [get_bd_pins BRAM_0/dm_data] [get_bd_pins data_mining_0/bram_dataQ]
  connect_bd_net -net data_mining_0_dm_done [get_bd_pins BRAM_0/dm_done] [get_bd_pins controller_0/dm_done] [get_bd_pins data_mining_0/dm_done]
  connect_bd_net -net data_mining_0_dm_enaQ [get_bd_pins BRAM_0/dm_ena] [get_bd_pins data_mining_0/dm_enaQ]
  connect_bd_net -net data_mining_0_dm_read_addr [get_bd_pins BRAM_0/dm_read_addr] [get_bd_pins data_mining_0/dm_read_addr]
  connect_bd_net -net data_validation_0_LD [get_bd_ports LD_0] [get_bd_pins data_validation_0/LD]
  connect_bd_net -net data_validation_0_bram_addr [get_bd_pins BRAM_0/dv_addr] [get_bd_pins data_validation_0/bram_addrQ]
  connect_bd_net -net data_validation_0_bram_data [get_bd_pins BRAM_0/dv_data] [get_bd_pins data_validation_0/bram_dataQ]
  connect_bd_net -net data_validation_0_config_dv_done [get_bd_pins controller_0/config_dv_done] [get_bd_pins data_validation_0/config_dv_done]
  connect_bd_net -net data_validation_0_dv_done [get_bd_pins controller_0/dv_done] [get_bd_pins data_validation_0/dv_done]
  connect_bd_net -net data_validation_0_dv_ena [get_bd_pins BRAM_0/dv_ena] [get_bd_pins data_validation_0/dv_enaQ]
  connect_bd_net -net data_validation_0_getVoteQ [get_bd_pins button_debounce_0/getVote] [get_bd_pins data_validation_0/getVoteQ]
  connect_bd_net -net receiving_0_1 [get_bd_ports receiving_0] [get_bd_pins controller_0/receiving]
  connect_bd_net -net system_onQ_0_1 [get_bd_ports system_onQ_0] [get_bd_pins controller_0/system_onQ]
  connect_bd_net -net user_ID_0_1 [get_bd_ports user_ID_0] [get_bd_pins data_validation_0/user_ID]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


