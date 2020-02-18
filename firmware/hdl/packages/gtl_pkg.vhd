-- Description:
-- Package for constant and type definitions of GTL firmware in Global Trigger Upgrade system.

-- Version-history:
-- HB 2020-02-17: Type for mass with 3 objects.
-- HB 2020-01-22: Bug fix in function bx.
-- HB 2020-01-15: Inserted additional constants for orm correlation cuts (eg: TAU_EG_DELTAETA_VECTOR_WIDTH).
-- HB 2020-01-14: Inserted additional subtypes for correlation cut with orm (eg: tau_jet_t).
-- HB 2019-12-20: Bug fix in function bx.
-- HB 2019-12-10: Replaces "MUON/muon" by "MU/mu".
-- HB 2019-11-12: Bug fix in function bx.
-- HB 2019-11-07: Inserted N_MU_OBJECTS.
-- HB 2019-09-06: Inserted comp_mode_cc.
-- HB 2019-09-02: Inserted number of objects for esums (N_ETT_OBJECTS, ...).
-- HB 2019-08-29: Updated record "default_corr_cuts_rec". Added constants for deta, dphi, deltaR and mass vector width).
-- HB 2019-08-22: Added types for LUTs of correlation cuts.
-- HB 2019-07-16: Changed subtypes declaration to ascending range. Inserted record "default_corr_cuts_rec".
-- HB 2019-07-03: Moved constants and types for FDL to fdl_pkg.vhd. Removed MAX_N_OBJ.
-- HB 2019-06-28: Deleted obsolete types
-- HB 2019-06-27: Inserted new records for conversions
-- HB 2019-03-08: L1Menu depending definition moved to l1menu_pkg.vhd
-- HB 2018-12-06: changed structure for GTL_v2.x.y.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use work.lhc_data_pkg.all;
use work.math_pkg.all;
use work.gt_mp7_core_pkg.all;
-- use work.l1menu_pkg.ALL;

package gtl_pkg is

-- ========================================================

-- -- HB 2014-09-09: GTL and FDL firmware major, minor and revision versions moved to gt_mp7_core_pkg.vhd (GTL_FW_MAJOR_VERSION, etc.)
-- --                for creating a tag name by a script independent from L1Menu.
-- -- GTL firmware (fix part) version
--     constant GTL_FW_VERSION : std_logic_vector(31 downto 0) := X"00" &
--            std_logic_vector(to_unsigned(GTL_FW_MAJOR_VERSION, 8)) &
--            std_logic_vector(to_unsigned(GTL_FW_MINOR_VERSION, 8)) &
--            std_logic_vector(to_unsigned(GTL_FW_REV_VERSION, 8));

-- *******************************************************************************
-- Definitions for GTL v2.x.y
-- Scales constants

    constant PI : real :=  3.15; -- TM used this value for PI

    constant CALO_ETA_STEP : real := 0.087/2.0; -- values from scales
    constant MU_ETA_STEP : real := 0.087/8.0; -- values from scales

    constant CALO_PHI_BINS : positive := 144; -- values from scales
    constant MU_PHI_BINS : positive := 576; -- values from scales
    constant CALO_PHI_HALF_RANGE_BINS : positive := CALO_PHI_BINS/2; -- 144/2, because of phi bin width = 2*PI/144
    constant EG_EG_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant EG_JET_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant EG_TAU_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant JET_EG_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant JET_JET_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant JET_TAU_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant TAU_EG_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant TAU_JET_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant TAU_TAU_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant EG_ETM_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant EG_ETMHF_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant EG_HTM_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant EG_HTMHF_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant JET_ETM_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant JET_ETMHF_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant JET_HTM_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant JET_HTMHF_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant TAU_ETM_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant TAU_ETMHF_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant TAU_HTM_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant TAU_HTMHF_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant MU_PHI_HALF_RANGE_BINS : positive := MU_PHI_BINS/2; -- 576/2, because of phi bin width = 2*PI/576
    constant EG_MU_PHI_HALF_RANGE_BINS : positive := MU_PHI_HALF_RANGE_BINS;
    constant JET_MU_PHI_HALF_RANGE_BINS : positive := MU_PHI_HALF_RANGE_BINS;
    constant TAU_MU_PHI_HALF_RANGE_BINS : positive := MU_PHI_HALF_RANGE_BINS;
    constant MU_MU_PHI_HALF_RANGE_BINS : positive := MU_PHI_HALF_RANGE_BINS;
    constant MU_ETM_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant MU_ETMHF_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant MU_HTM_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant MU_HTMHF_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    
    constant N_MU_OBJECTS :  positive := N_MUON_OBJECTS;

    constant PHI_MIN : real := 0.0; -- phi min.: 0.0
    constant PHI_MAX : real := 2.0*PI; -- phi max.: 2*PI

    constant ETA_MIN : real := -5.0; -- eta min.: -5.0
    constant ETA_MAX : real := 5.0; -- eta max.: +5.0
    constant ETA_RANGE_REAL : real := 10.0; -- eta range max.: -5.0 to +5.0

-- *******************************************************************************
-- Global constants

    constant MAX_N_REQ : positive := 4; -- max. number of requirements for combinatorial conditions
    constant MAX_LUT_WIDTH : positive := 16; -- muon qual lut
    constant MAX_OBJ_BITS : positive := 64; -- muon

    constant MAX_OBJ_PARAMETER_WIDTH : positive := 16; -- used 16 for hex notation of requirements - max. parameter width of objects: towercount = 13
    constant MAX_CORR_CUTS_WIDTH : positive := 56; -- max inv mass width (2*MAX_PT_WIDTH+MAX_COSH_COS_WIDTH = 51) - used 52 for hex notation !
    constant MAX_COSH_COS_WIDTH : positive := 27; -- CALO_MUON_COSH_COS_VECTOR_WIDTH 
    constant MAX_PT_WIDTH : positive := 12; -- max. pt width (esums pt = 12)
    constant MAX_ETA_WIDTH : positive := 9; -- max. eta width(muon eta = 9)
    constant MAX_PHI_WIDTH : positive := 10; -- max. phi width (muon phi = 10)
    constant MAX_PT_VECTOR_WIDTH : positive := 15; -- esums - max. value 2047.8 GeV => 20478 (2047.8 * 10**1) => 0x4FFE
    
    constant MAX_SIN_COS_WIDTH: positive := 11; -- log2c(1000-(-1000));
    
    constant IN_REG_COMP: boolean := true; -- actually input register in comparator modules used
    constant OUT_REG_COMP: boolean := true; -- actually output register in comparator modules used
    constant OUT_REG_COND: boolean := false; -- actually no output register in condition modules used
    
    constant BX_PIPELINE_STAGES: natural := 5; -- pipeline stages for +/- 2bx
    constant EXT_COND_STAGES: natural := 2; -- pipeline stages for "External conditions" to get same pipeline to algos as conditions
    constant CENTRALITY_STAGES: natural := 2; -- pipeline stages for "Centrality" to get same pipeline to algos as conditions
    constant ALGO_REG_STAGES: natural := 1; -- algo out register stages
    
-- *******************************************************************************************************
-- MUON objects parameter definition

    constant MU_PHI_LOW : natural := 0;
    constant MU_PHI_HIGH : natural := 9;
    constant MU_PT_LOW : natural := 10;
    constant MU_PT_HIGH : natural := 18;
    constant MU_QUAL_LOW : natural := 19;
    constant MU_QUAL_HIGH : natural := 22;
    constant MU_ETA_LOW : natural := 23;
    constant MU_ETA_HIGH : natural := 31;
    constant MU_ISO_LOW : natural := 32;
    constant MU_ISO_HIGH : natural := 33;
    constant MU_CHARGE_LOW : natural := 34;
    constant MU_CHARGE_HIGH : natural := 35;
-- HB 2017-04-11: updated muon structure for "raw" and "extrapolated" phi and eta bits (phi_high, phi_low, eta_high and eta_low => for "extrapolated").
    constant MU_IDX_BITS_LOW : natural := 36;
    constant MU_IDX_BITS_HIGH : natural := 42;
    constant MU_PHI_RAW_LOW : natural := 43;
    constant MU_PHI_RAW_HIGH : natural := 52;
    constant MU_ETA_RAW_LOW : natural := 53;
    constant MU_ETA_RAW_HIGH : natural := 61;
    constant MU_PHI_WIDTH: positive := MU_PHI_HIGH-MU_PHI_LOW+1;
    constant MU_PT_WIDTH: positive := MU_PT_HIGH-MU_PT_LOW+1;
    constant MU_QUAL_WIDTH: positive := MU_QUAL_HIGH-MU_QUAL_LOW+1;
    constant MU_ETA_WIDTH: positive := MU_ETA_HIGH-MU_ETA_LOW+1;
    constant MU_ISO_WIDTH: positive := MU_ISO_HIGH-MU_ISO_LOW+1;
    constant MU_CHARGE_WIDTH: positive := MU_CHARGE_HIGH-MU_CHARGE_LOW+1;
    constant MU_IDX_BITS_WIDTH: positive := MU_IDX_BITS_HIGH-MU_IDX_BITS_LOW+1;
    constant MU_PHI_RAW_WIDTH: positive := MU_PHI_RAW_HIGH-MU_PHI_RAW_LOW+1;
    constant MU_ETA_RAW_WIDTH: positive := MU_ETA_RAW_HIGH-MU_ETA_RAW_LOW+1;
    constant MU_PT_VECTOR_WIDTH: positive := 12; -- max. value 255.5 GeV => 2555 (255.5 * 10**MUON_INV_MASS_PT_PRECISION) => 0x9FB

-- *******************************************************************************************************
-- CALO objects parameter definition

    constant EG_PT_LOW : natural := 0;
    constant EG_PT_HIGH : natural := 8;
    constant EG_ETA_LOW : natural := 9;
    constant EG_ETA_HIGH : natural := 16;
    constant EG_PHI_LOW : natural := 17;
    constant EG_PHI_HIGH : natural := 24;
    constant EG_ISO_LOW : natural := 25;
    constant EG_ISO_HIGH : natural := 26;
    constant EG_PT_WIDTH: positive := EG_PT_HIGH-EG_PT_LOW+1;
    constant EG_ETA_WIDTH: positive := EG_ETA_HIGH-EG_ETA_LOW+1;
    constant EG_PHI_WIDTH: positive := EG_PHI_HIGH-EG_PHI_LOW+1;
    constant EG_ISO_WIDTH: positive := EG_ISO_HIGH-EG_ISO_LOW+1;
    constant EG_PT_VECTOR_WIDTH: positive := 12; -- max. value 255.5 GeV => 2555 (255.5 * 10**EG_PT_PRECISION) => 0x9FB

    constant JET_PT_LOW : natural := 0;
    constant JET_PT_HIGH : natural := 10;
    constant JET_ETA_LOW : natural := 11;
    constant JET_ETA_HIGH : natural := 18;
    constant JET_PHI_LOW : natural := 19;
    constant JET_PHI_HIGH : natural := 26;
    constant JET_PT_WIDTH: positive := JET_PT_HIGH-JET_PT_LOW+1;
    constant JET_ETA_WIDTH: positive := JET_ETA_HIGH-JET_ETA_LOW+1;
    constant JET_PHI_WIDTH: positive := JET_PHI_HIGH-JET_PHI_LOW+1;
    constant JET_PT_VECTOR_WIDTH: positive := 14; -- max. value 1023.5 GeV => 10235 (1023.5 * 10**JET_PT_PRECISION) => 0x27FB

    constant TAU_PT_LOW : natural := 0;
    constant TAU_PT_HIGH : natural := 8;
    constant TAU_ETA_LOW : natural := 9;
    constant TAU_ETA_HIGH : natural := 16;
    constant TAU_PHI_LOW : natural := 17;
    constant TAU_PHI_HIGH : natural := 24;
    constant TAU_ISO_LOW : natural := 25;
    constant TAU_ISO_HIGH : natural := 26;
    constant TAU_PT_WIDTH: positive := TAU_PT_HIGH-TAU_PT_LOW+1;
    constant TAU_ETA_WIDTH: positive := TAU_ETA_HIGH-TAU_ETA_LOW+1;
    constant TAU_PHI_WIDTH: positive := TAU_PHI_HIGH-TAU_PHI_LOW+1;
    constant TAU_ISO_WIDTH: positive := TAU_ISO_HIGH-TAU_ISO_LOW+1;
    constant TAU_PT_VECTOR_WIDTH: positive := 12; -- max. value 255.5 GeV => 2555 (255.5 * 10**TAU_PT_PRECISION) => 0x9FB

    constant MAX_CALO_ETA_BITS : positive := max((EG_ETA_HIGH-EG_ETA_LOW+1), (JET_ETA_HIGH-JET_ETA_LOW+1), (TAU_ETA_HIGH-TAU_ETA_LOW+1));
    constant MAX_CALO_PHI_BITS : positive := max((EG_PHI_HIGH-EG_PHI_LOW+1), (JET_PHI_HIGH-JET_PHI_LOW+1), (TAU_PHI_HIGH-TAU_PHI_LOW+1));

-- *******************************************************************************************************
-- Esums objects parameter definition
    constant MAX_ESUMS_BITS : positive := 20; -- see ETM, HTM, etc.

    constant ETT_PT_LOW : natural := 0;
    constant ETT_PT_HIGH : natural := 11;
    constant ETT_PT_WIDTH: positive := ETT_PT_HIGH-ETT_PT_LOW+1;
    constant N_ETT_OBJECTS : natural := 1;

    constant HTT_PT_LOW : natural := 0;
    constant HTT_PT_HIGH : natural := 11;
    constant HTT_PT_WIDTH: positive := HTT_PT_HIGH-HTT_PT_LOW+1;
    constant N_HTT_OBJECTS : natural := 1;

    constant ETM_PT_LOW : natural := 0;
    constant ETM_PT_HIGH : natural := 11;
    constant ETM_PHI_LOW : natural := 12;
    constant ETM_PHI_HIGH : natural := 19;
    constant ETM_PT_WIDTH: positive := ETM_PT_HIGH-ETM_PT_LOW+1;
    constant ETM_PHI_WIDTH: positive := ETM_PHI_HIGH-ETM_PHI_LOW+1;
    constant ETM_PT_VECTOR_WIDTH: positive := 15; -- max. value 2047.8 GeV => 20478 (2047.8 * 10**JET_PT_PRECISION) => 0x4FFE
    constant N_ETM_OBJECTS : natural := 1;

    constant HTM_PT_LOW : natural := 0;
    constant HTM_PT_HIGH : natural := 11;
    constant HTM_PHI_LOW : natural := 12;
    constant HTM_PHI_HIGH : natural := 19;
    constant HTM_PT_WIDTH: positive := HTM_PT_HIGH-HTM_PT_LOW+1;
    constant HTM_PHI_WIDTH: positive := HTM_PHI_HIGH-HTM_PHI_LOW+1;
    constant HTM_PT_VECTOR_WIDTH: positive := 15; -- max. value 2047.8 GeV => 20478 (2047.8 * 10**JET_PT_PRECISION) => 0x4FFE
    constant N_HTM_OBJECTS : natural := 1;

    constant ETTEM_IN_ETT_LOW : natural := 12;
    constant ETTEM_IN_ETT_HIGH : natural := 23;
    constant ETTEM_PT_LOW : natural := 0;
    constant ETTEM_PT_HIGH : natural := 11;
    constant ETTEM_PT_WIDTH: positive := ETTEM_PT_HIGH-ETTEM_PT_LOW+1;
    constant N_ETTEM_OBJECTS : natural := 1;

    constant ETMHF_PT_LOW : natural := 0;
    constant ETMHF_PT_HIGH : natural := 11;
    constant ETMHF_PHI_LOW : natural := 12;
    constant ETMHF_PHI_HIGH : natural := 19;
    constant ETMHF_PT_WIDTH: positive := ETMHF_PT_HIGH-ETMHF_PT_LOW+1;
    constant ETMHF_PHI_WIDTH: positive := ETMHF_PHI_HIGH-ETMHF_PHI_LOW+1;
    constant ETMHF_PT_VECTOR_WIDTH: positive := 15; -- max. value 2047.8 GeV => 20478 (2047.8 * 10**JET_PT_PRECISION) => 0x4FFE
    constant N_ETMHF_OBJECTS : natural := 1;

    constant HTMHF_PT_LOW : natural := 0;
    constant HTMHF_PT_HIGH : natural := 11;
    constant HTMHF_PHI_LOW : natural := 12;
    constant HTMHF_PHI_HIGH : natural := 19;
    constant HTMHF_PT_WIDTH: positive := HTMHF_PT_HIGH-HTMHF_PT_LOW+1;
    constant HTMHF_PHI_WIDTH: positive := HTMHF_PHI_HIGH-HTMHF_PHI_LOW+1;
    constant HTMHF_PT_VECTOR_WIDTH: positive := 15; -- max. value 2047.8 GeV => 20478 (2047.8 * 10**JET_PT_PRECISION) => 0x4FFE
    constant N_HTMHF_OBJECTS : natural := 1;

-- *******************************************************************************************************
-- Towercount bits
-- HB 2016-09-16: inserted TOWERCOUNT
    constant TOWERCOUNT_IN_HTT_LOW : natural := 12;
    constant TOWERCOUNT_IN_HTT_HIGH : natural := 24;
    constant TOWERCOUNT_COUNT_LOW : natural := 0;
    constant TOWERCOUNT_COUNT_HIGH : natural := 12;
    constant TOWERCOUNT_COUNT_WIDTH : natural := 13;
    constant MAX_TOWERCOUNT_BITS : natural := 16;
    constant N_TOWERCOUNT_OBJECTS : natural := 1;

-- *******************************************************************************************************
-- Minimum Bias bits
-- HB 2016-04-18: updates for "min bias trigger" objects (quantities) for Low-pileup-run May 2016
-- HB 2016-04-21: see email from Johannes (Andrew Rose), 2016-04-20 15:34
-- Frame 0: (HF+ thresh 0) ... ... (Scalar ET) - 4 MSBs
-- Frame 1: (HF- thresh 0) ... ... (Scalar HT) - 4 MSBs
-- Frame 2: (HF+ thresh 1) ... ... (Vector ET) - 4 MSBs
-- Frame 3: (HF- thresh 1) ... ... (Vector HT) - 4 MSBs
-- HB 2016-04-26: grammar notation
-- HF+ thresh 0 => MBT0HFP
-- HF- thresh 0 => MBT0HFM
-- HF+ thresh 1 => MBT1HFP
-- HF- thresh 1 => MBT1HFM

    constant MBT0HFP_IN_ETT_HIGH : natural := 31;
    constant MBT0HFP_IN_ETT_LOW : natural := 28;    
    constant MBT0HFM_IN_HTT_HIGH : natural := 31;
    constant MBT0HFM_IN_HTT_LOW : natural := 28;
    constant MBT1HFP_IN_ETM_HIGH : natural := 31;
    constant MBT1HFP_IN_ETM_LOW : natural := 28;
    constant MBT1HFM_IN_HTM_HIGH : natural := 31;
    constant MBT1HFM_IN_HTM_LOW : natural := 28;

    constant MB_COUNT_LOW : natural := 0;
    constant MB_COUNT_HIGH : natural := 3;
    constant MBT0HFP_WIDTH : natural := 4;
    constant MBT0HFM_WIDTH : natural := 4;
    constant MBT1HFP_WIDTH : natural := 4;
    constant MBT1HFM_WIDTH : natural := 4;
    constant N_MBT0HFP_OBJECTS : natural := 1;
    constant N_MBT0HFM_OBJECTS : natural := 1;
    constant N_MBT1HFP_OBJECTS : natural := 1;
    constant N_MBT1HFM_OBJECTS : natural := 1;

-- *******************************************************************************************************
-- Asymmetry bits
-- HB 2018-08-06: inserted constants and types for "Asymmetry" and "Centrality" (included in esums data structure).
-- see: https://indico.cern.ch/event/746381/contributions/3085360/subcontributions/260912/attachments/1693846/2725976/DemuxOutput.pdf

-- Frame 2, ETM: bits 27..20 => ASYMET
-- Frame 3, HTM: bits 27..20 => ASYMHT
-- Frame 4, ETMHF: bits 27..20 => ASYMETHF
-- Frame 5, HTMHF: bits 27..20 => ASYMHTHF

-- Frame 4, ETMHF: bits 31..28 => CENT3..CENT0
-- Frame 5, HTMHF: bits 31..28 => CENT7..CENT4

    constant ASYMET_IN_ETM_HIGH : natural := 27;
    constant ASYMET_IN_ETM_LOW : natural := 20;
    constant ASYMHT_IN_HTM_HIGH : natural := 27;
    constant ASYMHT_IN_HTM_LOW : natural := 20;
    constant ASYMETHF_IN_ETMHF_HIGH : natural := 27;
    constant ASYMETHF_IN_ETMHF_LOW : natural := 20;
    constant ASYMHTHF_IN_HTMHF_HIGH : natural := 27;
    constant ASYMHTHF_IN_HTMHF_LOW : natural := 20;

    constant ASYM_LOW : natural := 0;
    constant ASYM_HIGH : natural := 7;
    constant ASYMET_WIDTH : natural := 8;
    constant ASYMHT_WIDTH : natural := 8;
    constant ASYMETHF_WIDTH : natural := 8;
    constant ASYMHTHF_WIDTH : natural := 8;
    constant N_ASYMET_OBJECTS : natural := 1;
    constant N_ASYMHT_OBJECTS : natural := 1;
    constant N_ASYMETHF_OBJECTS : natural := 1;
    constant N_ASYMHTHF_OBJECTS : natural := 1;

-- *******************************************************************************************************
-- Centrality bits
    constant CENT_IN_ETMHF_HIGH : natural := 31;
    constant CENT_IN_ETMHF_LOW : natural := 28;
    constant CENT_IN_HTMHF_HIGH : natural := 31;
    constant CENT_IN_HTMHF_LOW : natural := 28;

    constant CENT_LBITS_LOW : natural := 0;
    constant CENT_LBITS_HIGH: natural := 3;
    constant CENT_UBITS_LOW : natural := 4;
    constant CENT_UBITS_HIGH: natural := 7;

    constant NR_CENTRALITY_BITS : positive := 8;
    
-- *******************************************************************************
-- Constants for correlation cuts

    -- DETA, DPHI and deltaR
    constant DETA_DPHI_PRECISION: positive := 3;
    constant DETA_DPHI_VECTOR_WIDTH: positive := log2c(max(integer(ETA_RANGE_REAL*(real(10**DETA_DPHI_PRECISION))),integer(PHI_MAX*(real(10**DETA_DPHI_PRECISION))))); 
    constant DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;

    constant EG_EG_DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant EG_JET_DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant EG_TAU_DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant JET_EG_DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant JET_JET_DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant JET_TAU_DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant TAU_EG_DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant TAU_JET_DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant TAU_TAU_DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant EG_MU_DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant JET_MU_DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant TAU_MU_DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant MU_MU_DELTAETA_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;

    constant EG_EG_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant EG_JET_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant EG_TAU_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant JET_EG_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant JET_JET_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant JET_TAU_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant TAU_EG_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant TAU_JET_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant TAU_TAU_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant EG_MU_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant JET_MU_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant TAU_MU_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant MU_MU_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant EG_ETM_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant EG_HTM_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant EG_ETMHF_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant EG_HTMHF_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant JET_ETM_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant JET_HTM_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant JET_ETMHF_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant JET_HTMHF_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant TAU_ETM_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant TAU_HTM_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant TAU_ETMHF_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant TAU_HTMHF_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant MU_ETM_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant MU_HTM_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant MU_ETMHF_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;
    constant MU_HTMHF_DELTAPHI_VECTOR_WIDTH: positive := DETA_DPHI_VECTOR_WIDTH;

    constant EG_EG_DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;
    constant EG_JET_DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;
    constant EG_TAU_DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;
    constant JET_EG_DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;
    constant JET_JET_DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;
    constant JET_TAU_DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;
    constant TAU_EG_DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;
    constant TAU_JET_DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;
    constant TAU_TAU_DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;
    constant EG_MU_DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;
    constant JET_MU_DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;
    constant TAU_MU_DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;
    constant MU_MU_DELTAR_VECTOR_WIDTH: positive := 2*DETA_DPHI_VECTOR_WIDTH;

    -- Mass
    constant CALO_CALO_COSH_COS_VECTOR_WIDTH: positive := 24; -- max. value cosh_deta-cos_dphi => [10597282-(-1000)]=10598282 => 0xA1B78A
    constant CALO_MU_COSH_COS_VECTOR_WIDTH: positive := 27; -- max. value cosh_deta-cos_dphi => [109487199-(-10000)]=109497199 => 0x686CB6F
    constant MU_MU_COSH_COS_VECTOR_WIDTH: positive := 20; -- max. value cosh_deta-cos_dphi => [667303-(-10000)]=677303 => 0xA55B7
    constant EG_EG_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant EG_JET_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant EG_TAU_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant EG_ETM_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant EG_HTM_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant EG_ETMHF_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant EG_HTMHF_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant JET_JET_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant JET_TAU_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant JET_ETM_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant JET_HTM_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant JET_ETMHF_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant JET_HTMHF_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant TAU_TAU_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant TAU_ETM_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant TAU_HTM_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant TAU_ETMHF_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant TAU_HTMHF_COSH_COS_VECTOR_WIDTH: positive := CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant EG_MU_COSH_COS_VECTOR_WIDTH: positive := CALO_MU_COSH_COS_VECTOR_WIDTH;
    constant JET_MU_COSH_COS_VECTOR_WIDTH: positive := CALO_MU_COSH_COS_VECTOR_WIDTH;
    constant TAU_MU_COSH_COS_VECTOR_WIDTH: positive := CALO_MU_COSH_COS_VECTOR_WIDTH;
    constant MU_ETM_COSH_COS_VECTOR_WIDTH: positive := CALO_MU_COSH_COS_VECTOR_WIDTH;
    constant MU_HTM_COSH_COS_VECTOR_WIDTH: positive := CALO_MU_COSH_COS_VECTOR_WIDTH;
    constant MU_ETMHF_COSH_COS_VECTOR_WIDTH: positive := CALO_MU_COSH_COS_VECTOR_WIDTH;
    constant MU_HTMHF_COSH_COS_VECTOR_WIDTH: positive := CALO_MU_COSH_COS_VECTOR_WIDTH;
    
    -- Invariant mass
    constant EG_EG_MASS_VECTOR_WIDTH: positive := EG_PT_VECTOR_WIDTH+EG_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant EG_JET_MASS_VECTOR_WIDTH: positive := EG_PT_VECTOR_WIDTH+JET_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant EG_TAU_MASS_VECTOR_WIDTH: positive := EG_PT_VECTOR_WIDTH+TAU_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant JET_JET_MASS_VECTOR_WIDTH: positive := JET_PT_VECTOR_WIDTH+JET_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant JET_TAU_MASS_VECTOR_WIDTH: positive := JET_PT_VECTOR_WIDTH+TAU_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant TAU_TAU_MASS_VECTOR_WIDTH: positive := TAU_PT_VECTOR_WIDTH+TAU_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant EG_MU_MASS_VECTOR_WIDTH: positive := EG_PT_VECTOR_WIDTH+MU_PT_VECTOR_WIDTH+CALO_MU_COSH_COS_VECTOR_WIDTH;
    constant JET_MU_MASS_VECTOR_WIDTH: positive := JET_PT_VECTOR_WIDTH+MU_PT_VECTOR_WIDTH+CALO_MU_COSH_COS_VECTOR_WIDTH;
    constant TAU_MU_MASS_VECTOR_WIDTH: positive := TAU_PT_VECTOR_WIDTH+MU_PT_VECTOR_WIDTH+CALO_MU_COSH_COS_VECTOR_WIDTH;
    constant MU_MU_MASS_VECTOR_WIDTH: positive := MU_PT_VECTOR_WIDTH+MU_PT_VECTOR_WIDTH+MU_MU_COSH_COS_VECTOR_WIDTH;

    -- Transverse mass
    constant EG_ETM_MASS_VECTOR_WIDTH: positive := EG_PT_VECTOR_WIDTH+ETM_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant EG_HTM_MASS_VECTOR_WIDTH: positive := EG_PT_VECTOR_WIDTH+HTM_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant EG_ETMHF_MASS_VECTOR_WIDTH: positive := EG_PT_VECTOR_WIDTH+ETMHF_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant EG_HTMHF_MASS_VECTOR_WIDTH: positive := EG_PT_VECTOR_WIDTH+HTMHF_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant JET_ETM_MASS_VECTOR_WIDTH: positive := JET_PT_VECTOR_WIDTH+ETM_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant JET_HTM_MASS_VECTOR_WIDTH: positive := JET_PT_VECTOR_WIDTH+HTM_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant JET_ETMHF_MASS_VECTOR_WIDTH: positive := JET_PT_VECTOR_WIDTH+ETMHF_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant JET_HTMHF_MASS_VECTOR_WIDTH: positive := JET_PT_VECTOR_WIDTH+HTMHF_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant TAU_ETM_MASS_VECTOR_WIDTH: positive := TAU_PT_VECTOR_WIDTH+ETM_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant TAU_HTM_MASS_VECTOR_WIDTH: positive := TAU_PT_VECTOR_WIDTH+HTM_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant TAU_ETMHF_MASS_VECTOR_WIDTH: positive := TAU_PT_VECTOR_WIDTH+ETMHF_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant TAU_HTMHF_MASS_VECTOR_WIDTH: positive := TAU_PT_VECTOR_WIDTH+HTMHF_PT_VECTOR_WIDTH+CALO_CALO_COSH_COS_VECTOR_WIDTH;
    constant MU_ETM_MASS_VECTOR_WIDTH: positive := MU_PT_VECTOR_WIDTH+ETM_PT_VECTOR_WIDTH+CALO_MU_COSH_COS_VECTOR_WIDTH;
    constant MU_HTM_MASS_VECTOR_WIDTH: positive := MU_PT_VECTOR_WIDTH+HTM_PT_VECTOR_WIDTH+CALO_MU_COSH_COS_VECTOR_WIDTH;
    constant MU_ETMHF_MASS_VECTOR_WIDTH: positive := MU_PT_VECTOR_WIDTH+ETMHF_PT_VECTOR_WIDTH+CALO_MU_COSH_COS_VECTOR_WIDTH;
    constant MU_HTMHF_MASS_VECTOR_WIDTH: positive := MU_PT_VECTOR_WIDTH+HTMHF_PT_VECTOR_WIDTH+CALO_MU_COSH_COS_VECTOR_WIDTH;
    
    -- Two-body Pt
    constant EG_EG_TBPT_VECTOR_WIDTH: positive := 2+EG_PT_VECTOR_WIDTH+EG_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant EG_JET_TBPT_VECTOR_WIDTH: positive := 2+EG_PT_VECTOR_WIDTH+JET_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant EG_TAU_TBPT_VECTOR_WIDTH: positive := 2+EG_PT_VECTOR_WIDTH+TAU_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant JET_JET_TBPT_VECTOR_WIDTH: positive := 2+JET_PT_VECTOR_WIDTH+JET_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant JET_TAU_TBPT_VECTOR_WIDTH: positive := 2+JET_PT_VECTOR_WIDTH+TAU_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant TAU_TAU_TBPT_VECTOR_WIDTH: positive := 2+TAU_PT_VECTOR_WIDTH+TAU_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant EG_MU_TBPT_VECTOR_WIDTH: positive := 2+EG_PT_VECTOR_WIDTH+MU_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant JET_MU_TBPT_VECTOR_WIDTH: positive := 2+JET_PT_VECTOR_WIDTH+MU_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant TAU_MU_TBPT_VECTOR_WIDTH: positive := 2+TAU_PT_VECTOR_WIDTH+MU_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant MU_MU_TBPT_VECTOR_WIDTH: positive := 2+MU_PT_VECTOR_WIDTH+MU_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant EG_ETM_TBPT_VECTOR_WIDTH: positive := 2+EG_PT_VECTOR_WIDTH+ETM_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant EG_HTM_TBPT_VECTOR_WIDTH: positive := 2+EG_PT_VECTOR_WIDTH+HTM_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant EG_ETMHF_TBPT_VECTOR_WIDTH: positive := 2+EG_PT_VECTOR_WIDTH+ETMHF_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant EG_HTMHF_TBPT_VECTOR_WIDTH: positive := 2+EG_PT_VECTOR_WIDTH+HTMHF_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant JET_ETM_TBPT_VECTOR_WIDTH: positive := 2+JET_PT_VECTOR_WIDTH+ETM_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant JET_HTM_TBPT_VECTOR_WIDTH: positive := 2+JET_PT_VECTOR_WIDTH+HTM_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant JET_ETMHF_TBPT_VECTOR_WIDTH: positive := 2+JET_PT_VECTOR_WIDTH+ETMHF_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant JET_HTMHF_TBPT_VECTOR_WIDTH: positive := 2+JET_PT_VECTOR_WIDTH+HTMHF_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant TAU_ETM_TBPT_VECTOR_WIDTH: positive := 2+TAU_PT_VECTOR_WIDTH+ETM_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant TAU_HTM_TBPT_VECTOR_WIDTH: positive := 2+TAU_PT_VECTOR_WIDTH+HTM_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant TAU_ETMHF_TBPT_VECTOR_WIDTH: positive := 2+TAU_PT_VECTOR_WIDTH+ETMHF_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant TAU_HTMHF_TBPT_VECTOR_WIDTH: positive := 2+TAU_PT_VECTOR_WIDTH+HTMHF_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant MU_ETM_TBPT_VECTOR_WIDTH: positive := 2+MU_PT_VECTOR_WIDTH+ETM_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant MU_HTM_TBPT_VECTOR_WIDTH: positive := 2+MU_PT_VECTOR_WIDTH+HTM_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant MU_ETMHF_TBPT_VECTOR_WIDTH: positive := 2+MU_PT_VECTOR_WIDTH+ETMHF_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;
    constant MU_HTMHF_TBPT_VECTOR_WIDTH: positive := 2+MU_PT_VECTOR_WIDTH+HTMHF_PT_VECTOR_WIDTH+2*MAX_SIN_COS_WIDTH;

-- *******************************************************************************
-- Record declarations
    type eg_record is record
        pt : std_logic_vector(EG_PT_HIGH-EG_PT_LOW downto 0);
        eta : std_logic_vector(EG_ETA_HIGH-EG_ETA_LOW downto 0);
        phi : std_logic_vector(EG_PHI_HIGH-EG_PHI_LOW downto 0);
        iso : std_logic_vector(EG_ISO_HIGH-EG_ISO_LOW downto 0);
    end record eg_record;
    
    type eg_record_array is array (natural range <>) of eg_record;

    type jet_record is record
        pt : std_logic_vector(JET_PT_HIGH-JET_PT_LOW downto 0);
        eta : std_logic_vector(JET_ETA_HIGH-JET_ETA_LOW downto 0);
        phi : std_logic_vector(JET_PHI_HIGH-JET_PHI_LOW downto 0);
    end record jet_record;
    
    type jet_record_array is array (natural range <>) of jet_record;

    type tau_record is record
        pt : std_logic_vector(TAU_PT_HIGH-TAU_PT_LOW downto 0);
        eta : std_logic_vector(TAU_ETA_HIGH-TAU_ETA_LOW downto 0);
        phi : std_logic_vector(TAU_PHI_HIGH-TAU_PHI_LOW downto 0);
        iso : std_logic_vector(TAU_ISO_HIGH-TAU_ISO_LOW downto 0);
    end record tau_record;
    
    type tau_record_array is array (natural range <>) of tau_record;

    type muon_record is record
        pt : std_logic_vector(MU_PT_HIGH-MU_PT_LOW downto 0);
        eta : std_logic_vector(MU_ETA_HIGH-MU_ETA_LOW downto 0);
        phi : std_logic_vector(MU_PHI_HIGH-MU_PHI_LOW downto 0);
        iso : std_logic_vector(MU_ISO_HIGH-MU_ISO_LOW downto 0);
        qual : std_logic_vector(MU_QUAL_HIGH-MU_QUAL_LOW downto 0);
        charge : std_logic_vector(MU_CHARGE_HIGH-MU_CHARGE_LOW downto 0);
    end record muon_record;
    
    type muon_record_array is array (natural range <>) of muon_record;

    type ett_record is record
        pt : std_logic_vector(ETT_PT_HIGH-ETT_PT_LOW downto 0);
    end record ett_record;
    
    type etm_record is record
        pt : std_logic_vector(ETM_PT_HIGH-ETM_PT_LOW downto 0);
        phi : std_logic_vector(ETM_PHI_HIGH-ETM_PHI_LOW downto 0);
    end record etm_record;
    
    type htt_record is record
        pt : std_logic_vector(HTT_PT_HIGH-HTT_PT_LOW downto 0);
    end record htt_record;
    
    type htm_record is record
        pt : std_logic_vector(HTM_PT_HIGH-HTM_PT_LOW downto 0);
        phi : std_logic_vector(HTM_PHI_HIGH-HTM_PHI_LOW downto 0);
    end record htm_record;
    
    type ettem_record is record
        pt : std_logic_vector(ETTEM_PT_HIGH-ETTEM_PT_LOW downto 0);
    end record ettem_record;
    
    type etmhf_record is record
        pt : std_logic_vector(ETMHF_PT_HIGH-ETMHF_PT_LOW downto 0);
        phi : std_logic_vector(ETMHF_PHI_HIGH-ETMHF_PHI_LOW downto 0);
    end record etmhf_record;
    
    type htmhf_record is record
        pt : std_logic_vector(HTMHF_PT_HIGH-HTMHF_PT_LOW downto 0);
        phi : std_logic_vector(HTMHF_PHI_HIGH-HTMHF_PHI_LOW downto 0);
    end record htmhf_record;
        
    type mb_record is record
        count : std_logic_vector(MB_COUNT_HIGH-MB_COUNT_LOW downto 0);
    end record mb_record;
    
    type towercount_record is record
        count : std_logic_vector(TOWERCOUNT_COUNT_HIGH-TOWERCOUNT_COUNT_LOW downto 0);
    end record towercount_record;
    
    type asym_record is record
        count : std_logic_vector(ASYM_HIGH-ASYM_LOW downto 0);
    end record asym_record;
    
    type gtl_data_record is record
        mu : muon_record_array(0 to N_MU_OBJECTS-1);
        eg : eg_record_array(0 to N_EG_OBJECTS-1);
        jet : jet_record_array(0 to N_JET_OBJECTS-1);
        tau : tau_record_array(0 to N_TAU_OBJECTS-1);
        ett : ett_record;
        htt : htt_record;
        etm : etm_record;
        htm : htm_record;
        mbt1hfp, mbt1hfm, mbt0hfp, mbt0hfm : mb_record;
        ettem : ettem_record;
        etmhf : etmhf_record;
        htmhf : htmhf_record;
        towercount : towercount_record;
        asymet, asymht, asymethf, asymhthf : asym_record;
        centrality : std_logic_vector(NR_CENTRALITY_BITS-1 downto 0);
        external_conditions : std_logic_vector(EXTERNAL_CONDITIONS_DATA_WIDTH-1 downto 0);
    end record gtl_data_record;
    
    type obj_parameter_array is array (0 to MAX_N_OBJECTS-1) of std_logic_vector(MAX_OBJ_PARAMETER_WIDTH-1 downto 0);    
    
    type obj_bx_record is record
        pt, eta, phi, iso, qual, charge, count : obj_parameter_array;
    end record obj_bx_record;
    
    type array_obj_bx_record is array (0 to BX_PIPELINE_STAGES-1) of obj_bx_record; -- used for outputs of bx_pipeline module  
    type centrality_array is array (0 to BX_PIPELINE_STAGES-1) of std_logic_vector(NR_CENTRALITY_BITS-1 downto 0); -- used for centrality outputs of bx_pipeline module    
    type ext_cond_array is array (0 to BX_PIPELINE_STAGES-1) of std_logic_vector(EXTERNAL_CONDITIONS_DATA_WIDTH-1 downto 0); -- used for ext_cond outputs of bx_pipeline module 
    
    type data_pipeline_record is record
        mu, eg, jet, tau,
        ett, etm, htt, htm, ettem, etmhf, htmhf,
        towercount,
        mbt1hfp, mbt1hfm, mbt0hfp, mbt0hfm,
        asymet, asymht, asymethf, asymhthf : array_obj_bx_record; 
        centrality : centrality_array;
        ext_cond : ext_cond_array;
    end record data_pipeline_record;
    
-- conversions
    type conv_pt_vector_array is array (0 to MAX_N_OBJECTS-1) of std_logic_vector(MAX_PT_VECTOR_WIDTH-1 downto 0);    
    type conv_integer_array is array (0 to MAX_N_OBJECTS-1) of integer;    
    
    type conv_bx_record is record
        pt_vector : conv_pt_vector_array;
        cos_phi, sin_phi,
        cos_phi_conv_mu, sin_phi_conv_mu,
        eta_conv_mu, phi_conv_mu,
        eta, phi : conv_integer_array;
    end record conv_bx_record;
    
    type array_conv_bx_record is array (0 to BX_PIPELINE_STAGES-1) of conv_bx_record; -- used for outputs of bx_pipeline module  

    type conv_pipeline_record is record
        mu, eg, jet, tau, etm, htm, etmhf : array_conv_bx_record; 
    end record conv_pipeline_record;
    
    type max_eta_range_array is array (0 to MAX_N_OBJECTS-1, 0 to MAX_N_OBJECTS-1) of integer range 0 to integer(ETA_RANGE_REAL/MU_ETA_STEP)-1; -- 10.0/0.010875 = 919.54 => rounded(919.54) = 920 - number of bins with muon bin width for full (calo) eta range
    type obj_bx_max_eta_range_array is array (0 to BX_PIPELINE_STAGES-1, 0 to BX_PIPELINE_STAGES-1) of max_eta_range_array;
    type max_phi_range_array is array (0 to MAX_N_OBJECTS-1, 0 to MAX_N_OBJECTS-1) of integer range 0 to max(MU_PHI_BINS, CALO_PHI_BINS)-1; -- number of bins with muon bin width (=576)
    type obj_bx_max_phi_range_array is array (0 to BX_PIPELINE_STAGES-1, 0 to BX_PIPELINE_STAGES-1) of max_phi_range_array;
    
    type deta_dphi_vector_array is array (0 to MAX_N_OBJECTS-1, 0 to MAX_N_OBJECTS-1) of std_logic_vector(DETA_DPHI_VECTOR_WIDTH-1 downto 0);
    type obj_bx_deta_dphi_vector_array is array (0 to BX_PIPELINE_STAGES-1, 0 to BX_PIPELINE_STAGES-1) of deta_dphi_vector_array;
    
    type corr_cuts_std_logic_array is array (0 to MAX_N_OBJECTS-1, 0 to MAX_N_OBJECTS-1,  MAX_CORR_CUTS_WIDTH-1 downto 0) of std_logic;
    type obj_bx_corr_cuts_std_logic_array is array (0 to BX_PIPELINE_STAGES-1, 0 to BX_PIPELINE_STAGES-1) of corr_cuts_std_logic_array;
        
    type corr_cuts_array is array (natural range <>, natural range <>) of std_logic;

    type cosh_cos_vector_array is array (0 to MAX_N_OBJECTS-1, 0 to MAX_N_OBJECTS-1) of std_logic_vector(MAX_COSH_COS_WIDTH-1 downto 0);
    type obj_bx_cosh_cos_vector_array is array (0 to BX_PIPELINE_STAGES-1, 0 to BX_PIPELINE_STAGES-1) of cosh_cos_vector_array;
    
    type sin_cos_vector_array is array (0 to MAX_N_OBJECTS-1, 0 to MAX_N_OBJECTS-1) of std_logic_vector(MAX_SIN_COS_WIDTH-1 downto 0);
    type obj_bx_sin_cos_vector_array is array (0 to BX_PIPELINE_STAGES-1, 0 to BX_PIPELINE_STAGES-1) of sin_cos_vector_array;
    
    type mass_3_obj_array is array (natural range <>, natural range <>, natural range <>) of std_logic;

-- MUON charge
    type muon_charge_bits_array is array (0 to N_MU_OBJECTS-1) of std_logic_vector(MU_CHARGE_WIDTH-1 downto 0);
    type muon_cc_double_array is array (0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1) of std_logic_vector(MU_CHARGE_WIDTH-1 downto 0);
    type obj_bx_muon_cc_double_array is array (0 to BX_PIPELINE_STAGES-1, 0 to BX_PIPELINE_STAGES-1) of muon_cc_double_array;
    type muon_cc_triple_array is array (0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1) of std_logic_vector(MU_CHARGE_WIDTH-1 downto 0);
    type obj_bx_muon_cc_triple_array is array (0 to BX_PIPELINE_STAGES-1, 0 to BX_PIPELINE_STAGES-1) of muon_cc_triple_array;
    type muon_cc_quad_array is array (0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1) of std_logic_vector(MU_CHARGE_WIDTH-1 downto 0);
    type obj_bx_muon_cc_quad_array is array (0 to BX_PIPELINE_STAGES-1, 0 to BX_PIPELINE_STAGES-1) of muon_cc_quad_array;
    constant CC_NOT_VALID : std_logic_vector(MU_CHARGE_WIDTH-1 downto 0) := "00"; 
    constant CC_LS : std_logic_vector(MU_CHARGE_WIDTH-1 downto 0) := "01"; 
    constant CC_OS : std_logic_vector(MU_CHARGE_WIDTH-1 downto 0) := "10"; 
    type muon_cc_double_std_logic_array is array (0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1) of std_logic;
    type muon_cc_triple_std_logic_array is array (0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1) of std_logic;
    type muon_cc_quad_std_logic_array is array (0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1) of std_logic;

-- HB 2019-07-02: subtypes for l1menu.vhd signals

    subtype eg_obj_t is std_logic_vector(0 to N_EG_OBJECTS-1);  
    subtype jet_obj_t is std_logic_vector(0 to N_JET_OBJECTS-1);  
    subtype tau_obj_t is std_logic_vector(0 to N_TAU_OBJECTS-1);  
    subtype ett_obj_t is std_logic_vector(0 to 0);  
    subtype etm_obj_t is std_logic_vector(0 to 0);  
    subtype htt_obj_t is std_logic_vector(0 to 0);  
    subtype htm_obj_t is std_logic_vector(0 to 0);  
    subtype ettem_obj_t is std_logic_vector(0 to 0);  
    subtype etmhf_obj_t is std_logic_vector(0 to 0);  
    subtype htmhf_obj_t is std_logic_vector(0 to 0);
    
    subtype asymet_obj_t is std_logic_vector(0 to 0);
    subtype asymht_obj_t is std_logic_vector(0 to 0);
    subtype asymethf_obj_t is std_logic_vector(0 to 0);
    subtype asymhthf_obj_t is std_logic_vector(0 to 0);
    
    subtype mbt0hfp_obj_t is std_logic_vector(0 to 0);
    subtype mbt0hfm_obj_t is std_logic_vector(0 to 0);
    subtype mbt1hfp_obj_t is std_logic_vector(0 to 0);
    subtype mbt1hfm_obj_t is std_logic_vector(0 to 0);
    
    subtype mu_obj_t is std_logic_vector(0 to N_MU_OBJECTS-1);  
    subtype mu_cc_double_t is muon_cc_double_std_logic_array;  
    subtype mu_cc_triple_t is muon_cc_triple_std_logic_array;  
    subtype mu_cc_quad_t is muon_cc_quad_std_logic_array;  
    subtype eg_eg_t is corr_cuts_array(0 to N_EG_OBJECTS-1, 0 to N_EG_OBJECTS-1);
    subtype eg_jet_t is corr_cuts_array(0 to N_EG_OBJECTS-1, 0 to N_JET_OBJECTS-1);
    subtype eg_tau_t is corr_cuts_array(0 to N_EG_OBJECTS-1, 0 to N_TAU_OBJECTS-1);
    subtype eg_mu_t is corr_cuts_array(0 to N_EG_OBJECTS-1, 0 to N_MU_OBJECTS-1);
    subtype jet_eg_t is corr_cuts_array(0 to N_JET_OBJECTS-1, 0 to N_EG_OBJECTS-1);
    subtype jet_jet_t is corr_cuts_array(0 to N_JET_OBJECTS-1, 0 to N_JET_OBJECTS-1);
    subtype jet_tau_t is corr_cuts_array(0 to N_JET_OBJECTS-1, 0 to N_TAU_OBJECTS-1);
    subtype jet_mu_t is corr_cuts_array(0 to N_JET_OBJECTS-1, 0 to N_MU_OBJECTS-1);
    subtype tau_eg_t is corr_cuts_array(0 to N_TAU_OBJECTS-1, 0 to N_EG_OBJECTS-1);
    subtype tau_jet_t is corr_cuts_array(0 to N_TAU_OBJECTS-1, 0 to N_JET_OBJECTS-1);
    subtype tau_tau_t is corr_cuts_array(0 to N_TAU_OBJECTS-1, 0 to N_TAU_OBJECTS-1);
    subtype tau_mu_t is corr_cuts_array(0 to N_TAU_OBJECTS-1, 0 to N_MU_OBJECTS-1);
    subtype mu_mu_t is corr_cuts_array(0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1);
    subtype eg_etm_t is corr_cuts_array(0 to N_EG_OBJECTS-1, 0 to 0);
    subtype eg_htm_t is corr_cuts_array(0 to N_EG_OBJECTS-1, 0 to 0);
    subtype eg_etmhf_t is corr_cuts_array(0 to N_EG_OBJECTS-1, 0 to 0);
    subtype eg_htmhf_t is corr_cuts_array(0 to N_EG_OBJECTS-1, 0 to 0);
    subtype jet_etm_t is corr_cuts_array(0 to N_JET_OBJECTS-1, 0 to 0);
    subtype jet_htm_t is corr_cuts_array(0 to N_JET_OBJECTS-1, 0 to 0);
    subtype jet_etmhf_t is corr_cuts_array(0 to N_JET_OBJECTS-1, 0 to 0);
    subtype jet_htmhf_t is corr_cuts_array(0 to N_JET_OBJECTS-1, 0 to 0);
    subtype tau_etm_t is corr_cuts_array(0 to N_TAU_OBJECTS-1, 0 to 0);
    subtype tau_htm_t is corr_cuts_array(0 to N_TAU_OBJECTS-1, 0 to 0);
    subtype tau_etmhf_t is corr_cuts_array(0 to N_TAU_OBJECTS-1, 0 to 0);
    subtype tau_htmhf_t is corr_cuts_array(0 to N_TAU_OBJECTS-1, 0 to 0);
    subtype mu_etm_t is corr_cuts_array(0 to N_MU_OBJECTS-1, 0 to 0);
    subtype mu_htm_t is corr_cuts_array(0 to N_MU_OBJECTS-1, 0 to 0);
    subtype mu_etmhf_t is corr_cuts_array(0 to N_MU_OBJECTS-1, 0 to 0);
    subtype mu_htmhf_t is corr_cuts_array(0 to N_MU_OBJECTS-1, 0 to 0);
  
    subtype eg_eg_eg_t is mass_3_obj_array(0 to N_EG_OBJECTS-1, 0 to N_EG_OBJECTS-1, 0 to N_EG_OBJECTS-1);
    subtype jet_jet_jet_t is mass_3_obj_array(0 to N_JET_OBJECTS-1, 0 to N_JET_OBJECTS-1, 0 to N_JET_OBJECTS-1);
    subtype tau_tau_tau_t is mass_3_obj_array(0 to N_TAU_OBJECTS-1, 0 to N_TAU_OBJECTS-1, 0 to N_TAU_OBJECTS-1);
    subtype mu_mu_mu_t is mass_3_obj_array(0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1);

    type default_corr_cuts_rec is record
        eg_eg : eg_eg_t;
        eg_jet : eg_jet_t;
        eg_tau : eg_tau_t;
        eg_mu : eg_mu_t;
        eg_etm : eg_etm_t;
        eg_htm : eg_htm_t;
        eg_etmhf : eg_etmhf_t;
        eg_htmhf : eg_htmhf_t;
        jet_jet : jet_jet_t;
        jet_tau : jet_tau_t;
        jet_mu : jet_mu_t;
        jet_etm : jet_etm_t;
        jet_htm : jet_htm_t;
        jet_etmhf : jet_etmhf_t;
        jet_htmhf : jet_htmhf_t;
        tau_tau : tau_tau_t;
        tau_mu : tau_mu_t;
        tau_etm : tau_etm_t;
        tau_htm : tau_htm_t;
        tau_etmhf : tau_etmhf_t;
        tau_htmhf : tau_htmhf_t;
        mu_mu : mu_mu_t;
        mu_etm : mu_etm_t;
        mu_htm : mu_htm_t;
        mu_etmhf : mu_etmhf_t;
        mu_htmhf : mu_htmhf_t;
        cc_double : muon_cc_double_std_logic_array;
        cc_triple : muon_cc_triple_std_logic_array;
        cc_quad : muon_cc_quad_std_logic_array;
    end record default_corr_cuts_rec;
    
-- *******************************************************************************
-- correlation cuts
    type pt_array is array (natural range <>) of std_logic_vector((MAX_PT_WIDTH)-1 downto 0);
    
-- enums
    type obj_type is (mu_t,eg_t,jet_t,tau_t,ett_t,etm_t,htt_t,htm_t,ettem_t,etmhf_t,htmhf_t,towercount_t,mbt1hfp_t,mbt1hfm_t,mbt0hfp_t,mbt0hfm_t,asymet_t,asymht_t,asymethf_t,asymhthf_t);
    type obj_type_array is array (1 to 2) of obj_type;
    type bx_array is array (1 to 2) of natural;
    type comp_mode is (GE,EQ,NE,ETA,PHI,CHARGE,ISO,QUAL,COUNT,deltaEta,deltaPhi,deltaR,mass,twoBodyPt,chargeCorr);
    type comp_mode_cc is (double,triple,quad);
    type corr_cuts_lut_mode is (deltaEta,deltaPhi,CoshDeltaEta,CosDeltaPhi);

-- slices
    type slices_type is array (0 to 1) of natural; -- index 0 contains lower slice value, index 1 contains upper slice value
    type slices_type_array is array (1 to MAX_N_REQ) of slices_type;
    
-- *******************************************************************************************************
    function bx(i : integer) return natural;
    
end package;

package body gtl_pkg is

-- Function to convert bx values from utm (e.g.: +2 to -2) to array index of bx data (e.g.: 0 to 4)
    function bx(i : integer) return natural is
        variable conv_val : integer := 0;
        variable bx_conv : natural := 0;
    begin
        conv_val := (BX_PIPELINE_STAGES/2)-(i*2);
        bx_conv := i+conv_val;        
        return bx_conv;
    end function;

end package body gtl_pkg;
