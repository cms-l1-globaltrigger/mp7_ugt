-- Description:
-- Calculation of invariant mass.

-- Version history:
-- HB 2019-09-25: Revert to splitted equation for DSP.
-- HB 2019-09-06: Cleaned up.
-- HB 2019-08-27: Splitted equation for DSP.
-- HB 2019-08-21: First design.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.gtl_pkg.all;

entity inv_mass_calc is
    generic(
        PT1_WIDTH : positive;
        PT2_WIDTH : positive;
        COSH_COS_WIDTH : positive;
        MASS_WIDTH : positive    
    );
    port(
        pt1 : in std_logic_vector(PT1_WIDTH-1 downto 0);
        pt2 : in std_logic_vector(PT2_WIDTH-1 downto 0);
        cosh_deta : in std_logic_vector(COSH_COS_WIDTH-1 downto 0);
        cos_dphi : in std_logic_vector(COSH_COS_WIDTH-1 downto 0);
        inv_mass_sq_div2 : out std_logic_vector(MASS_WIDTH-1 downto 0) := (others => '0')
    );
end inv_mass_calc;

architecture rtl of inv_mass_calc is

    signal cosh_cos : std_logic_vector(COSH_COS_WIDTH-1 downto 0);

-- HB 2017-09-21: used attribute "use_dsp" instead of "use_dsp48" for "mass" - see warning below
-- MP7 builds, synth_1, runme.log => WARNING: [Synth 8-5974] attribute "use_dsp48" has been deprecated, please use "use_dsp" instead
    attribute use_dsp : string;
    attribute use_dsp of cosh_cos : signal is "yes";
    attribute use_dsp of inv_mass_sq_div2 : signal is "yes";

begin

-- HB 2015-10-01: calculation of invariant mass with formular M**2/2=pt1*pt2*(cosh(eta1-eta2)-cos(phi1-phi2))
--     inv_mass_sq_div2 <= pt1(PT1_WIDTH-1 downto 0) * pt2(PT2_WIDTH-1 downto 0) * ((cosh_deta(COSH_COS_WIDTH-1 downto 0)) - (cos_dphi(COSH_COS_WIDTH-1 downto 0)));
    cosh_cos <= cosh_deta - cos_dphi;
    inv_mass_sq_div2 <= pt1 * pt2 * cosh_cos;
           
end architecture rtl;
