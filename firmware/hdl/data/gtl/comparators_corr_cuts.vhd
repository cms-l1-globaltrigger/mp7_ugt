-- Description:
-- Comparators for correlation cuts comparisons.

-- Version-history:
-- HB 2020-01-08: Full matrix for comp.
-- HB 2019-08-27: Cases for "same objects" and "different objects" (less resources for "same objects").
-- HB 2019-08-22: Updated for comp_unsigned.
-- HB 2019-06-27: Changed type of inputs.
-- HB 2018-11-26: First design.

library ieee;
use ieee.std_logic_1164.all;

use work.gtl_pkg.all;

entity comparators_corr_cuts is
    generic(
        N_OBJ_1 : positive;
        N_OBJ_2 : positive;
        OBJ : obj_type_array;
        DATA_WIDTH : positive;
        MODE : comp_mode;
        MIN_REQ : std_logic_vector(MAX_CORR_CUTS_WIDTH-1 downto 0) := (others => '0');
        MAX_REQ : std_logic_vector(MAX_CORR_CUTS_WIDTH-1 downto 0) := (others => '0')
    );
    port(
        clk : in std_logic;
        data : in corr_cuts_std_logic_array;
        comp_o : out corr_cuts_array(0 to N_OBJ_1-1, 0 to N_OBJ_2-1)
    );
end comparators_corr_cuts;

architecture rtl of comparators_corr_cuts is

    constant MIN_I : std_logic_vector(DATA_WIDTH-1 downto 0) := MIN_REQ(DATA_WIDTH-1 downto 0);
    constant MAX_I : std_logic_vector(DATA_WIDTH-1 downto 0) := MAX_REQ(DATA_WIDTH-1 downto 0);
    type data_vec_array is array(0 to N_OBJ_1-1, 0 to N_OBJ_2-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
    signal data_vec, data_vec_i : data_vec_array;
    type comp_array is array (0 to N_OBJ_1-1, 0 to N_OBJ_2-1) of std_logic;
    signal comp_temp, comp : comp_array := (others => (others => '0'));
    type comp_i_array is array (0 to N_OBJ_1, 0 to N_OBJ_2-1) of std_logic_vector(0 downto 0);
    signal comp_i : comp_i_array;
    signal comp_r : comp_i_array;

begin

    l1: for i in 0 to N_OBJ_1-1 generate
        l2: for j in 0 to N_OBJ_2-1 generate
            l3: for k in 0 to DATA_WIDTH-1 generate
                data_vec(i,j)(k) <= data(i,j,k);
            end generate l3;
            in_reg_i : entity work.reg_mux
                generic map(DATA_WIDTH, IN_REG_COMP)  
                port map(clk, data_vec(i,j), data_vec_i(i,j));                
            same_obj_t: if (OBJ(1) = OBJ(2)) and j>i generate
-- less resources
                comp_unsigned_i: entity work.comp_unsigned
                    generic map(MODE, MIN_I, MAX_I)  
                    port map(data_vec_i(i,j), comp_temp(i,j));
                    comp(i,j) <= comp_temp(i,j);
                    comp(j,i) <= comp_temp(i,j);
            end generate same_obj_t;    
            diff_obj_t: if (OBJ(1) /= OBJ(2)) generate
                comp_unsigned_i: entity work.comp_unsigned
                    generic map(MODE, MIN_I, MAX_I)  
                    port map(data_vec_i(i,j), comp(i,j));
            end generate diff_obj_t;    
            comp_i(i,j)(0) <= comp(i,j);
            out_reg_i : entity work.reg_mux
                generic map(1, OUT_REG_COMP) 
                port map(clk, comp_i(i,j), comp_r(i,j)); 
            comp_o(i,j) <= comp_r(i,j)(0);
        end generate l2;
    end generate l1;

end architecture rtl;
