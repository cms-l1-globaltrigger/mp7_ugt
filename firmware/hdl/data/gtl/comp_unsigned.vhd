-- Description:
-- Unsigned comparator.

-- Version-history:
-- HB 2019-12-10: Replaced "MUON" by "MU".
-- HB 2019-08-22: Inserted case chargeCorr.
-- HB 2019-08-21: First design.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.gtl_pkg.all;

entity comp_unsigned is
    generic(
        MODE: comp_mode;
        limit_l: std_logic_vector;
        limit_h: std_logic_vector;
        CC_REQ: std_logic_vector(MU_CHARGE_WIDTH-1 downto 0) := (others => '0')
    );
    port(
        data: in std_logic_vector;
        comp_o: out std_logic
    );
end comp_unsigned;

architecture rtl of comp_unsigned is
begin

    if_ge: if MODE = twoBodyPt or MODE = GE generate
        comp_o <= '1' when data >= limit_l else '0';
    end generate if_ge;
    if_range: if MODE = deltaEta or MODE = deltaPhi or MODE = deltaR or MODE = mass generate
        comp_o <= '1' when (data >= limit_l) and (data <= limit_h) else '0';
    end generate if_range;
    if_eq: if MODE = EQ generate
        comp_o <= '1' when data = limit_l else '0';
    end generate if_eq;
    if_ne: if MODE = NE generate
        comp_o <= '1' when data /= limit_l else '0';
    end generate if_ne;
    if_phi: if MODE = PHI generate
        comp_o <= '1' when (limit_h < limit_l) and ((data <= limit_h) or (data >= limit_l)) else
                  '1' when (limit_h >= limit_l) and ((data <= limit_h) and (data >= limit_l)) else '0';
    end generate if_phi;
    if_cc: if MODE = chargeCorr generate
        comp_o <= '1' when ((data = CC_LS) and (CC_REQ = CC_LS)) or ((data = CC_OS) and (CC_REQ = CC_OS)) else '0';
    end generate if_cc;

end architecture rtl;
