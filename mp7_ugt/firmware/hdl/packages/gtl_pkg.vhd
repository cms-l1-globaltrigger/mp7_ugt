-- Description:
-- Package for constant and type definitions of GTL firmware in Global Trigger Upgrade system.

-- Version-history:
-- HB 2019-07-16: Changed subtypes declaration to ascending range.
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
use work.l1menu_pkg.ALL;

package gtl_pkg is

-- ========================================================

-- HB 2014-09-09: GTL and FDL firmware major, minor and revision versions moved to gt_mp7_core_pkg.vhd (GTL_FW_MAJOR_VERSION, etc.)
--                for creating a tag name by a script independent from L1Menu.
-- GTL firmware (fix part) version
    constant GTL_FW_VERSION : std_logic_vector(31 downto 0) := X"00" &
           std_logic_vector(to_unsigned(GTL_FW_MAJOR_VERSION, 8)) &
           std_logic_vector(to_unsigned(GTL_FW_MINOR_VERSION, 8)) &
           std_logic_vector(to_unsigned(GTL_FW_REV_VERSION, 8));

-- *******************************************************************************
-- Definitions for GTL v2.x.y
-- Scales constants

    constant PI : real :=  3.15; -- TM used this value for PI

    constant CALO_ETA_STEP : real := 0.087/2.0; -- values from scales
    constant MUON_ETA_STEP : real := 0.087/8.0; -- values from scales

    constant CALO_PHI_BINS : positive := 144; -- values from scales
    constant MUON_PHI_BINS : positive := 576; -- values from scales
    constant CALO_PHI_HALF_RANGE_BINS : positive := CALO_PHI_BINS/2; -- 144/2, because of phi bin width = 2*PI/144
    constant EG_EG_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant EG_JET_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant EG_TAU_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant JET_JET_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant JET_TAU_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant TAU_TAU_PHI_HALF_RANGE_BINS : positive := CALO_PHI_HALF_RANGE_BINS;
    constant MUON_PHI_HALF_RANGE_BINS : positive := MUON_PHI_BINS/2; -- 576/2, because of phi bin width = 2*PI/576
    constant EG_MUON_PHI_HALF_RANGE_BINS : positive := MUON_PHI_HALF_RANGE_BINS;
    constant JET_MUON_PHI_HALF_RANGE_BINS : positive := MUON_PHI_HALF_RANGE_BINS;
    constant TAU_MUON_PHI_HALF_RANGE_BINS : positive := MUON_PHI_HALF_RANGE_BINS;
    constant MUON_MUON_PHI_HALF_RANGE_BINS : positive := MUON_PHI_HALF_RANGE_BINS;

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
    constant MAX_CORR_CUTS_WIDTH : positive := 52; -- max inv mass width (2*MAX_PT_WIDTH+MAX_COSH_COS_WIDTH = 51) - used 52 for hex notation !
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

    constant MUON_PHI_LOW : natural := 0;
    constant MUON_PHI_HIGH : natural := 9;
    constant MUON_PT_LOW : natural := 10;
    constant MUON_PT_HIGH : natural := 18;
    constant MUON_QUAL_LOW : natural := 19;
    constant MUON_QUAL_HIGH : natural := 22;
    constant MUON_ETA_LOW : natural := 23;
    constant MUON_ETA_HIGH : natural := 31;
    constant MUON_ISO_LOW : natural := 32;
    constant MUON_ISO_HIGH : natural := 33;
    constant MUON_CHARGE_LOW : natural := 34;
    constant MUON_CHARGE_HIGH : natural := 35;
-- HB 2017-04-11: updated muon structure for "raw" and "extrapolated" phi and eta bits (phi_high, phi_low, eta_high and eta_low => for "extrapolated").
    constant MUON_IDX_BITS_LOW : natural := 36;
    constant MUON_IDX_BITS_HIGH : natural := 42;
    constant MUON_PHI_RAW_LOW : natural := 43;
    constant MUON_PHI_RAW_HIGH : natural := 52;
    constant MUON_ETA_RAW_LOW : natural := 53;
    constant MUON_ETA_RAW_HIGH : natural := 61;
    constant MUON_PHI_WIDTH: positive := MUON_PHI_HIGH-MUON_PHI_LOW+1;
    constant MUON_PT_WIDTH: positive := MUON_PT_HIGH-MUON_PT_LOW+1;
    constant MUON_QUAL_WIDTH: positive := MUON_QUAL_HIGH-MUON_QUAL_LOW+1;
    constant MUON_ETA_WIDTH: positive := MUON_ETA_HIGH-MUON_ETA_LOW+1;
    constant MUON_ISO_WIDTH: positive := MUON_ISO_HIGH-MUON_ISO_LOW+1;
    constant MUON_CHARGE_WIDTH: positive := MUON_CHARGE_HIGH-MUON_CHARGE_LOW+1;
    constant MUON_IDX_BITS_WIDTH: positive := MUON_IDX_BITS_HIGH-MUON_IDX_BITS_LOW+1;
    constant MUON_PHI_RAW_WIDTH: positive := MUON_PHI_RAW_HIGH-MUON_PHI_RAW_LOW+1;
    constant MUON_ETA_RAW_WIDTH: positive := MUON_ETA_RAW_HIGH-MUON_ETA_RAW_LOW+1;
    constant MUON_PT_VECTOR_WIDTH: positive := 12; -- max. value 255.5 GeV => 2555 (255.5 * 10**MUON_INV_MASS_PT_PRECISION) => 0x9FB

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

    constant HTT_PT_LOW : natural := 0;
    constant HTT_PT_HIGH : natural := 11;
    constant HTT_PT_WIDTH: positive := HTT_PT_HIGH-HTT_PT_LOW+1;

    constant ETM_PT_LOW : natural := 0;
    constant ETM_PT_HIGH : natural := 11;
    constant ETM_PHI_LOW : natural := 12;
    constant ETM_PHI_HIGH : natural := 19;
    constant ETM_PT_WIDTH: positive := ETM_PT_HIGH-ETM_PT_LOW+1;
    constant ETM_PHI_WIDTH: positive := ETM_PHI_HIGH-ETM_PHI_LOW+1;
    constant ETM_PT_VECTOR_WIDTH: positive := 15; -- max. value 2047.8 GeV => 20478 (2047.8 * 10**JET_PT_PRECISION) => 0x4FFE

    constant HTM_PT_LOW : natural := 0;
    constant HTM_PT_HIGH : natural := 11;
    constant HTM_PHI_LOW : natural := 12;
    constant HTM_PHI_HIGH : natural := 19;
    constant HTM_PT_WIDTH: positive := HTM_PT_HIGH-HTM_PT_LOW+1;
    constant HTM_PHI_WIDTH: positive := HTM_PHI_HIGH-HTM_PHI_LOW+1;
    constant HTM_PT_VECTOR_WIDTH: positive := 15; -- max. value 2047.8 GeV => 20478 (2047.8 * 10**JET_PT_PRECISION) => 0x4FFE

    constant ETTEM_IN_ETT_LOW : natural := 12;
    constant ETTEM_IN_ETT_HIGH : natural := 23;
    constant ETTEM_PT_LOW : natural := 0;
    constant ETTEM_PT_HIGH : natural := 11;
    constant ETTEM_PT_WIDTH: positive := ETTEM_PT_HIGH-ETTEM_PT_LOW+1;

    constant ETMHF_PT_LOW : natural := 0;
    constant ETMHF_PT_HIGH : natural := 11;
    constant ETMHF_PHI_LOW : natural := 12;
    constant ETMHF_PHI_HIGH : natural := 19;
    constant ETMHF_PT_WIDTH: positive := ETMHF_PT_HIGH-ETMHF_PT_LOW+1;
    constant ETMHF_PHI_WIDTH: positive := ETMHF_PHI_HIGH-ETMHF_PHI_LOW+1;
    constant ETMHF_PT_VECTOR_WIDTH: positive := 15; -- max. value 2047.8 GeV => 20478 (2047.8 * 10**JET_PT_PRECISION) => 0x4FFE

    constant HTMHF_PT_LOW : natural := 0;
    constant HTMHF_PT_HIGH : natural := 11;
    constant HTMHF_PHI_LOW : natural := 12;
    constant HTMHF_PHI_HIGH : natural := 19;
    constant HTMHF_PT_WIDTH: positive := HTMHF_PT_HIGH-HTMHF_PT_LOW+1;
    constant HTMHF_PHI_WIDTH: positive := HTMHF_PHI_HIGH-HTMHF_PHI_LOW+1;
    constant HTMHF_PT_VECTOR_WIDTH: positive := 15; -- max. value 2047.8 GeV => 20478 (2047.8 * 10**JET_PT_PRECISION) => 0x4FFE

-- *******************************************************************************************************
-- Towercount bits
-- HB 2016-09-16: inserted TOWERCOUNT
    constant TOWERCOUNT_IN_HTT_LOW : natural := 12;
    constant TOWERCOUNT_IN_HTT_HIGH : natural := 24;
    constant TOWERCOUNT_COUNT_LOW : natural := 0;
    constant TOWERCOUNT_COUNT_HIGH : natural := 12;
    constant MAX_TOWERCOUNT_BITS : natural := 16;

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

    constant NR_CENTRALITY_BITS : positive := CENT_UBITS_HIGH-CENT_LBITS_LOW+1;
    
-- *******************************************************************************
-- Constants for correlation cuts

    constant DETA_DPHI_PRECISION: positive := 3;
    constant DETA_DPHI_VECTOR_WIDTH: positive := log2c(max(integer(ETA_RANGE_REAL*(real(10**DETA_DPHI_PRECISION))),integer(PHI_MAX*(real(10**DETA_DPHI_PRECISION))))); 
    constant CALO_CALO_COSH_COS_VECTOR_WIDTH: positive := 24; -- max. value cosh_deta-cos_dphi => [10597282-(-1000)]=10598282 => 0xA1B78A
    constant CALO_MUON_COSH_COS_VECTOR_WIDTH: positive := 27; -- max. value cosh_deta-cos_dphi => [109487199-(-10000)]=109497199 => 0x686CB6F
    constant MUON_MUON_COSH_COS_VECTOR_WIDTH: positive := 20; -- max. value cosh_deta-cos_dphi => [667303-(-10000)]=677303 => 0xA55B7

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
        pt : std_logic_vector(MUON_PT_HIGH-MUON_PT_LOW downto 0);
        eta : std_logic_vector(MUON_ETA_HIGH-MUON_ETA_LOW downto 0);
        phi : std_logic_vector(MUON_PHI_HIGH-MUON_PHI_LOW downto 0);
        iso : std_logic_vector(MUON_ISO_HIGH-MUON_ISO_LOW downto 0);
        qual : std_logic_vector(MUON_QUAL_HIGH-MUON_QUAL_LOW downto 0);
        charge : std_logic_vector(MUON_CHARGE_HIGH-MUON_CHARGE_LOW downto 0);
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
        muon : muon_record_array(0 to N_MUON_OBJECTS-1);
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
        muon, eg, jet, tau,
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
        cos_phi_conv_muon, sin_phi_conv_muon,
        eta_conv_muon, phi_conv_muon,
        eta, phi : conv_integer_array;
    end record conv_bx_record;
    
    type array_conv_bx_record is array (0 to BX_PIPELINE_STAGES-1) of conv_bx_record; -- used for outputs of bx_pipeline module  

    type conv_pipeline_record is record
        muon, eg, jet, tau : array_conv_bx_record; 
    end record conv_pipeline_record;
    
    type max_eta_range_array is array (0 to MAX_N_OBJECTS-1, 0 to MAX_N_OBJECTS-1) of integer range 0 to integer(ETA_RANGE_REAL/MUON_ETA_STEP)-1; -- 10.0/0.010875 = 919.54 => rounded(919.54) = 920 - number of bins with muon bin width for full (calo) eta range
    type obj_bx_max_eta_range_array is array (0 to BX_PIPELINE_STAGES-1, 0 to BX_PIPELINE_STAGES-1) of max_eta_range_array;
    type max_phi_range_array is array (0 to MAX_N_OBJECTS-1, 0 to MAX_N_OBJECTS-1) of integer range 0 to max(MUON_PHI_BINS, CALO_PHI_BINS)-1; -- number of bins with muon bin width (=576)
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
    
-- MUON charge
    type muon_charge_bits_array is array (0 to N_MUON_OBJECTS-1) of std_logic_vector(MUON_CHARGE_WIDTH-1 downto 0);
    type muon_cc_double_array is array (0 to N_MUON_OBJECTS-1, 0 to N_MUON_OBJECTS-1) of std_logic_vector(MUON_CHARGE_WIDTH-1 downto 0);
    type obj_bx_muon_cc_double_array is array (0 to BX_PIPELINE_STAGES-1, 0 to BX_PIPELINE_STAGES-1) of muon_cc_double_array;
    type muon_cc_triple_array is array (0 to N_MUON_OBJECTS-1, 0 to N_MUON_OBJECTS-1, 0 to N_MUON_OBJECTS-1) of std_logic_vector(MUON_CHARGE_WIDTH-1 downto 0);
    type obj_bx_muon_cc_triple_array is array (0 to BX_PIPELINE_STAGES-1, 0 to BX_PIPELINE_STAGES-1) of muon_cc_triple_array;
    type muon_cc_quad_array is array (0 to N_MUON_OBJECTS-1, 0 to N_MUON_OBJECTS-1, 0 to N_MUON_OBJECTS-1, 0 to N_MUON_OBJECTS-1) of std_logic_vector(MUON_CHARGE_WIDTH-1 downto 0);
    type obj_bx_muon_cc_quad_array is array (0 to BX_PIPELINE_STAGES-1, 0 to BX_PIPELINE_STAGES-1) of muon_cc_quad_array;
    constant CC_NOT_VALID : std_logic_vector(MUON_CHARGE_WIDTH-1 downto 0) := "00"; 
    constant CC_LS : std_logic_vector(MUON_CHARGE_WIDTH-1 downto 0) := "01"; 
    constant CC_OS : std_logic_vector(MUON_CHARGE_WIDTH-1 downto 0) := "10"; 
    type muon_cc_double_std_logic_array is array (0 to N_MUON_OBJECTS-1, 0 to N_MUON_OBJECTS-1) of std_logic;
    type muon_cc_triple_std_logic_array is array (0 to N_MUON_OBJECTS-1, 0 to N_MUON_OBJECTS-1, 0 to N_MUON_OBJECTS-1) of std_logic;
    type muon_cc_quad_std_logic_array is array (0 to N_MUON_OBJECTS-1, 0 to N_MUON_OBJECTS-1, 0 to N_MUON_OBJECTS-1, 0 to N_MUON_OBJECTS-1) of std_logic;

-- HB 2019-07-02: subtypes for l1menu.vhd signals

    subtype eg_obj_t is std_logic_vector(0 to N_EG_OBJECTS-1);  
    subtype jet_obj_t is std_logic_vector(0 to N_JET_OBJECTS-1);  
    subtype tau_obj_t is std_logic_vector(0 to N_TAU_OBJECTS-1);  
    subtype muon_obj_t is std_logic_vector(0 to N_MUON_OBJECTS-1);  
    subtype muon_cc_double_t is muon_cc_double_std_logic_array;  
    subtype muon_cc_triple_t is muon_cc_triple_std_logic_array;  
    subtype muon_cc_quad_t is muon_cc_quad_std_logic_array;  
    subtype eg_eg_t is corr_cuts_array(0 to N_EG_OBJECTS-1, 0 to N_EG_OBJECTS-1);
    subtype eg_jet_t is corr_cuts_array(0 to N_EG_OBJECTS-1, 0 to N_JET_OBJECTS-1);
    subtype eg_tau_t is corr_cuts_array(0 to N_EG_OBJECTS-1, 0 to N_TAU_OBJECTS-1);
    subtype eg_muon_t is corr_cuts_array(0 to N_EG_OBJECTS-1, 0 to N_MUON_OBJECTS-1);
    subtype jet_jet_t is corr_cuts_array(0 to N_JET_OBJECTS-1, 0 to N_JET_OBJECTS-1);
    subtype jet_tau_t is corr_cuts_array(0 to N_JET_OBJECTS-1, 0 to N_TAU_OBJECTS-1);
    subtype jet_muon_t is corr_cuts_array(0 to N_JET_OBJECTS-1, 0 to N_MUON_OBJECTS-1);
    subtype tau_tau_t is corr_cuts_array(0 to N_TAU_OBJECTS-1, 0 to N_TAU_OBJECTS-1);
    subtype tau_muon_t is corr_cuts_array(0 to N_TAU_OBJECTS-1, 0 to N_MUON_OBJECTS-1);
    subtype muon_muon_t is corr_cuts_array(0 to N_MUON_OBJECTS-1, 0 to N_MUON_OBJECTS-1);
    
    type default_corr_cuts_rec is record
        eg_eg : eg_eg_t;
        eg_jet : eg_jet_t;
        eg_tau : eg_tau_t;
        eg_muon : eg_muon_t;
        jet_jet : jet_jet_t;
        jet_tau : jet_tau_t;
        jet_muon : jet_muon_t;
        tau_tau : tau_tau_t;
        tau_muon : tau_muon_t;
        muon_muon : muon_muon_t;
        cc_double : muon_cc_double_std_logic_array;
        cc_triple : muon_cc_triple_std_logic_array;
        cc_quad : muon_cc_quad_std_logic_array;
    end record default_corr_cuts_rec;
    
-- *******************************************************************************
-- correlation cuts
    type pt_array is array (natural range <>) of std_logic_vector((MAX_PT_WIDTH)-1 downto 0);
    
-- enums
    type obj_type is (muon_t,eg_t,jet_t,tau_t,ett_t,etm_t,htt_t,htm_t,ettem_t,etmhf_t,htmhf_t,towercount_t,mbt1hfp_t,mbt1hfm_t,mbt0hfp_t,mbt0hfm_t,asymet_t,asymht_t,asymethf_t,asymhthf_t);
    type obj_type_array is array (1 to 2) of obj_type;
    type comp_mode is (GE,EQ,NE,ETA,PHI,deltaEta,deltaPhi,deltaR,mass,twoBodyPt);

-- slices
    type slices_type is array (0 to 1) of natural; -- index 0 contains lower slice value, index 1 contains upper slice value
    type slices_type_array is array (1 to MAX_N_REQ) of slices_type;
    
-- *******************************************************************************************************
    function bx(i : integer) return natural;
    
end package;

package body gtl_pkg is

-- Function to convert bx values from utm (e.g.: +2 to -2) to array index of bx data (e.g.: 0 to 4)
    function bx(i : integer) return natural is
        variable conv_val : natural := 0;
        variable bx_conv : natural := 0;
    begin
        conv_val := (BX_PIPELINE_STAGES/2)-(i*2);
        bx_conv := i+conv_val;        
        return bx_conv;
    end function;

end package body gtl_pkg;
