
-- Description:
-- Module for twobody_pt.

-- Version history:
-- HB 2019-10-28: Removed generic parameter SIN_COS_WIDTH - used MAX_SIN_COS_WIDTH instead.
-- HB 2019-10-10: Inserted instance of twobody_pt_calc.
-- HB 2019-10-08: Bug fix for pt_sq and cleaned up code.
-- HB 2019-08-20: Changed types.
-- HB 2019-07-02: First design

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.math_pkg.all;

use work.gtl_pkg.all;

entity twobody_pt is
    generic (
        N_OBJ_1 : positive;
        N_OBJ_2 : positive;
        PT1_WIDTH : positive;
        PT2_WIDTH : positive
--         SIN_COS_WIDTH: positive
    );
    port(
        pt1 : in conv_pt_vector_array;
        pt2 : in conv_pt_vector_array;
        cos_phi_1 : in conv_integer_array;
        cos_phi_2 : in conv_integer_array;
        sin_phi_1 : in conv_integer_array;
        sin_phi_2 : in conv_integer_array;
        twobody_pt_o : out corr_cuts_std_logic_array := (others => (others => (others => '0')))
    );
end twobody_pt;

architecture rtl of twobody_pt is

    constant PT_SQ_VECTOR_WIDTH : integer := 2+PT1_WIDTH+PT2_WIDTH+2*MAX_SIN_COS_WIDTH;
    type pt_sq_vector_i_array is array (N_OBJ_1-1 downto 0, N_OBJ_2-1 downto 0) of std_logic_vector(PT_SQ_VECTOR_WIDTH-1 downto 0);
    signal twobody_pt_sq : pt_sq_vector_i_array := (others => (others => (others => '0')));

begin

    l_1: for i in 0 to  N_OBJ_1-1 generate
        l_2: for j in 0 to N_OBJ_2-1 generate
            twobody_pt_calc_i : entity work.twobody_pt_calc
                generic map(PT1_WIDTH, PT2_WIDTH, MAX_SIN_COS_WIDTH)
                port map(pt1(i)(PT1_WIDTH-1 downto 0), pt2(j)(PT2_WIDTH-1 downto 0), cos_phi_1(i), cos_phi_2(j), sin_phi_1(i), sin_phi_2(j), twobody_pt_sq(i,j));
            l_3: for k in 0 to PT_SQ_VECTOR_WIDTH-1 generate
                twobody_pt_o(i,j,k) <= twobody_pt_sq(i,j)(k);                 
            end generate l_3;
        end generate l_2;
    end generate l_1;
        
end architecture rtl;
