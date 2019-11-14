## Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

================================

Versions of ugt with new GTL structure (v2.0.0 and higher)

### [v2.4.5] - 2019-11-14

#### Comment

- mp7_ugt firmware release v2.4.5 (bugs fixed in scripts)

#### Changed
- source file:
  - ../hdl/packages/gt_mp7_core_pkg.vhd
- script:
  - ../scripts/runIpbbSynth.py
  - ../scripts/fwpackerIpbb.py
  - ../scripts/buildReport.py
  - ../scripts/checkIpbbSynth.py

### [v2.4.4] - 2019-11-12

#### Comment

- mp7_ugt firmware release v2.4.4 (bug fixed in "function bx")

#### Changed
- file name:
  - ../hdl/packages/gtl_pkg.vhd
  
### [v2.4.3] - 2019-11-11

#### Comment

- mp7_ugt firmware release v2.4.3 (bugs fixed)

#### Added
- simulation do files:
  - ../sim/scripts/templates/gtl_fdl_wrapper_tpl_questa_v2019.2.do

#### Changed
- file name:
  - ../hdl/packages/gtl_pkg.vhd
- script:
  - ../scripts/run_compile_simlib.py

### [v2.4.2] - 2019-11-04

#### Comment

- mp7_ugt firmware release v2.4.2

#### Changed
- file name:
  - ../hdl/data/gtl/comparator_muon_charge_corr.vhd to ../hdl/data/gtl/comparators_muon_charge_corr.vhd
  - ../hdl/data/gtl/sub_eta.vhd to ../hdl/data/gtl/deta_calc.vhd
  - ../hdl/data/gtl/sub_phi.vhd to ../hdl/data/gtl/dphi_calc.vhd
  - ../hdl/data/gtl/diff_eta_lut.vhd to ../hdl/data/gtl/deta_lut.vhd
  - ../hdl/data/gtl/diff_phi_lut.vhd to ../hdl/data/gtl/dphi_lut.vhd
- source file:
  - ../hdl/data/gtl/muon_charge_correlations.vhd
  - ../hdl/data/gtl/comparators_muon_charge_corr.vhd
  - ../hdl/packages/gt_mp7_core_pkg.vhd
- simulation do files:
  - ../sim/scripts/templates/gtl_fdl_wrapper_tpl_questa_v2018.3.do
  - ../sim/scripts/templates/gtl_fdl_wrapper_tpl_questa_v2019.1.do
- synthesis dep file:
  - ../cfg/uGT_algo.dep

### [v2.4.1] - 2019-10-23

#### Comment

- mp7_ugt firmware release v2.4.1 (bug fixed in script)

#### Changed
- script:
  - ../scripts/runIpbbSynth.py

### [v2.4.0] - 2019-10-22

#### Comment

- mp7_ugt firmware release v2.4.0 (new condition: combinatorial_conditions_ovrm.vhd, updated two-body pt features)

- moved files from directory mp7_ugt to ugt 

#### Added
- source file:
  - ../hdl/data/gtl/combinatorial_conditions_ovrm.vhd

#### Changed
- source file:
  - ../hdl/data/gtl/twobody_pt_calc.vhd
- script:
  - ../scripts/runIpbbSynth.py

### [v2.3.2] - 2019-10-11

#### Comment

- mp7_ugt firmware release v2.3.2 (32 bits for fractional prescaler, two different implementation in repo)

- deleted amc502_extcond, amc502_finor, amc502_finor_pre and mp7_tdf from repo
- future developments for amc502 firmwares at: 
  - "https://github.com/cms-l1-globaltrigger/amc502_extcond"
  - "https://github.com/cms-l1-globaltrigger/amc502_finor"
  - "https://github.com/cms-l1-globaltrigger/amc502_finor_pre"

#### Added
- source files:
  - ../hdl/data/fdl/algo_pre_scaler_fractional_float.vhd
  - ../hdl/data/fdl/algo_pre_scaler_fractional_num_denom.vhd
  - ../hdl/packages/fdl_pkg_prescale_float.vhd
  - ../hdl/packages/fdl_pkg_prescale_float_sim.vhd
  - ../hdl/packages/fdl_pkg_prescale_num_denom.vhd
  - ../hdl/packages/fdl_pkg_prescale_num_denom_sim.vhd
- simulation do files:
  - ../sim/scripts/algo_pre_scaler_fractional_float.do
  - ../sim/scripts/algo_pre_scaler_fractional_float_wave.do
  - ../sim/scripts/algo_pre_scaler_fractional_num_denom.do
  - ../sim/scripts/algo_pre_scaler_fractional_num_denom_wave.do
- simulation testbench files:
  - ../sim/testbench/algo_pre_scaler_fractional_float_tb.vhd
  - ../sim/testbench/algo_pre_scaler_fractional_num_denom_tb.vhd

#### Changed
- tag name to release version
- source files:
  - ../hdl/data/fdl/fdl_module.vhd
  - ../hdl/data/fdl/algo_slice.vhd
  - ../hdl/packages/fdl_pkg.vhd
  - ../hdl/packages/gt_mp7_core_pkg.vhd
- simulation do files:
  - ../sim/scripts/templates/gtl_fdl_wrapper_tpl_questa_v2018.2.do
  - ../sim/scripts/templates/gtl_fdl_wrapper_tpl_questa_v2018.3.do
  - ../sim/scripts/templates/gtl_fdl_wrapper_tpl_questa_v2019.1.do
- synthesis dep file:
  - ../cfg/uGT_algo.dep

### [mp7_ugt_v2_3_1] - 2019-09-27

#### Comment
- mp7_ugt firmware release v2.3.1

#### Changed
- source files:
  - ../hdl/packages/gt_mp7_core_pkg.vhd

### [mp7_ugt_v2_3_0] - 2019-09-26

#### Comment
- mp7_ugt firmware release v2.3.0

#### Added
- source files:
  - ../hdl/data/gtl/comparator_muon_cc_double.vhd
  - ../hdl/data/gtl/comparator_muon_cc_triple.vhd
  - ../hdl/data/gtl/comparator_muon_cc_quad.vhd
  - ../hdl/data/gtl/delta_r_calc.vhd
  - ../hdl/data/gtl/correlation_conditions_ovrm.vhd

#### Changed
- source files:
  - ../hdl/data/gtl/conversions.vhd
  - ../hdl/data/gtl/comparator_muon_charge_corr.vhd
  - ../hdl/data/gtl/comparators_obj_cuts.vhd
  - ../hdl/data/gtl/invariant_mass.vhd
  - ../hdl/data/gtl/inv_mass_calc.vhd
  - ../hdl/data/gtl/combinatorial_conditions.vhd
  - ../hdl/data/gtl/comparators_corr_cuts.vhd
  - ../hdl/data/gtl/comparators_obj_cuts.vhd
  - ../hdl/data/gtl/cos_dphi_lut.vhd
  - ../hdl/data/gtl/cosh_deta_lut.vhd
  - ../hdl/data/gtl/diff_eta_lut.vhd
  - ../hdl/data/gtl/diff_phi_lut.vhd
  - ../hdl/data/gtl/sub_eta.vhd
  - ../hdl/data/gtl/sub_phi.vhd
  - ../hdl/packages/gtl_pkg.vhd
- do files and dep file:
  - ../sim/scripts/templates/gtl_fdl_wrapper_tpl_questa_v2018.2.do
  - ../sim/scripts/templates/gtl_fdl_wrapper_tpl_questa_v2018.3.do
  - ../sim/scripts/templates/gtl_fdl_wrapper_tpl_questa_v2019.1.do
  - ../cfg/uGT_algo.dep

#### Removed
- ../hdl/data/gtl/threshold_comparator.vhd
- ../hdl/data/gtl/range_comparator.vhd

### [mp7_ugt_v2_2_1] - 2019-08-27

#### Comment
- mp7_ugt firmware release v2.2.1

#### Changed
- ../hdl/data/gtl/inv_mass_calc.vhd (splitted equation for DSP)
- inserted cases for "same objects" and "different objects" (less resources for "same objects") in:
  - ../hdl/data/gtl/cos_dphi_lut.vhd
  - ../hdl/data/gtl/cosh_deta_lut.vhd
  - ../hdl/data/gtl/diff_eta_lut.vhd
  - ../hdl/data/gtl/diff_phi_lut.vhd
  - ../hdl/data/gtl/sub_eta.vhd
  - ../hdl/data/gtl/sub_phi.vhd
  - ../hdl/data/gtl/delta_r.vhd
  - ../hdl/data/gtl/invariant_mass.vhd
  - ../hdl/data/gtl/comparators_corr_cuts.vhd

### [mp7_ugt_v2_2_0] - 2019-08-26

#### Comment
- mp7_ugt firmware release v2.2.0

#### Added
- ../hdl/data/gtl/comparators_obj_cuts.vhd
- ../hdl/data/gtl/comp_unsigned.vhd
- ../hdl/data/gtl/inv_mass_calc.vhd
- ../hdl/data/gtl/luts_corr_cuts.vhd
- ../hdl/data/gtl/sub_eta_calc.vhd
- ../hdl/data/gtl/sub_phi_calc.vhd

#### Changed
- types for inputs and outputs in diff_eta_lut.vhd, diff_phi_lut.vhd and delta_r.vhd
- modules which instantiate added modules
- do files and dep file

#### Removed
- directory ../firmware/sim_vivado, not used anymore, simulation is done with Questa simulator
- ../hdl/packages/rb_pkg.vhd, not used anymore (see control_pkg.vhd)

### [mp7_ugt_v2_1_0] - 2019-07-03

#### Comment
- mp7_ugt firmware release v2.1.0

#### Added
- ../hdl/data/gtl/twobody_pt.vhd
- ../hdl/packages/fdl_pkg.vhd
- ../hdl/packages/control_pkg.vhd
- ../sim/scripts/templates/gtl_fdl_wrapper_tpl_questa_v2019.1.do

#### Changed
- moved all VHDL package files to ../hdl/packages:
  - ../hdl/control/frame_addr_decode.vhd
  - ../hdl/data/gtl/gtl_pkg.vhd
  - ../hdl/data/gtl/lut_pkg.vhd
  - ../hdl/data/fdl/fdl_addr_decode.vhd
- do files and dep file:
  - ../sim/scripts/templates/gtl_fdl_wrapper_tpl_questa_v2018.2.do
  - ../sim/scripts/templates/gtl_fdl_wrapper_tpl_questa_v2018.3.do
  - ../cfg/uGT_algo.dep
- inserted use clause fdl_pkg in files

### [mp7_ugt_v2_0_2] - 2019-06-26

#### Comment
- mp7_ugt firmware release v2.0.2

#### Changed
- bug fix in gtl_pkg.vhd and fdl_module.vhd
- deleted obsolete files:
  - ../hdl/control/rb_pkg_sim.vhd
  - ../hdl/data/fdl/algo_mapping_rop_tpl.vhd
  - ../hdl/data/gtl/gtl_module_tpl.vhd
  - ../hdl/data/gtl/gtl_pkg_sim.vhd
  - ../hdl/data/gtl/gtl_pkg_tpl.vhd
  - ../hdl/packages/gt_mp7_core_pkg_sim.vhd
 - script run_simulation_questa.py (exit on error)
 
### [mp7_ugt_v2_0_0] - 2019-06-26 => no tag created !!!

#### Comment
- mp7_ugt firmware release v2.0.0

#### Changed
- GTL structure (v2.0.0), init version.
- "frame" to "control" (v2.0.0), init version [based on frame v1.2.3].

================================

Versions of ugt with old GTL structure (v1.9.0 and lower)

### [mp7_ugt_v1_9_0] - 2019-06-19
#### Comment

- mp7_ugt firmware release v1.9.0 is created for use with IPBus builder and based on frame v1.2.3, gtl v1.8.0 and fdl v1.3.0.

#### Changed
- calo, muon and correlation modules for "five eta cuts"
- fdl version to v1.3.0 (v1.2.3 was not correct)
- run_simulation_questa.py and runIpbbSynth.py (inserted arguments checks)

### [mp7_ugt_v1_8_1] - 2019-06-03
#### Comment

- mp7_ugt firmware release v1.8.1 is created for use with IPBus builder and based on frame v1.2.3, gtl v1.7.0 and fdl v1.2.3.

#### Added
- algo_pre_scaler_fractional.vhd in fdl v1.2.3 for use of floating point prescale values with precision 2
- algo_pre_scaler_fractional_pkg.vhd for mode sequence LUTs
- calo_cond_matrix.vhd, calo_cond_matrix_orm.vhd, calo_obj_cuts.vhd, muon_cond_matrix.vhd and muon_obj_cuts.vhd (Dinyar/Hannes proposal for calo quad conditions) in gtl v1.7.0
- run_simulation_questa.py to ../mp7_ugt/scripts for simulation
- run_compile_simlib.py to ../mp7_ugt/scripts for generating Vivado simulation libs for Questa
- run_simulation_algo_prescaler_fractional.py to ../mp7_ugt/firmware/sim/scripts for simulating algo_pre_scaler_fractional_tb.vhd in a loop

#### Changed
- fdl_module.vhd and algo_slice.vhd for algo_pre_scaler_fractional.vhd in fdl v1.2.3
- gtl_pkg_tpl.vhd (inserted PRESCALER_FRACTION_WIDTH and types for cond_matrix) in gtl v1.7.0
- file names in gtl v1.7.0 (from now names without _vx used)
- runIpbbSynth.py for possibility of simulation

### [mp7_ugt_v1_7_0] - 2019-04-03
#### Comment

- mp7_ugt firmware release v1.7.0 is created for use with IPBus builder and based on frame v1.2.3, gtl v1.6.0 and fdl v1.2.2.

#### Changed
- used "FRAME_VERSION" in gt_mp7_core_pkg.vhd for mp7_ugt firmware release number.
- added ugt_strategy.tcl for ugt specific strategy and inserted it into top.dep.
- modified uGT_algo.dep: removed "doubled" commands (these commnads are in MP7 dep files).
- added scripts runIpbbSynth.py for IPBB synthesis (all 6 mp7_ugt modules), checkIpbbSynth.py and fwpackerIpbb.py.

### [amc502_extcond_v1_7_0] - 2019-04-03
#### Comment

- amc502_extcond firmware release v1.7.0 is created for use with IPBus builder and based on same features as firmware build v1010.

#### Changed
- added scripts runIpbbSynth.py, checkIpbbSynth.py and fwpackerIpbb.py.

### [amc502_finor_v1_9_0] - 2019-04-03
#### Comment

- amc502_finor firmware release v1.9.0 is created for use with IPBus builder and based on same features as firmware build v1012.

#### Changed
- added scripts runIpbbSynth.py, checkIpbbSynth.py and fwpackerIpbb.py.

### [amc502_finor_pre_v1_1_0] - 2019-04-03
#### Comment

- amc502_finor_pre firmware release v1.9.0 is created for use with IPBus builder and based on same features as firmware build v1002.

#### Changed
- added scripts runIpbbSynth.py, checkIpbbSynth.py and fwpackerIpbb.py.


