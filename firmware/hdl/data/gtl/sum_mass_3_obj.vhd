-- Description:
-- Comparators for mass with 3 objects (summary of 3 masses for 2 objects) of same object type and same bx.

-- Version-history:
-- HB 2020-03-04: Changed loop for sum_mass.
-- HB 2020-02-24: Changed number of instances of sum_mass_calc.
-- HB 2020-02-17: First design.

library ieee;
use ieee.std_logic_1164.all;

use work.gtl_pkg.all;

entity sum_mass_3_obj is
    generic(
        N_OBJ : positive;
        DATA_WIDTH : positive
    );
    port(
        clk : in std_logic;
        data : in corr_cuts_std_logic_array;
        sum_o : out sum_mass_array(0 to N_OBJ-1, 0 to N_OBJ-1, 0 to N_OBJ-1)
    );
end sum_mass_3_obj;

architecture rtl of sum_mass_3_obj is

    type data_vec_array is array(0 to N_OBJ-1, 0 to N_OBJ-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
    signal data_vec : data_vec_array;
    
begin

    l1_data: for i in 0 to N_OBJ-1 generate
        l2_data: for j in 0 to N_OBJ-1 generate
            l3_data: for k in 0 to DATA_WIDTH-1 generate
                data_vec(i,j)(k) <= data(i,j,k);
            end generate l3_data;
        end generate l2_data;
    end generate l1_data;

    l1_sum: for i in 0 to N_OBJ-1 generate
        l2_sum: for j in 0 to N_OBJ-1 generate
            l3_sum: for k in 0 to N_OBJ-1 generate
                sum_i: if j>i and k>i and k>j generate
                    sum_mass_calc_i: entity work.sum_mass_calc
                        generic map(DATA_WIDTH)  
                        port map(data_vec(i,j), data_vec(i,k), data_vec(j,k), sum_o(i,j,k));
                end generate sum_i;    
            end generate l3_sum;    
        end generate l2_sum;
    end generate l1_sum;

end architecture rtl;
