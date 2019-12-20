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

entity bx_pipe_test is
    port(
        clk : in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        data_o_new : out data_array;
        data_bx_p2  : out std_logic_vector(7 downto 0);
        data_bx_p1  : out std_logic_vector(7 downto 0);
        data_bx_0    : out std_logic_vector(7 downto 0);
        data_bx_m1  : out std_logic_vector(7 downto 0);
        data_bx_m2  : out std_logic_vector(7 downto 0);
        data_o_new_bx_p2  : out std_logic_vector(7 downto 0);
        data_o_new_bx_p1  : out std_logic_vector(7 downto 0);
        data_o_new_bx_0    : out std_logic_vector(7 downto 0);
        data_o_new_bx_m1  : out std_logic_vector(7 downto 0);
        data_o_new_bx_m2  : out std_logic_vector(7 downto 0)
    );
end bx_pipe_test;

architecture rtl of bx_pipe_test is

    signal data_tmp : data_array;
    signal data_int, data_bx_p1_tmp, data_bx_0_tmp, data_bx_m1_tmp, data_bx_m2_tmp : std_logic_vector(7 downto 0);

begin
    
    process(clk, data_in)
        begin
        if (clk'event and clk = '1') then
            data_int <= data_in;
        end if;
    end process;

--     process(clk, data_int)
--     begin
--         data_tmp(BX_PIPELINE_STAGES-1) <= data_int;
--         if (clk'event and clk = '1') then
--             for i in (BX_PIPELINE_STAGES-1) downto 1 loop
--                 data_tmp(i-1) <= data_tmp(i);
--             end loop;
--         end if;
--     end process;
    
    process(clk, data_int)
    begin
        data_tmp(0) <= data_int;
        if (clk'event and clk = '1') then
            for i in 0 to (BX_PIPELINE_STAGES-1)-1 loop
                data_tmp(i+1) <= data_tmp(i);
            end loop;
        end if;
    end process;
    
    data_o_new <= data_tmp;
    
    data_o_new_bx_p2 <= data_tmp(bx(2));
    data_o_new_bx_p1 <= data_tmp(bx(1));
    data_o_new_bx_0 <= data_tmp(bx(0));
    data_o_new_bx_m1 <= data_tmp(bx(-1));
    data_o_new_bx_m2 <= data_tmp(bx(-2));
    
-- legacy
    process(clk, data_int)
        begin
        if (clk'event and clk = '1') then
            data_bx_p1_tmp <= data_int;
            data_bx_0_tmp <= data_bx_p1_tmp;
            data_bx_m1_tmp <= data_bx_0_tmp;
            data_bx_m2_tmp <= data_bx_m1_tmp;
        end if;
    end process;

    data_bx_p2 <= data_int;
    data_bx_p1 <= data_bx_p1_tmp;
    data_bx_0 <= data_bx_0_tmp;
    data_bx_m1 <= data_bx_m1_tmp;
    data_bx_m2 <= data_bx_m2_tmp;

end rtl;

