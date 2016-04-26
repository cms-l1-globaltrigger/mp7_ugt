-------------------------------------------------------------------------------
-- Synthesizer : ISE 14.6
-- Platform    : Linux Ubuntu 14.04
-- Targets     : Synthese
--------------------------------------------------------------------------------
-- This work is held in copyright as an unpublished work by HEPHY (Institute
-- of High Energy Physics) All rights reserved.  This work may not be used
-- except by authorized licensees of HEPHY. This work is the
-- confidential information of HEPHY.
--------------------------------------------------------------------------------
---Description: Mux
-- $HeadURL: svn://heros.hephy.oeaw.ac.at/GlobalTriggerUpgrade/firmware/tdf_mp7/trunk/src/tdf_mp7_core/mux/mux.vhd $
-- $Date: 2014-11-17 18:19:16 +0100 (Mon, 17 Nov 2014) $
-- $Author: wittmann $
-- $Revision: 3435 $

library ieee;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.mp7_data_types.all;

entity mux is
    generic(
        MAX_DELAY: positive := 6
    );
    port
    (   clk    : in std_logic;
        lhc_clk: in std_logic;
        res    : in std_logic;
        bcres  : in std_logic; -- bcres 40 MHz
        delay  : in std_logic_vector(log2c(MAX_DELAY)-1 downto 0);
        -- 6 inputs for 40MHz -> 240MHz
        in0    : in lword;
        in1    : in lword;
        in2    : in lword;
        in3    : in lword;
        in4    : in lword;
        in5    : in lword;
        -- output
        mux_out   : out lword
    );
end mux;

architecture arch of mux is
    signal s_out    : lword;
    signal frame_cntr  : std_logic_vector (2 downto 0); --counter for frame mux: 0 to 5
    signal bcres_240, bcres_240_delayed, bcres_s, temp0, temp1: std_logic;
begin

    --=============================--
    process(res, lhc_clk)
    --=============================--
    begin
        if res = '1' then
            bcres_s <= '0';
        elsif rising_edge(lhc_clk) then
            bcres_s <= bcres;
        end if;
    end process;

    --=============================--
    process(res, clk)
    --=============================--
    begin
        if res = '1' then
            temp0 <= '0';
            temp1 <= '0';
            bcres_240 <= '0';
        elsif rising_edge(clk) then
            temp0 <= bcres_s;
            temp1 <= temp0;
            bcres_240 <= temp0 and not temp1;
        end if;
    end process;

    bcres240_delay_i: entity work.delay_element
    generic map(
        DATA_WIDTH  => 1,
        MAX_DELAY  => MAX_DELAY
    )
    port map(
        lhc_clk     => clk,
        lhc_rst     => res,
        data_i      => bcres_240,
        data_o      => bcres_240_delayed,
        valid_i     => '1',
        valid_o     => open,
        delay       => delay
    );

    -- frame counter
    frame_counter: process (clk, res)
    begin
        if (res = '1') then
           frame_cntr <= "000";      -- async. res
        elsif (clk'event and clk = '1') then
            if (frame_cntr = "101") or (bcres_240_delayed = '1') then
                frame_cntr <= "000";   -- sync BCReset
            else
                frame_cntr <= frame_cntr + '1';
            end if;
        end if;
    end process frame_counter;

    s_out   <=  in0 when frame_cntr = "000" else
                in1 when frame_cntr = "001" else
                in2 when frame_cntr = "010" else
                in3 when frame_cntr = "011" else
                in4 when frame_cntr = "100" else
                in5 when frame_cntr = "101" else
                ((others => '0'), '0', '0', '0');

    sync : process(clk)
    begin
        if rising_edge(clk) then
            mux_out <= s_out;
        end if;
    end process;

end architecture;


