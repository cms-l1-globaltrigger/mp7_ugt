-- Description:
-- Testbench for simulation of comparators_mass_3_obj.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
library std;                  -- for Printing
use std.textio.all;

use work.gtl_pkg.all;

entity comparators_mass_3_obj_tb is
end comparators_mass_3_obj_tb;

architecture rtl of comparators_mass_3_obj_tb is

    constant LHC_CLK_PERIOD : time := 25 ns;
    constant N_OBJ : positive := 8;
    constant DATA_WIDTH : positive := MAX_CORR_CUTS_WIDTH;
    constant MODE : comp_mode := mass;
    constant MIN_REQ : std_logic_vector(MAX_CORR_CUTS_WIDTH-1 downto 0) := X"00000000000040";
    constant MAX_REQ : std_logic_vector(MAX_CORR_CUTS_WIDTH-1 downto 0) := X"00000000000050";
    
    signal lhc_clk: std_logic;

    type data_array is array (0 to N_OBJ-1, 0 to N_OBJ-1) of std_logic_vector(MAX_CORR_CUTS_WIDTH-1 downto 0);
    signal data_temp : data_array := (others => (others => (others => '0')));
    signal data : corr_cuts_std_logic_array;

--*********************************Main Body of Code**********************************
begin
    
    -- Clock
    process
    begin
        lhc_clk  <=  '1';
        wait for LHC_CLK_PERIOD/2;
        lhc_clk  <=  '0';
        wait for LHC_CLK_PERIOD/2;
    end process;

    process
    begin
        wait for LHC_CLK_PERIOD; 
            data_temp <= (0 => (1 => X"00000000000020", 2 => X"00000000000015", others => X"00000000000000"), 1 => (2 => X"00000000000015", others => X"00000000000000"), others => (others => X"00000000000000"));
        wait for LHC_CLK_PERIOD; 
            data_temp <= (0 => (1 => X"00000000000010", 2 => X"00000000000015", others => X"00000000000000"), 1 => (2 => X"00000000000015", others => X"00000000000000"), others => (others => X"00000000000000"));
        wait for LHC_CLK_PERIOD; 
            data_temp <= (0 => (3 => X"00000000000010", 7 => X"00000000000018", others => X"00000000000000"), 3 => (7 => X"00000000000019", others => X"00000000000000"), others => (others => X"00000000000000"));
        wait for LHC_CLK_PERIOD; 
            data_temp <= (0 => (1 => X"00000000000020", others => X"00000000000000"), others => (others => X"00000000000000"));
        wait;
    end process;

 ------------------- Instantiate  modules  -----------------
 
    l1: for i in 0 to N_OBJ-1 generate
        l2: for j in 0 to N_OBJ-1 generate
            l3: for k in 0 to DATA_WIDTH-1 generate
                data(i,j,k) <= data_temp(i,j)(k);
            end generate l3;
        end generate l2;
    end generate l1;

    dut: entity work.comparators_mass_3_obj
        generic map(N_OBJ, DATA_WIDTH, MODE, MIN_REQ, MAX_REQ)
        port map(lhc_clk, data, open);

end rtl;
