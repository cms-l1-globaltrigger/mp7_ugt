-- Description:
-- Differences in phi.

-- Version-history:
-- HB 2019-10-31: Changed name.
-- HB 2019-08-27: Cases for "same objects" and "different objects" (less resources for "same objects").
-- HB 2019-06-27: Changed type of outputs.
-- HB 2019-01-11: First design.

library ieee;
use ieee.std_logic_1164.all;

use work.gtl_pkg.all;

entity dphi_calc is
    generic(
        N_OBJ_1 : positive;
        N_OBJ_2 : positive;
        OBJ : obj_type_array;
        BX : bx_array;
        PHI_HALF_RANGE : positive
    );
    port(
        phi_1 : in conv_integer_array;
        phi_2 : in conv_integer_array;
        sub_phi_o : out max_phi_range_array := (others => (others => 0))
    );
end dphi_calc;

architecture rtl of dphi_calc is

    signal sub_temp : max_phi_range_array := (others => (others => 0));
    
begin
    
-- HB 2019-08-27: REMARK - using module sub_phi_calc.vhd needs more resources!
    loop_1: for i in 0 to N_OBJ_1-1 generate
        loop_2: for j in 0 to N_OBJ_2-1 generate
            same_obj_t: if (OBJ(1) = OBJ(2)) and (BX(1) = BX(2)) and j>i generate
                sub_temp(i,j) <= abs(phi_1(i) - phi_2(j));
                sub_phi_o(i,j) <= sub_temp(i,j) when (sub_temp(i,j) < PHI_HALF_RANGE) else (PHI_HALF_RANGE*2-sub_temp(i,j));
            end generate same_obj_t;    
            diff_obj_t: if (OBJ(1) /= OBJ(2)) or ((OBJ(1) = OBJ(2)) and (BX(1) /= BX(2))) generate
                sub_temp(i,j) <= abs(phi_1(i) - phi_2(j));
                sub_phi_o(i,j) <= sub_temp(i,j) when (sub_temp(i,j) < PHI_HALF_RANGE) else (PHI_HALF_RANGE*2-sub_temp(i,j));
            end generate diff_obj_t;    
        end generate loop_2;
    end generate loop_1;

end architecture rtl;
