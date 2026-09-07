# ==============================================================================
# Clocks & Reset
# ==============================================================================
set_location_assignment PIN_AF14 -to clk_50
set_location_assignment PIN_AJ4  -to rstn

# ==============================================================================
# Switches
# ==============================================================================
set_location_assignment PIN_AB30 -to i_switch[0]
set_location_assignment PIN_Y27  -to i_switch[1]
set_location_assignment PIN_AB28 -to i_switch[2]

# ==============================================================================
# VGA Sync & Control
# ==============================================================================
set_location_assignment PIN_AK19 -to h_sync
set_location_assignment PIN_AK18 -to v_sync
set_location_assignment PIN_AK21 -to vga_clk
set_location_assignment PIN_AK22 -to vga_blank_N
set_location_assignment PIN_AJ22 -to vga_sync_N

# ==============================================================================
# VGA Red [7:0]
# ==============================================================================
set_location_assignment PIN_AK29 -to red[0]
set_location_assignment PIN_AK28 -to red[1]
set_location_assignment PIN_AK27 -to red[2]
set_location_assignment PIN_AJ27 -to red[3]
set_location_assignment PIN_AH27 -to red[4]
set_location_assignment PIN_AF26 -to red[5]
set_location_assignment PIN_AG26 -to red[6]
set_location_assignment PIN_AJ26 -to red[7]

# ==============================================================================
# VGA Green [7:0]
# ==============================================================================
set_location_assignment PIN_AK26 -to green[0]
set_location_assignment PIN_AJ25 -to green[1]
set_location_assignment PIN_AH25 -to green[2]
set_location_assignment PIN_AK24 -to green[3]
set_location_assignment PIN_AJ24 -to green[4]
set_location_assignment PIN_AH24 -to green[5]
set_location_assignment PIN_AK23 -to green[6]
set_location_assignment PIN_AH23 -to green[7]

# ==============================================================================
# VGA Blue [7:0]
# ==============================================================================
set_location_assignment PIN_AJ21 -to blue[0]
set_location_assignment PIN_AJ20 -to blue[1]
set_location_assignment PIN_AH20 -to blue[2]
set_location_assignment PIN_AJ19 -to blue[3]
set_location_assignment PIN_AH19 -to blue[4]
set_location_assignment PIN_AJ17 -to blue[5]
set_location_assignment PIN_AJ16 -to blue[6]
set_location_assignment PIN_AK16 -to blue[7]