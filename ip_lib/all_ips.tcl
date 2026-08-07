##################################################################
# CHECK VIVADO VERSION
##################################################################

set scripts_vivado_version 2020.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
  catch {common::send_msg_id "IPS_TCL-100" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_ip_tcl to create an updated script."}
  return 1
}

##################################################################
# START
##################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source all_ips.tcl
# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./depthwise/depthwise.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
  create_project depthwise depthwise -part xczu3eg-sbva484-1-e
  set_property BOARD_PART em.avnet.com:ultra96v2:part0:1.0 [current_project]
  set_property target_language Verilog [current_project]
  set_property simulator_language Mixed [current_project]
}

##################################################################
# CHECK IPs
##################################################################

set bCheckIPs 1
set bCheckIPsPassed 1
if { $bCheckIPs == 1 } {
  set list_check_ips { xilinx.com:ip:blk_mem_gen:8.4 xilinx.com:ip:clk_wiz:6.0 xilinx.com:ip:xbip_dsp48_macro:3.0 }
  set list_ips_missing ""
  common::send_msg_id "IPS_TCL-1001" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

  foreach ip_vlnv $list_check_ips {
  set ip_obj [get_ipdefs -all $ip_vlnv]
  if { $ip_obj eq "" } {
    lappend list_ips_missing $ip_vlnv
    }
  }

  if { $list_ips_missing ne "" } {
    catch {common::send_msg_id "IPS_TCL-105" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
    set bCheckIPsPassed 0
  }
}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "IPS_TCL-102" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 1
}

##################################################################
# blk_mem_gen_0 FILES
##################################################################

proc write_blk_mem_gen_weight_144x384_all1 { blk_mem_gen_weight_144x384_all1_filepath } {
  set blk_mem_gen_weight_144x384_all1 [open $blk_mem_gen_weight_144x384_all1_filepath  w+]

  puts $blk_mem_gen_weight_144x384_all1 {; depth_mac weight ROM}
  puts $blk_mem_gen_weight_144x384_all1 {; 144 bit x 384 word  (1 word = 1 channel = k8 k7 k6 k5 k4 k3 k2 k1 k0)}
  puts $blk_mem_gen_weight_144x384_all1 {; weight[i*16 +: 16] = k[i]  ->  MSB 쪽이 k8, LSB 쪽이 k0}
  puts $blk_mem_gen_weight_144x384_all1 {; 값: 전부 1 (tb_depth_mac.sv 의 weight = {9{16'sd1}} 와 동일)}
  puts $blk_mem_gen_weight_144x384_all1 {memory_initialization_radix=16;}
  puts $blk_mem_gen_weight_144x384_all1 {memory_initialization_vector=}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001,}
  puts $blk_mem_gen_weight_144x384_all1 {000100010001000100010001000100010001;}

  flush $blk_mem_gen_weight_144x384_all1
  close $blk_mem_gen_weight_144x384_all1
}

##################################################################
# CREATE IP blk_mem_gen_0
##################################################################

set blk_mem_gen_0 [create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name blk_mem_gen_0]

write_blk_mem_gen_weight_144x384_all1  [file join [get_property IP_DIR [get_ips blk_mem_gen_0]] weight_144x384_all1.coe]
set_property -dict { 
  CONFIG.Memory_Type {Single_Port_ROM}
  CONFIG.Write_Width_A {144}
  CONFIG.Write_Depth_A {384}
  CONFIG.Read_Width_A {144}
  CONFIG.Operating_Mode_A {WRITE_FIRST}
  CONFIG.Write_Width_B {144}
  CONFIG.Read_Width_B {144}
  CONFIG.Enable_B {Always_Enabled}
  CONFIG.Register_PortA_Output_of_Memory_Primitives {true}
  CONFIG.Register_PortB_Output_of_Memory_Primitives {false}
  CONFIG.Load_Init_File {true}
  CONFIG.Coe_File {weight_144x384_all1.coe}
  CONFIG.Port_A_Write_Rate {0}
  CONFIG.Port_B_Clock {0}
  CONFIG.Port_B_Enable_Rate {0}
} [get_ips blk_mem_gen_0]

set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $blk_mem_gen_0

##################################################################

##################################################################
# CREATE IP clk_wiz_0
##################################################################

set clk_wiz_0 [create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name clk_wiz_0]

set_property -dict { 
  CONFIG.PRIM_IN_FREQ {40.000}
  CONFIG.CLKIN1_JITTER_PS {250.0}
  CONFIG.USE_RESET {false}
  CONFIG.MMCM_CLKFBOUT_MULT_F {30.000}
  CONFIG.MMCM_CLKIN1_PERIOD {25.000}
  CONFIG.MMCM_CLKIN2_PERIOD {10.0}
  CONFIG.CLKOUT1_JITTER {152.933}
  CONFIG.CLKOUT1_PHASE_ERROR {166.174}
} [get_ips clk_wiz_0]

set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $clk_wiz_0

##################################################################

##################################################################
# CREATE IP dsp48_mac
##################################################################

set dsp48_mac [create_ip -name xbip_dsp48_macro -vendor xilinx.com -library ip -version 3.0 -module_name dsp48_mac]

set_property -dict { 
  CONFIG.instruction1 {ACIN*B+PCIN}
  CONFIG.pipeline_options {Automatic}
  CONFIG.areg_3 {true}
  CONFIG.areg_4 {true}
  CONFIG.breg_3 {true}
  CONFIG.breg_4 {true}
  CONFIG.creg_3 {false}
  CONFIG.creg_4 {false}
  CONFIG.creg_5 {false}
  CONFIG.mreg_5 {true}
  CONFIG.preg_6 {true}
  CONFIG.d_width {18}
  CONFIG.a_width {27}
  CONFIG.a_binarywidth {0}
  CONFIG.b_width {16}
  CONFIG.b_binarywidth {0}
  CONFIG.concat_width {48}
  CONFIG.concat_binarywidth {0}
  CONFIG.c_binarywidth {0}
  CONFIG.pcin_binarywidth {0}
  CONFIG.has_acout {true}
  CONFIG.has_pcout {true}
  CONFIG.has_a_ce {false}
} [get_ips dsp48_mac]

set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $dsp48_mac

##################################################################

##################################################################
# CREATE IP dsp48_mac_last
##################################################################

set dsp48_mac_last [create_ip -name xbip_dsp48_macro -vendor xilinx.com -library ip -version 3.0 -module_name dsp48_mac_last]

set_property -dict { 
  CONFIG.instruction1 {ACIN*B+PCIN}
  CONFIG.areg_3 {true}
  CONFIG.areg_4 {true}
  CONFIG.breg_3 {true}
  CONFIG.breg_4 {true}
  CONFIG.creg_3 {false}
  CONFIG.creg_4 {false}
  CONFIG.creg_5 {false}
  CONFIG.mreg_5 {true}
  CONFIG.preg_6 {true}
  CONFIG.d_width {18}
  CONFIG.a_width {27}
  CONFIG.a_binarywidth {0}
  CONFIG.b_width {16}
  CONFIG.b_binarywidth {0}
  CONFIG.concat_width {48}
  CONFIG.concat_binarywidth {0}
  CONFIG.c_binarywidth {0}
  CONFIG.pcin_binarywidth {0}
} [get_ips dsp48_mac_last]

set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $dsp48_mac_last

##################################################################

##################################################################
# CREATE IP dsp48_mul
##################################################################

set dsp48_mul [create_ip -name xbip_dsp48_macro -vendor xilinx.com -library ip -version 3.0 -module_name dsp48_mul]

set_property -dict { 
  CONFIG.instruction1 {A*B}
  CONFIG.pipeline_options {Automatic}
  CONFIG.areg_3 {true}
  CONFIG.areg_4 {true}
  CONFIG.breg_3 {true}
  CONFIG.breg_4 {true}
  CONFIG.creg_3 {false}
  CONFIG.creg_4 {false}
  CONFIG.creg_5 {false}
  CONFIG.mreg_5 {true}
  CONFIG.preg_6 {true}
  CONFIG.d_width {18}
  CONFIG.a_width {16}
  CONFIG.a_binarywidth {0}
  CONFIG.b_width {16}
  CONFIG.b_binarywidth {0}
  CONFIG.concat_width {48}
  CONFIG.concat_binarywidth {0}
  CONFIG.c_binarywidth {0}
  CONFIG.pcin_binarywidth {0}
  CONFIG.output_properties {User_Defined}
  CONFIG.p_full_width {32}
  CONFIG.p_width {48}
  CONFIG.p_binarywidth {0}
  CONFIG.has_acout {true}
  CONFIG.has_pcout {true}
} [get_ips dsp48_mul]

set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $dsp48_mul

##################################################################

