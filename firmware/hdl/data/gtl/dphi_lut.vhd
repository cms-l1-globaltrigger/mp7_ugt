-- Description:
-- Differences in phi (for dphi and deltaR).

-- Version-history:
-- HB 2019-10-31: Changed name.
-- HB 2019-08-27: Cases for "same objects" and "different objects" (less resources for "same objects").
-- HB 2019-08-22: Updated instance luts_corr_cuts.
-- HB 2019-08-21: Instantiated luts_corr_cuts.
-- HB 2019-07-04: Changed type of outputs (compatible with inputs of comparators_corr_cuts.vhd).
-- HB 2019-06-27: Changed type of inputs.
-- HB 2019-01-11: First design.

library ieee;
use ieee.std_logic_1164.all;

use work.gtl_pkg.all;

entity dphi_lut is
    generic(
        N_OBJ_1 : positive;
        N_OBJ_2 : positive;
        OBJ : obj_type_array
    );
    port(
        sub_phi : in max_phi_range_array;
        diff_phi_o : out corr_cuts_std_logic_array := (others => (others => (others => '0')))
    );
end dphi_lut;

architecture rtl of dphi_lut is

    type diff_phi_i_array is array (0 to N_OBJ_1-1, 0 to N_OBJ_2-1) of std_logic_vector(MAX_COSH_COS_WIDTH-1 downto 0);
    signal diff_phi_i : diff_phi_i_array := (others => (others => (others => '0')));

begin

    l_1: for i in 0 to N_OBJ_1-1 generate
        l_2: for j in 0 to N_OBJ_2-1 generate
            same_obj_t: if (OBJ(1) = OBJ(2)) and j>i generate
                lut_i : entity work.luts_corr_cuts
                    generic map(OBJ, deltaPhi)  
                    port map(sub_phi(i,j), diff_phi_i(i,j));
            end generate same_obj_t;    
            diff_obj_t: if (OBJ(1) /= OBJ(2)) generate
                lut_i : entity work.luts_corr_cuts
                    generic map(OBJ, deltaPhi)  
                    port map(sub_phi(i,j), diff_phi_i(i,j));
            end generate diff_obj_t;    
            l_3: for k in 0 to DETA_DPHI_VECTOR_WIDTH-1 generate
                diff_phi_o(i,j,k) <= diff_phi_i(i,j)(k);
            end generate l_3;
        end generate l_2;
    end generate l_1;
    
end architecture rtl;
