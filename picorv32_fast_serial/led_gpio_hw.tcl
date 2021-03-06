# TCL File Generated by Component Editor 18.1
# Fri Feb 28 15:47:49 CST 2020
# DO NOT MODIFY


# 
# led_gpio "led_gpio" v1.0
#  2020.02.28.15:47:48
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module led_gpio
# 
set_module_property DESCRIPTION ""
set_module_property NAME led_gpio
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME led_gpio
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL led_gpio
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file led_gpio.v VERILOG PATH led_gpio.v TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point avs_s0
# 
add_interface avs_s0 avalon end
set_interface_property avs_s0 addressUnits WORDS
set_interface_property avs_s0 associatedClock clock
set_interface_property avs_s0 associatedReset reset
set_interface_property avs_s0 bitsPerSymbol 8
set_interface_property avs_s0 bridgedAddressOffset 0
set_interface_property avs_s0 burstOnBurstBoundariesOnly false
set_interface_property avs_s0 burstcountUnits WORDS
set_interface_property avs_s0 explicitAddressSpan 0
set_interface_property avs_s0 holdTime 0
set_interface_property avs_s0 linewrapBursts false
set_interface_property avs_s0 maximumPendingReadTransactions 1
set_interface_property avs_s0 maximumPendingWriteTransactions 0
set_interface_property avs_s0 readLatency 0
set_interface_property avs_s0 readWaitTime 1
set_interface_property avs_s0 setupTime 0
set_interface_property avs_s0 timingUnits Cycles
set_interface_property avs_s0 writeWaitTime 0
set_interface_property avs_s0 ENABLED true
set_interface_property avs_s0 EXPORT_OF ""
set_interface_property avs_s0 PORT_NAME_MAP ""
set_interface_property avs_s0 CMSIS_SVD_VARIABLES ""
set_interface_property avs_s0 SVD_ADDRESS_GROUP ""

add_interface_port avs_s0 avs_s0_address address Input 2
add_interface_port avs_s0 avs_s0_read read Input 1
add_interface_port avs_s0 avs_s0_readdata readdata Output 32
add_interface_port avs_s0 avs_s0_readdatavalid readdatavalid Output 1
add_interface_port avs_s0 avs_s0_write write Input 1
add_interface_port avs_s0 avs_s0_writedata writedata Input 32
add_interface_port avs_s0 avs_s0_waitrequest waitrequest Output 1
add_interface_port avs_s0 avs_s0_byteenable byteenable Input 4
add_interface_port avs_s0 avs_s0_chipselect chipselect Input 1
set_interface_assignment avs_s0 embeddedsw.configuration.isFlash 0
set_interface_assignment avs_s0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avs_s0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avs_s0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clock_clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_reset reset Input 1


# 
# connection point led_gpio
# 
add_interface led_gpio conduit end
set_interface_property led_gpio associatedClock clock
set_interface_property led_gpio associatedReset ""
set_interface_property led_gpio ENABLED true
set_interface_property led_gpio EXPORT_OF ""
set_interface_property led_gpio PORT_NAME_MAP ""
set_interface_property led_gpio CMSIS_SVD_VARIABLES ""
set_interface_property led_gpio SVD_ADDRESS_GROUP ""

add_interface_port led_gpio led led_signal Output 8

