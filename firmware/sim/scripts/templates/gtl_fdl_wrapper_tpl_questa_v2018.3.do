
##***************************** Beginning of Script ***************************

## If MTI_LIBS is defined, map unisim and simprim directories using MTI_LIBS
## This mode of mapping the unisims libraries is provided for backward
## compatibility with previous wizard releases. If you don't set MTI_LIBS
## the unisim libraries will be loaded from the paths set up by compxlib in
## your modelsim.ini file

## HB 2019-04-12: setting of XILINX not clear! Not needed, removed!
#set XILINX   $env(XILINX)

if [info exists env(MTI_LIBS)] {
    set MTI_LIBS $env(MTI_LIBS)
    vlib UNISIM
    vlib SECUREIP
    vmap UNISIM $MTI_LIBS/unisim
    vmap SECUREIP $MTI_LIBS/secureip
}

## set your src files directory for your design

set MP7_COMPONENTS {{MP7_TAG}}/components
set VIEW_WAVE {{VIEW_WAVE}}

set HDL_DIR {{SIM_DIR}}/../hdl
set NGC_DIR {{SIM_DIR}}/../ngc
set TB_DIR {{SIM_DIR}}/testbench
set MENU_DIR {{MENU_DIR}}
set MOD_TB_DIR {{MOD_TB_DIR}}
set FILE_NAME {{MENU_DIR}}/../running.lock

## Create and map work directory
vlib work
vmap work work

##Design files
vcom -93 -work work $MP7_COMPONENTS/mp7_datapath/firmware/hdl/mp7_data_types.vhd
vcom -93 -work work $MP7_COMPONENTS/ipbus_core/firmware/hdl/ipbus_package.vhd
vcom -93 -work work $MP7_COMPONENTS/ipbus_core/firmware/hdl/ipbus_trans_decl.vhd
vcom -93 -work work $MENU_DIR/l1menu_pkg.vhd
vcom -93 -work work $HDL_DIR/packages/lhc_data_pkg.vhd
vcom -93 -work work $HDL_DIR/packages/math_pkg.vhd
vcom -93 -work work $HDL_DIR/packages/top_decl_sim.vhd
vcom -93 -work work $HDL_DIR/packages/gt_mp7_core_pkg.vhd
vcom -93 -work work $HDL_DIR/packages/gtl_pkg.vhd
#vcom -93 -work work $HDL_DIR/packages/fdl_pkg.vhd
vcom -93 -work work $HDL_DIR/packages/fdl_pkg_prescale_float.vhd
#vcom -93 -work work $HDL_DIR/packages/fdl_pkg_prescale_num_denom.vhd
vcom -93 -work work $HDL_DIR/packages/lut_pkg.vhd
vcom -93 -work work $HDL_DIR/packages/fdl_addr_decode.vhd
vcom -93 -work work $TB_DIR/lhc_data_debug_util_pkg.vhd
vcom -93 -work work $TB_DIR/txt_util_pkg.vhd

vcom -93 -work work $HDL_DIR/data/gtl/reg_mux.vhd
vcom -93 -work work $HDL_DIR/data/gtl/delay_pipeline.vhd
vcom -93 -work work $HDL_DIR/data/gtl/conversions.vhd
vcom -93 -work work $HDL_DIR/data/gtl/bx_pipeline.vhd
vcom -93 -work work $HDL_DIR/data/gtl/comp_unsigned.vhd
vcom -93 -work work $HDL_DIR/data/gtl/comp_signed.vhd
vcom -93 -work work $HDL_DIR/data/gtl/lut_comparator.vhd
vcom -93 -work work $HDL_DIR/data/gtl/comparators_obj_cuts.vhd
vcom -93 -work work $HDL_DIR/data/gtl/comparators_corr_cuts.vhd
vcom -93 -work work $HDL_DIR/data/gtl/comparators_muon_charge_corr.vhd
vcom -93 -work work $HDL_DIR/data/gtl/combinatorial_conditions.vhd
vcom -93 -work work $HDL_DIR/data/gtl/combinatorial_conditions_ovrm.vhd
vcom -93 -work work $HDL_DIR/data/gtl/correlation_conditions.vhd
vcom -93 -work work $HDL_DIR/data/gtl/correlation_conditions_ovrm.vhd

## HB 2019-01-11: used for less amount of resources
vcom -93 -work work $HDL_DIR/data/gtl/luts_corr_cuts.vhd
vcom -93 -work work $HDL_DIR/data/gtl/deta_calc.vhd
vcom -93 -work work $HDL_DIR/data/gtl/deta_lut.vhd
vcom -93 -work work $HDL_DIR/data/gtl/cosh_deta_lut.vhd
vcom -93 -work work $HDL_DIR/data/gtl/dphi_calc.vhd
vcom -93 -work work $HDL_DIR/data/gtl/dphi_lut.vhd
vcom -93 -work work $HDL_DIR/data/gtl/cos_dphi_lut.vhd

vcom -93 -work work $HDL_DIR/data/gtl/delta_r_calc.vhd
vcom -93 -work work $HDL_DIR/data/gtl/delta_r.vhd
vcom -93 -work work $HDL_DIR/data/gtl/inv_mass_calc.vhd
vcom -93 -work work $HDL_DIR/data/gtl/invariant_mass.vhd
vcom -93 -work work $HDL_DIR/data/gtl/transverse_mass.vhd
vcom -93 -work work $HDL_DIR/data/gtl/twobody_pt_calc.vhd
vcom -93 -work work $HDL_DIR/data/gtl/twobody_pt.vhd
vcom -93 -work work $HDL_DIR/data/gtl/muon_charge_correlations.vhd

vcom -93 -work work $MENU_DIR/l1menu.vhd
vcom -93 -work work $HDL_DIR/data/gtl/gtl_module.vhd
vcom -93 -work work $HDL_DIR/control/delay_element.vhd
vcom -93 -work work $HDL_DIR/data/fdl/update_process.vhd
vcom -93 -work work $HDL_DIR/data/fdl/pulse_converter.vhd
vcom -93 -work work $HDL_DIR/data/fdl/fdl_fabric.vhd
#vcom -93 -work work $HDL_DIR/data/fdl/algo_pre_scaler.vhd
#vcom -93 -work work $HDL_DIR/data/fdl/algo_pre_scaler_fractional_pkg.vhd
#vcom -93 -work work $HDL_DIR/data/fdl/algo_pre_scaler_fractional.vhd
#vcom -93 -work work $HDL_DIR/data/fdl/algo_pre_scaler_fractional_num_denom.vhd
vcom -93 -work work $HDL_DIR/data/fdl/algo_pre_scaler_fractional_float.vhd
vcom -93 -work work $HDL_DIR/data/fdl/algo_rate_counter.vhd
vcom -93 -work work $HDL_DIR/data/fdl/algo_post_dead_time_counter.vhd
vcom -93 -work work $HDL_DIR/data/fdl/algo_slice.vhd
#vcom -93 -work work $NGC_DIR/dp_mem_4096x32/dp_mem_4096x32.vhd
vcom -93 -work work $NGC_DIR/dp_mem_4096x32_blk_mem_gen_v8_4_2/synth/dp_mem_4096x32.vhd
vcom -93 -work work $HDL_DIR/ipbus/ipb_dpmem_4096_32.vhd
vcom -93 -work work $HDL_DIR/ipbus/ipb_read_regs.vhd
vcom -93 -work work $HDL_DIR/ipbus/ipb_write_regs.vhd
vcom -93 -work work $HDL_DIR/ipbus/ipb_pulse_regs.vhd
vcom -93 -work work $HDL_DIR/data/fdl/algo_mapping_rop.vhd
vcom -93 -work work $HDL_DIR/data/fdl/fdl_module.vhd
vcom -93 -work work $HDL_DIR/data/gtl_fdl_wrapper.vhd

##TB_DIR
vcom -93 -work work $MOD_TB_DIR/gtl_fdl_wrapper_tb.vhd

##Load Design
vsim -t 1ps work.gtl_fdl_wrapper_TB

if {$VIEW_WAVE} {
   #Load signals in wave window
   view wave
   do $TB_DIR/../scripts/gtl_fdl_wrapper_test_wave.do
}
set fileId [open $FILE_NAME "w"]
close $fileId
##Run simulation
run 91000 ns

# eof
