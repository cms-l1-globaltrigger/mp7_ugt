-- Description:
-- Comparators for mass with 3 objects (input: summary of 3 invariant masses of 2 objects of same object type and same bx).

-- Version-history:
-- HB 2020-03-06: Changed logic: sum mass outside of comparator.
-- HB 2020-03-04: Changed loop for sum_mass.
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
        sum_mass : in sum_mass_array;
        comp_o : out mass_3_obj_array(0 to N_OBJ-1, 0 to N_OBJ-1, 0 to N_OBJ-1)
    );
end comparators_mass_3_obj;

architecture rtl of comparators_mass_3_obj is

    constant MIN_I : std_logic_vector(DATA_WIDTH-1 downto 0) := MIN_REQ(DATA_WIDTH-1 downto 0);
    constant MAX_I : std_logic_vector(DATA_WIDTH-1 downto 0) := MAX_REQ(DATA_WIDTH-1 downto 0);
    type sum_mass_vec_array is array (0 to N_OBJ, 0 to N_OBJ-1, 0 to N_OBJ-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
    signal sum_mass_vec, sum_mass_i : sum_mass_vec_array := (others => (others => (others => (others => '0'))));   
    signal comp_temp, comp : mass_3_obj_array(0 to N_OBJ-1, 0 to N_OBJ-1, 0 to N_OBJ-1) := (others => (others => (others => '0')));
    type comp_i_array is array (0 to N_OBJ, 0 to N_OBJ-1, 0 to N_OBJ-1) of std_logic_vector(0 downto 0);
    signal comp_ri : comp_i_array;
    signal comp_ro : comp_i_array;
    
begin

    l1_comp: for i in 0 to N_OBJ-1 generate
        l2_comp: for j in 0 to N_OBJ-1 generate
            l3_comp: for k in 0 to N_OBJ-1 generate
                l_in: for l in 0 to DATA_WIDTH-1 generate
                    sum_mass_vec(i,j,k)(l) <= sum_mass(i,j,k,l);
                end generate l_in;
                comp_i: if j>i and k>i and k>j generate
                    in_reg_i : entity work.reg_mux
                        generic map(DATA_WIDTH, IN_REG_COMP)  
                        port map(clk, sum_mass_vec(i,j,k), sum_mass_i(i,j,k));                
                    comp_unsigned_i: entity work.comp_unsigned
                        generic map(MODE, MIN_I, MAX_I)  
                        port map(sum_mass_i(i,j,k), comp_temp(i,j,k));
                    comp(i,j,k) <= comp_temp(i,j,k);
                    comp(i,k,j) <= comp_temp(i,j,k);
                    comp(j,i,k) <= comp_temp(i,j,k);
                    comp(j,k,i) <= comp_temp(i,j,k);
                    comp(k,i,j) <= comp_temp(i,j,k);
                    comp(k,j,i) <= comp_temp(i,j,k);                    
                end generate comp_i;    
                comp_ri(i,j,k)(0) <= comp(i,j,k);
                out_reg_i : entity work.reg_mux
                    generic map(1, OUT_REG_COMP) 
                    port map(clk, comp_ri(i,j,k), comp_ro(i,j,k)); 
                comp_o(i,j,k) <= comp_ro(i,j,k)(0);
            end generate l3_comp;    
        end generate l2_comp;
    end generate l1_comp;

end architecture rtl;
