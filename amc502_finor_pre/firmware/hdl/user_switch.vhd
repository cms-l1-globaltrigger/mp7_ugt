library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity user_switch is
    port
    (
        user_in    : in  std_logic_vector(6 downto 0); --user switch input
        id_out     : out  std_logic_vector(3 downto 0);
        loc_out    : out std_logic_vector(2 downto 0);
        mac_out    : out  std_logic_vector(47 downto 0);
        ip_out     : out std_logic_vector(31 downto 0)
    );

end user_switch;

architecture rtl of user_switch is

	signal id: std_logic_vector(3 downto 0);
	signal loc: std_logic_vector(2 downto 0);
	signal mac: std_logic_vector(47 downto 0);
    signal ip: std_logic_vector(31 downto 0);
    signal ip_hi: std_logic_vector(31 downto 8);
    signal ip_lo: std_logic_vector(7 downto 0);
    signal ip_const: std_logic_vector(7 downto 0);
    signal mac_lo: std_logic_vector(7 downto 0);
    signal mac_const: std_logic_vector(7 downto 0);

begin

    id  <= user_in(3 downto 0);
    loc <= user_in(6 downto 4);

    ip_hi       <=  X"C0A801" when loc = "000" else -- loc 0 is Vienna crate1     - the first 3 IP digits (192.168.1.X)
                    X"0AB083" when loc = "001" else -- loc 1 is CERN P5 production crate  - the first 3 IP digits (10.176.131.X)
                    X"0AB083" when loc = "011" else -- loc 2 is CERN P5 testcrate - the first 3 IP digits (10.176.131.X)
                    (others => '0');

    ip_const    <=  X"C8" when loc = "000" else -- loc 0 is Vienna crate1 - the start value of the 4th IP digit (.200)
                    X"23" when loc = "001" else -- loc 1 is CERN P5 production crate - the start value of the 4th IP digit (.35)
                    X"C3" when loc = "011" else -- loc 2 is CERN P5 testcrate - the start value of the 4th IP digit (.195)
                    (others => '0');

    mac_const    <= X"C8" when loc = "000" else -- loc 0 is Vienna crate1 - last MAC value (200)
                    X"C8" when loc = "001" else -- loc 1 is CERN P5 production crate - last MAC value (200)
                    X"A5" when loc = "011" else -- loc 2 is CERN P5 testcrate - last MAC value (165)
                    (others => '0');

    ip_lo       <=  std_logic_vector(unsigned(ip_const) + unsigned(id)); --adding slot # to fix value
    ip          <=  ip_hi & ip_lo; -- generating ip address

    mac_lo      <=  std_logic_vector(unsigned(mac_const) + unsigned(id)); --adding slot # to fix value
    mac         <=  X"080030F304" & mac_lo; -- generate mac from fixed part and 4 user_sw inputs


    -- outputs
    id_out      <=  id;
    loc_out     <=  loc;
    ip_out      <=  ip;
    mac_out     <=  mac; --X"1EED19271A16";

end rtl;
