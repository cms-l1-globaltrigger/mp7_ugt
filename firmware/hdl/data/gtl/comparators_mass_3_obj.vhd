-- Description:
-- Comparators for mass with 3 objects (summary of 3 masses for 2 objects) of same object type and same bx.

-- Version-history:
-- HB 2020-03-03: Changed loop for sum_mass.
-- HB 2020-02-24: Changed number of instances of sum_mass_calc.
-- HB 2020-02-17: First design.

library ieee;
use ieee.std_logic_1164.all;

use work.gtl_pkg.all;

entity comparators_mass_3_obj is
    generic(
        N_OBJ : positive;
        DATA_WIDTH : positive;
        MODE : comp_mode;
        MIN_REQ : std_logic_vector(MAX_CORR_CUTS_WIDTH-1 downto 0) := (others => '0');
        MAX_REQ : std_logic_vector(MAX_CORR_CUTS_WIDTH-1 downto 0) := (others => '0')
    );
    port(
        clk : in std_logic;
        data : in corr_cuts_std_logic_array;
        comp_o : out mass_3_obj_array(0 to N_OBJ-1, 0 to N_OBJ-1, 0 to N_OBJ-1)
    );
end comparators_mass_3_obj;

architecture rtl of comparators_mass_3_obj is

    constant MIN_I : std_logic_vector(DATA_WIDTH-1 downto 0) := MIN_REQ(DATA_WIDTH-1 downto 0);
    constant MAX_I : std_logic_vector(DATA_WIDTH-1 downto 0) := MAX_REQ(DATA_WIDTH-1 downto 0);
    type data_vec_array is array(0 to N_OBJ-1, 0 to N_OBJ-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
    signal data_vec, data_vec_i : data_vec_array;
    type sum_mass_array is array(0 to N_OBJ-1, 0 to N_OBJ-1, 0 to N_OBJ-1) of std_logic_vector(DATA_WIDTH+1 downto 0);
    signal sum_mass_temp, sum_mass : sum_mass_array := (others => (others => (others => (others => '0'))));   
    signal comp : mass_3_obj_array(0 to N_OBJ-1, 0 to N_OBJ-1, 0 to N_OBJ-1) := (others => (others => (others => '0')));
    type comp_i_array is array (0 to N_OBJ, 0 to N_OBJ-1, 0 to N_OBJ-1) of std_logic_vector(0 downto 0);
    signal comp_i : comp_i_array;
    signal comp_r : comp_i_array;

begin

    l1: for i in 0 to N_OBJ-1 generate
        l2: for j in 0 to N_OBJ-1 generate
            l3: for k in 0 to DATA_WIDTH-1 generate
                data_vec(i,j)(k) <= data(i,j,k);
            end generate l3;
            in_reg_i : entity work.reg_mux
                generic map(DATA_WIDTH, IN_REG_COMP)  
                port map(clk, data_vec(i,j), data_vec_i(i,j));                
        end generate l2;
    end generate l1;

    l1sum: for i in 0 to N_OBJ-1 generate
        l2sum: for j in 0 to N_OBJ-1 generate
            l3sum: for k in 0 to N_OBJ-1 generate
                sum_i: if j>i and k>i and k>j generate
                    sum_mass_calc_i: entity work.sum_mass_calc
                        generic map(DATA_WIDTH)  
                        port map(data_vec_i(i,j), data_vec_i(i,k), data_vec_i(j,k), sum_mass_temp(i,j,k));
                    sum_mass(i,j,k) <= sum_mass_temp(i,j,k);
                    sum_mass(i,k,j) <= sum_mass_temp(i,j,k);
                    sum_mass(j,i,k) <= sum_mass_temp(i,j,k);
                    sum_mass(j,k,i) <= sum_mass_temp(i,j,k);
                    sum_mass(k,i,j) <= sum_mass_temp(i,j,k);
                    sum_mass(k,j,i) <= sum_mass_temp(i,j,k);                    
                end generate sum_i;    
            end generate l3sum;    
        end generate l2sum;
    end generate l1sum;

    l1comp: for i in 0 to N_OBJ-1 generate
        l2comp: for j in 0 to N_OBJ-1 generate
            l3comp: for k in 0 to N_OBJ-1 generate
                comp_i: if j/=i and /=i and k/=j generate
                    comp_unsigned_i: entity work.comp_unsigned
                        generic map(MODE, MIN_I, MAX_I)  
                        port map(sum_mass(i,j,k), comp(i,j,k));
                end generate comp_i;    
                comp_i(i,j,k)(0) <= comp(i,j,k);
                out_reg_i : entity work.reg_mux
                    generic map(1, OUT_REG_COMP) 
                    port map(clk, comp_i(i,j,k), comp_r(i,j,k)); 
                comp_o(i,j,k) <= comp_r(i,j,k)(0);
            end generate l3comp;    
        end generate l2comp;
    end generate l1comp;

end architecture rtl;
