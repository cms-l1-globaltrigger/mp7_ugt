-- Description:
-- Calculation of sum mass of 3 objects.

-- Version history:
-- HB 2020-02-18: First design.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.gtl_pkg.all;

entity sum_mass_calc is
    generic(
        DATA_WIDTH : positive
    );
    port(
        in1 : in std_logic_vector(DATA_WIDTH-1 downto 0);
        in2 : in std_logic_vector(DATA_WIDTH-1 downto 0);
        in3 : in std_logic_vector(DATA_WIDTH-1 downto 0);
        sum_mass : out std_logic_vector(DATA_WIDTH+1 downto 0)
    );
end sum_mass_calc;

architecture rtl of sum_mass_calc is

    signal sum_mass_1 : std_logic_vector(DATA_WIDTH downto 0);
    
begin

    sum_mass_1 <= ('0' & in1) + in2;
    sum_mass <= ('0' & sum_mass_1) + in3;
          
end architecture rtl;
