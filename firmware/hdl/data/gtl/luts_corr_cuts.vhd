-- Description:
-- Object cuts lut comparisons.

-- Version-history:
-- HB 2019-12-10: Replaces "MUON/muon" by "MU/mu"
-- HB 2019-08-20: First design.

library ieee;
use ieee.std_logic_1164.all;

-- used for CONV_STD_LOGIC_VECTOR
use ieee.std_logic_arith.all;

use work.gtl_pkg.all;
use work.lut_pkg.all;

entity luts_corr_cuts is
    generic(
        OBJ : obj_type_array;
        MODE : corr_cuts_lut_mode := deltaEta
    );
    port(
        lut_in : in integer;
        lut_o : out std_logic_vector(MAX_COSH_COS_WIDTH-1 downto 0) := (others => '0')
    );
end luts_corr_cuts;

architecture rtl of luts_corr_cuts is

begin

    lut_p: process(lut_in)
        variable calo_calo, calo_muon, muon_muon, calo_esum, muon_esum : boolean := false;    
    begin
        calo_calo_1: if OBJ(1) = eg_t or OBJ(1) = jet_t or OBJ(1) = tau_t then
            calo_calo_2: if OBJ(2) = eg_t or OBJ(2) = jet_t or OBJ(2) = tau_t then
                calo_calo := true;
            end if;
        end if;
        calo_muon_1: if OBJ(1) = eg_t or OBJ(1) = jet_t or OBJ(1) = tau_t then
            calo_muon_2: if OBJ(2) = mu_t then
                calo_muon := true;
            end if;
        end if;
        muon_muon_1: if OBJ(1) = mu_t then
            muon_muon_2: if OBJ(2) = mu_t then
                muon_muon := true;
            end if;
        end if;
        calo_esum_1: if OBJ(1) = eg_t or OBJ(1) = jet_t or OBJ(1) = tau_t then
            calo_esum_2: if OBJ(2) = etm_t or OBJ(2) = htm_t or OBJ(2) = etmhf_t or OBJ(2) = htmhf_t then
                calo_esum := true;
            end if;
        end if;
        muon_esum_1: if OBJ(1) = mu_t then
            muon_esum_2: if OBJ(2) = etm_t or OBJ(2) = htm_t or OBJ(2) = etmhf_t or OBJ(2) = htmhf_t then
                muon_esum := true;
            end if;
        end if;

        calo_calo_i: if calo_calo or calo_esum then
            case MODE is
                when deltaEta =>
                    lut_o(DETA_DPHI_VECTOR_WIDTH-1 downto 0) <= CONV_STD_LOGIC_VECTOR(CALO_CALO_DIFF_ETA_LUT(lut_in), DETA_DPHI_VECTOR_WIDTH);
                when deltaPhi =>
                    lut_o(DETA_DPHI_VECTOR_WIDTH-1 downto 0) <= CONV_STD_LOGIC_VECTOR(CALO_CALO_DIFF_PHI_LUT(lut_in), DETA_DPHI_VECTOR_WIDTH);
                when CoshDeltaEta =>
                    lut_o(CALO_CALO_COSH_COS_VECTOR_WIDTH-1 downto 0) <= CONV_STD_LOGIC_VECTOR(CALO_CALO_COSH_DETA_LUT(lut_in), CALO_CALO_COSH_COS_VECTOR_WIDTH);
                when CosDeltaPhi =>
                    lut_o(CALO_CALO_COSH_COS_VECTOR_WIDTH-1 downto 0) <= CONV_STD_LOGIC_VECTOR(CALO_CALO_COS_DPHI_LUT(lut_in), CALO_CALO_COSH_COS_VECTOR_WIDTH);
            end case;
        end if;
        
        calo_muon_i: if calo_muon or muon_esum then
            case MODE is
                when deltaEta =>
                    lut_o(DETA_DPHI_VECTOR_WIDTH-1 downto 0) <= CONV_STD_LOGIC_VECTOR(CALO_MU_DIFF_ETA_LUT(lut_in), DETA_DPHI_VECTOR_WIDTH);
                when deltaPhi =>
                    lut_o(DETA_DPHI_VECTOR_WIDTH-1 downto 0) <= CONV_STD_LOGIC_VECTOR(CALO_MU_DIFF_PHI_LUT(lut_in), DETA_DPHI_VECTOR_WIDTH);
                when CoshDeltaEta =>
                    lut_o(CALO_MU_COSH_COS_VECTOR_WIDTH-1 downto 0) <= CONV_STD_LOGIC_VECTOR(CALO_MU_COSH_DETA_LUT(lut_in), CALO_MU_COSH_COS_VECTOR_WIDTH);
                when CosDeltaPhi =>
                    lut_o(CALO_MU_COSH_COS_VECTOR_WIDTH-1 downto 0) <= CONV_STD_LOGIC_VECTOR(CALO_MU_COS_DPHI_LUT(lut_in), CALO_MU_COSH_COS_VECTOR_WIDTH);
            end case;
        end if;
        
        muon_muon_i: if muon_muon then
            case MODE is
                when deltaEta =>
                    lut_o(DETA_DPHI_VECTOR_WIDTH-1 downto 0) <= CONV_STD_LOGIC_VECTOR(MU_MU_DIFF_ETA_LUT(lut_in), DETA_DPHI_VECTOR_WIDTH);
                when deltaPhi =>
                    lut_o(DETA_DPHI_VECTOR_WIDTH-1 downto 0) <= CONV_STD_LOGIC_VECTOR(MU_MU_DIFF_PHI_LUT(lut_in), DETA_DPHI_VECTOR_WIDTH);
                when CoshDeltaEta =>
                    lut_o(MU_MU_COSH_COS_VECTOR_WIDTH-1 downto 0) <= CONV_STD_LOGIC_VECTOR(MU_MU_COSH_DETA_LUT(lut_in), MU_MU_COSH_COS_VECTOR_WIDTH);
                when CosDeltaPhi =>
                    lut_o(MU_MU_COSH_COS_VECTOR_WIDTH-1 downto 0) <= CONV_STD_LOGIC_VECTOR(MU_MU_COS_DPHI_LUT(lut_in), MU_MU_COSH_COS_VECTOR_WIDTH);
            end case;
        end if;
        
    end process lut_p;

end architecture rtl;
