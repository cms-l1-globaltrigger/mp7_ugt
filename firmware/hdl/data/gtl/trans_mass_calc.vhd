-- Description:
-- Calculation of transverse mass.

-- Version history:
-- HB 2019-12-16: First design.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.math_pkg.all;

use work.gtl_pkg.all;

entity trans_mass_calc is
    generic(
        PT1_WIDTH : positive;
        PT2_WIDTH : positive;
        COSH_COS_WIDTH : positive;
        COSH_COS_PREC : positive;
        MASS_WIDTH : positive    
    );
    port(
        pt1 : in std_logic_vector(PT1_WIDTH-1 downto 0);
        pt2 : in std_logic_vector(PT2_WIDTH-1 downto 0);
        cos_dphi : in std_logic_vector(COSH_COS_WIDTH-1 downto 0);
        trans_mass_sq_div2 : out std_logic_vector(MASS_WIDTH-1 downto 0) := (others => '0')
    );
end trans_mass_calc;

architecture rtl of trans_mass_calc is

    signal one_minus_cos : std_logic_vector(COSH_COS_WIDTH-1 downto 0);

-- HB 2017-09-21: used attribute "use_dsp" instead of "use_dsp48" for "mass" - see warning below
-- MP7 builds, synth_1, runme.log => WARNING: [Synth 8-5974] attribute "use_dsp48" has been deprecated, please use "use_dsp" instead
    attribute use_dsp : string;
    attribute use_dsp of one_minus_cos : signal is "yes";
    attribute use_dsp of trans_mass_sq_div2 : signal is "yes";

begin

-- HB 2016-12-12: calculation of transverse mass with formular M**2/2=pt1*pt2*(1-cos(phi1-phi2))
--                "conv_std_logic_vector((10**COSH_COS_PREC), COSH_COS_WIDTH)" means 1 multiplied with 10**COSH_COS_PREC, converted to std_logic_vector with COSH_COS_WIDTH
    one_minus_cos <= (CONV_STD_LOGIC_VECTOR((10**COSH_COS_PREC), COSH_COS_WIDTH)) - cos_dphi;
    trans_mass_sq_div2 <= pt1 * pt2 * one_minus_cos;
    
end architecture rtl;
