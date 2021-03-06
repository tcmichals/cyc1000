# TCL File Generated by Component Editor 18.1
# Tue Dec 17 21:33:10 CST 2019
# DO NOT MODIFY


# 
# gpio_led "gpio_led" v1.1
#  2019.12.17.21:33:10
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module gpio_led
# 
set_module_property DESCRIPTION ""
set_module_property NAME gpio_led
set_module_property VERSION 1.1
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME gpio_led
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL gpio_led
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file gpio_led.v VERILOG PATH gpio_led.v TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


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
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock
set_interface_property conduit_end associatedReset ""
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end led_signal_0 led_0 Output 1
add_interface_port conduit_end led_signal_1 led_1 Output 1
add_interface_port conduit_end led_signal_2 led_2 Output 1
add_interface_port conduit_end led_signal_3 led_3 Output 1
add_interface_port conduit_end led_signal_4 led_4 Output 1
add_interface_port conduit_end led_signal_5 led_5 Output 1
add_interface_port conduit_end led_signal_6 led_6 Output 1
add_interface_port conduit_end led_signal_7 led_7 Output 1


# 
# connection point avs_slave
# 
add_interface avs_slave avalon end
set_interface_property avs_slave addressUnits WORDS
set_interface_property avs_slave associatedClock clock
set_interface_property avs_slave associatedReset reset
set_interface_property avs_slave bitsPerSymbol 8
set_interface_property avs_slave bridgedAddressOffset 0
set_interface_property avs_slave burstOnBurstBoundariesOnly false
set_interface_property avs_slave burstcountUnits WORDS
set_interface_property avs_slave explicitAddressSpan 0
set_interface_property avs_slave holdTime 0
set_interface_property avs_slave linewrapBursts false
set_interface_property avs_slave maximumPendingReadTransactions 0
set_interface_property avs_slave maximumPendingWriteTransactions 0
set_interface_property avs_slave readLatency 0
set_interface_property avs_slave readWaitTime 1
set_interface_property avs_slave setupTime 0
set_interface_property avs_slave timingUnits Cycles
set_interface_property avs_slave writeWaitTime 0
set_interface_property avs_slave ENABLED true
set_interface_property avs_slave EXPORT_OF ""
set_interface_property avs_slave PORT_NAME_MAP ""
set_interface_property avs_slave CMSIS_SVD_VARIABLES ""
set_interface_property avs_slave SVD_ADDRESS_GROUP ""

add_interface_port avs_slave avs_s1_address address Input 2
add_interface_port avs_slave avs_s1_write write Input 1
add_interface_port avs_slave avs_s1_writedata writedata Input 32
add_interface_port avs_slave avs_s1_waitrequest waitrequest Output 1
set_interface_assignment avs_slave embeddedsw.configuration.isFlash 0
set_interface_assignment avs_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avs_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avs_slave embeddedsw.configuration.isPrintableDevice 0

