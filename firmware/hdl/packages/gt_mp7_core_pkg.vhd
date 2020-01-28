-- Description:
-- Package for versions and global definitions of ugt.

-- Version-history of gt_mp7_core_pkg:
-- HB 2019-07-03: moved TCM part and functions to control_pkg.vhd
-- HB 2019-07-03: cleaned up MAX_CALO_OBJECTS and MAX_N_OBJECTS
-- HB 2019-01-24: moved replacement of "IPBUS_TIMESTAMP", etc. from gt_mp7_top_pkg (which is obsolete now). [Therefore changed "makeProject.py" script]
-- HB 2019-01-22: cleaned up
-- HB 2016-09-19: removed more unused constants
-- HB 2016-06-30: removed unused constants and cleaned up

-- ===================================================================================
-- actual versions of ugt:
-- use "FRAME_VERSION" as mp7_ugt release fw version (used for tag name)
-- mp7_ugt (=FRAME_VERSION): v2.4.9
--
--  control: v2.0.1
--  gtl: v2.4.7
--  fdl: v1.3.5

-- Version-history of GTL part:
-- HB 2020-01-28: v2.4.7: bug fixed in combinatorial_conditions.vhd and combinatorial_conditions_ovrm.vhd.
-- HB 2019-12-11: v2.4.6: inserted additional constants and subtypes in gtl_pkg.vhd, removed constants in lut_pkg.vhd.
-- HB 2019-12-11: v2.4.5: replaced "MUON/muon" by "MU/mu", bug fix in bx function, added esums to bx pipeline, updated use of charge correlation in conditions, updated transverse mass --                        calculation, inserted bx-bx combination for correlations.
-- HB 2019-11-20: v2.4.4: added subtypes (for asymmetry and minimum-bias) and bug fixed in gtl_pkg.vhd. Inserted Logic for charge in comparators_obj_cuts.vhd.
-- HB 2019-11-12: v2.4.3: bug fixed "function bx" in gtl_pkg.vhd.
-- HB 2019-11-11: v2.4.2: bug fix in gtl_pkg.vhd.
-- HB 2019-11-04: v2.4.1: changed muon_charge_correlations.vhd, renamed files.
-- HB 2019-10-22: v2.4.0: added combinatorial_conditions_ovrm.vhd, updated two-body pt features.
-- HB 2019-09-27: v2.3.1: updated gt_mp7_core_pkg.vhd.
-- HB 2019-09-25: v2.3.0: bug fixes for invariant mass and overlap removal conditions.
-- HB 2019-08-27: v2.2.1: inserted cases for "same objects" and "different objects" (less resources for "same objects") in "lut", "sub" and "correlation cuts" modules.
-- HB 2019-08-26: v2.2.0: created basic modules for calculations and module comparators_obj_cuts.vhd.
-- HB 2019-07-03: v2.1.0: created twobody_pt.vhd module.
-- HB 2019-06-27: v2.0.1: changed type of conversion signals in bx_pipeline.vhd.
-- HB 2019-03-08: v2.0.0: new structure with instance of l1menu.vhd in gtl_module.vhd
-- ===================================================================================

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

use work.mp7_data_types.all;
use work.math_pkg.all;
use work.lhc_data_pkg.all;
use work.top_decl.all;

package gt_mp7_core_pkg is

-- ==================================================================================================
-- HB 2019-01-24: definitions (TOP_xxx) moved to top_decl_tpl.vhd
--     constant TIMESTAMP : std_logic_vector(31 downto 0) := TOP_TIMESTAMP;
--     constant MODULE_TYPE : std_logic_vector(31 downto 0) := (others => '0');
--     constant USERNAME : std_logic_vector(32*8-1 downto 0) := TOP_USERNAME;
--     constant HOSTNAME : std_logic_vector(32*8-1 downto 0) := TOP_HOSTNAME;
--     constant BUILD_VERSION : std_logic_vector(31 downto 0) := TOP_BUILD_VERSION;

-- ==================================================================================================
-- CONTROL = FRAME version (given by the editor of control.vhd)
    constant FRAME_MAJOR_VERSION : integer range 0 to 255 := 2;
    constant FRAME_MINOR_VERSION : integer range 0 to 255 := 4;
    constant FRAME_REV_VERSION   : integer range 0 to 255 := 9;
	constant FRAME_VERSION : std_logic_vector(31 downto 0) := X"00" &
           std_logic_vector(to_unsigned(FRAME_MAJOR_VERSION, 8)) &
           std_logic_vector(to_unsigned(FRAME_MINOR_VERSION, 8)) &
           std_logic_vector(to_unsigned(FRAME_REV_VERSION, 8));
-- GTL firmware (fix part) version
    constant GTL_FW_MAJOR_VERSION : integer range 0 to 255 := 2;
    constant GTL_FW_MINOR_VERSION : integer range 0 to 255 := 4;
    constant GTL_FW_REV_VERSION   : integer range 0 to 255 := 7;
-- FDL firmware version
    constant FDL_FW_MAJOR_VERSION : integer range 0 to 255 := 1;
    constant FDL_FW_MINOR_VERSION : integer range 0 to 255 := 3;
    constant FDL_FW_REV_VERSION   : integer range 0 to 255 := 5;
-- ==================================================================================================

    constant MAX_NR_ALGOS : integer := 512;
    constant MAX_CALO_OBJECTS: positive := 12;
    constant MAX_N_OBJECTS: positive := 12; -- actual value = 12 (calos)
    constant FINOR_WIDTH : integer := 4; -- for read-out record
-- HB 12-11-2013: GTL_FDL_LATENCY = 6 with fixed pipeline structure (2 = +/- 2bx, 3 = conditions and algos, 1 = FDL)
    constant GTL_FDL_LATENCY : integer := 6;
-- HB 2014-07-08: ipbus_rst is high active
    constant RST_ACT : std_logic := '1';

    type ipb_regs_array is array (natural range <>) of std_logic_vector(31 downto 0);

-- LMP (Lane Mapping Process)
    type lane_objects_array_t is array (CLOCK_RATIO-1 downto 0) of std_logic_vector(LWORD_WIDTH-1 downto 0);

end package;

