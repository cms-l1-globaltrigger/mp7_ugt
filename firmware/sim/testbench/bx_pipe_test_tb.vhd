-- Description:
-- Testbench for bx pipeline test

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
library std;                  -- for Printing
use std.textio.all;

use work.bx_pipe_test_pkg.all;

entity bx_pipe_test_tb is
end bx_pipe_test_tb;

architecture rtl of bx_pipe_test_tb is

    constant LHC_CLK_PERIOD : time := 25 ns;
    signal clk: std_logic;

    signal data_in : std_logic_vector(7 downto 0) := X"00";
    signal data_tmp : data_array;

--*********************************Main Body of Code**********************************
begin
    
    -- Clock
    process
    begin
        clk  <=  '1';
        wait for LHC_CLK_PERIOD/2;
        clk  <=  '0';
        wait for LHC_CLK_PERIOD/2;
    end process;

    process
    begin
        wait for LHC_CLK_PERIOD; 
            data_in <= X"01";
        wait for LHC_CLK_PERIOD; 
            data_in <= X"02";
        wait for LHC_CLK_PERIOD; 
            data_in <= X"03";
        wait for LHC_CLK_PERIOD; 
            data_in <= X"04";
        wait for LHC_CLK_PERIOD; 
            data_in <= X"05";
        wait for LHC_CLK_PERIOD; 
            data_in <= X"06";
        wait for LHC_CLK_PERIOD; 
            data_in <= X"07";
        wait for LHC_CLK_PERIOD; 
            data_in <= X"08";
        wait;
    end process;

 ------------------- Instantiate  modules  -----------------

    dut: entity work.bx_pipe_test
        port map(
            clk, data_in, open
        );

end rtl;

