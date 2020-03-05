-- Description:
-- Summary of 3 masses for 2 objects (of same object type and same bx) used for invariant mass of 3 objects.

-- Version-history:
-- HB 2020-03-05: First design.

library ieee;
use ieee.std_logic_1164.all;

use work.gtl_pkg.all;

entity sum_mass_3_obj is
    generic(
        N_OBJ : positive;
        DATA_WIDTH : positive
    );
    port(
        data : in corr_cuts_std_logic_array;
        sum_o : out sum_mass_array := (others => (others => (others => (others => '0'))))
    );
end sum_mass_3_obj;

architecture rtl of sum_mass_3_obj is

    type data_vec_array is array(0 to N_OBJ-1, 0 to N_OBJ-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
    signal data_vec : data_vec_array;
    type sum_temp_array is array(0 to N_OBJ-1, 0 to N_OBJ-1, 0 to N_OBJ-1) of std_logic_vector(DATA_WIDTH+1 downto 0);
    signal sum_temp : sum_temp_array;
    
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
                        port map(data_vec(i,j), data_vec(i,k), data_vec(j,k), sum_temp(i,j,k));
                end generate sum_i;
                l4_sum: for l in 0 to DATA_WIDTH+1 generate
                    sum_o(i,j,k,l) <= sum_temp(i,j,k)(l);
                end generate l4_sum;    
            end generate l3_sum;    
        end generate l2_sum;
    end generate l1_sum;

end architecture rtl;
