-- Description:
-- Subtraction in eta.

-- Version-history:
-- HB 2019-10-31: Changed name.
-- HB 2019-08-27: Added use clauses.
-- HB 2019-08-27: Cases for "same objects" and "different objects" (less resources for "same objects").
-- HB 2019-06-27: Changed type of outputs.
-- HB 2019-01-11: First design.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

use work.gtl_pkg.all;

entity deta_calc is
    generic(
        N_OBJ_1 : positive;
        N_OBJ_2 : positive;
        OBJ : obj_type_array;
        BX : bx_array
    );
    port(
        eta_1 : in conv_integer_array;
        eta_2 : in conv_integer_array;
        sub_eta_o : out max_eta_range_array := (others => (others => 0))
    );
end deta_calc;

architecture rtl of deta_calc is

begin

-- HB 2019-08-27: REMARK - using module sub_eta_calc.vhd needs more resources!
    loop_1: for i in 0 to N_OBJ_1-1 generate
        loop_2: for j in 0 to N_OBJ_2-1 generate
-- only positive difference in eta
            same_obj_t: if (OBJ(1) = OBJ(2)) and (BX(1) = BX(2)) and j>i generate
                sub_eta_o(i,j) <= abs(eta_1(i) - eta_2(j));
            end generate same_obj_t;    
            diff_obj_t: if (OBJ(1) /= OBJ(2)) or ((OBJ(1) = OBJ(2)) and (BX(1) /= BX(2))) generate
                sub_eta_o(i,j) <= abs(eta_1(i) - eta_2(j));
            end generate diff_obj_t;    
        end generate loop_2;
    end generate loop_1;
                    
end architecture rtl;
