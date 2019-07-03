-- Description:
-- Differences in eta with LUTs.

-- Version-history:
-- HB 2019-06-27: Changed type of inputs.
-- HB 2019-01-11: First design.

library ieee;
use ieee.std_logic_1164.all;

-- used for CONV_STD_LOGIC_VECTOR
use ieee.std_logic_arith.all;
-- used for CONV_INTEGER
use ieee.std_logic_unsigned.all;

use work.gtl_pkg.all;
use work.lut_pkg.all;

entity diff_eta_lut is
    generic(
        N_OBJ_1 : positive;
        N_OBJ_2 : positive;
        OBJ : obj_type_array
    );
    port(
        sub_eta : in max_eta_range_array;
        diff_eta_o : out deta_dphi_vector_array := (others => (others => (others => '0')))
    );
end diff_eta_lut;

architecture rtl of diff_eta_lut is

begin

    diff_eta_p: process(sub_eta)
        variable calo_calo, calo_muon, muon_muon : boolean := false;    
    begin
        if_1: if OBJ(1) = eg_t or OBJ(1) = jet_t or OBJ(1) = tau_t then
            if_2: if OBJ(2) = eg_t or OBJ(2) = jet_t or OBJ(2) = tau_t then
                calo_calo := true;
            end if;
        end if;
        if_3: if OBJ(1) = eg_t or OBJ(1) = jet_t or OBJ(1) = tau_t then
            if_4: if OBJ(2) = muon_t then
                calo_muon := true;
            end if;
        end if;
        if_5: if OBJ(1) = muon_t then
            if_6: if OBJ(2) = muon_t then
                muon_muon := true;
            end if;
        end if;
        loop_1: for i in 0 to N_OBJ_1-1 loop
            loop_2: for j in 0 to N_OBJ_2-1 loop
                calo_calo_i: if (calo_calo) then
                    diff_eta_o(i,j) <= CONV_STD_LOGIC_VECTOR(CALO_CALO_DIFF_ETA_LUT(sub_eta(i,j)), DETA_DPHI_VECTOR_WIDTH);
                end if;
                calo_muon_i: if (calo_muon) then
                    diff_eta_o(i,j) <= CONV_STD_LOGIC_VECTOR(CALO_MU_DIFF_ETA_LUT(sub_eta(i,j)), DETA_DPHI_VECTOR_WIDTH);
                end if;
                muon_muon_i: if (muon_muon) then
                    diff_eta_o(i,j) <= CONV_STD_LOGIC_VECTOR(MU_MU_DIFF_ETA_LUT(sub_eta(i,j)), DETA_DPHI_VECTOR_WIDTH);
                end if;
            end loop loop_2;
        end loop loop_1;
    end process diff_eta_p;

end architecture rtl;
