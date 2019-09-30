-- Description:
-- Package for constant and type definitions of FDL firmware in Global Trigger Upgrade system.

-- HB 2019-09-27: Inserted 3 new constants for fractional prescale and calculate others from those.
-- HB 2019-09-26: New constants PRESCALE_FACTOR_WIDTH and PRESCALER_INCR, updated PRESCALE_FACTOR_INIT (removed PRESCALER_COUNTER_WIDTH and PRESCALER_FRACTION_WIDTH).
-- HB 2019-07-03: New package for FDL (moved from gtl_pkg.vhd)

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use work.lhc_data_pkg.all;
use work.gt_mp7_core_pkg.all;
use work.l1menu_pkg.ALL;
use work.math_pkg.all;

package fdl_pkg is

-- ========================================================

-- HB 2014-09-09: FDL firmware major, minor and revision versions moved to gt_mp7_core_pkg.vhd (GTL_FW_MAJOR_VERSION, etc.)
--                for creating a tag name by a script independent from L1Menu.
-- FDL firmware version
    constant FDL_FW_VERSION : std_logic_vector(31 downto 0) := X"00" &
           std_logic_vector(to_unsigned(FDL_FW_MAJOR_VERSION, 8)) &
           std_logic_vector(to_unsigned(FDL_FW_MINOR_VERSION, 8)) &
           std_logic_vector(to_unsigned(FDL_FW_REV_VERSION, 8));

-- *******************************************************************************************************
-- FDL definitions
-- Definitions for prescalers (for FDL !)

-- HB 2019-09-27: changed for proposal of A. Bocci

    constant PRESCALE_FACTOR_INIT_VALUE : integer := 1;
    constant PRESCALE_FACTOR_FRACTION_DIGITS : integer := 2;
    constant PRESCALE_FACTOR_MAX_VALUE : integer := 10000; -- max. 42949672 if 2 digits (=0xFFFFFFA0), max. 429496729 if 1 digits (=0xFFFFFFFA)
--     constant PRESCALE_FACTOR_WIDTH : integer := 20;
    constant PRESCALE_FACTOR_WIDTH : integer := log2c(PRESCALE_FACTOR_MAX_VALUE * (10**PRESCALE_FACTOR_FRACTION_DIGITS));
--     constant PRESCALE_FACTOR_INIT : ipb_regs_array(0 to MAX_NR_ALGOS-1) := (others => X"0000000A"); -- 1.0 if fraction is one digit (=10)
--     constant PRESCALE_FACTOR_INIT : ipb_regs_array(0 to MAX_NR_ALGOS-1) := (others => X"00000064"); -- 1.00 if fraction is two digits (=100)
    constant PRESCALE_FACTOR_INIT_VALUE_VEC : std_logic_vector(31 downto 0) := CONV_STD_LOGIC_VECTOR((PRESCALE_FACTOR_INIT_VALUE*(10**PRESCALE_FACTOR_FRACTION_DIGITS)), 32);
    constant PRESCALE_FACTOR_INIT : ipb_regs_array(0 to MAX_NR_ALGOS-1) := (others => PRESCALE_FACTOR_INIT_VALUE_VEC);
--     constant PRESCALER_INCR : std_logic_vector(PRESCALE_FACTOR_WIDTH-1 downto 0) := X"00000A"; -- 1.0 if fraction is one digit (=10)
--     constant PRESCALER_INCR : std_logic_vector(PRESCALE_FACTOR_WIDTH-1 downto 0) := X"00064"; -- 1.00 if fraction is two digits (=100)
    constant PRESCALER_INCR : std_logic_vector(31 downto 0) := CONV_STD_LOGIC_VECTOR((10**PRESCALE_FACTOR_FRACTION_DIGITS), 32);
    
-- Definitions for rate counters
    constant RATE_COUNTER_WIDTH : integer := 32;
-- HB 2014-02-28: changed vector length of init values for finor- and veto-maks, because of min. 32 bits for register
    constant MASKS_INIT : ipb_regs_array(0 to MAX_NR_ALGOS-1) := (others => X"00000001"); --Finor and veto masks registers (bit 0 = finor, bit 1 = veto)

-- HB HB 2016-03-02: type definition for "global" index use.
    type prescale_factor_global_array is array (MAX_NR_ALGOS-1 downto 0) of std_logic_vector(31 downto 0);
    type prescale_factor_array is array (NR_ALGOS-1 downto 0) of std_logic_vector(31 downto 0); -- same width as PCIe data

-- HB HB 2016-03-02: type definition for "global" index use.
    type rate_counter_global_array is array (MAX_NR_ALGOS-1 downto 0) of std_logic_vector(RATE_COUNTER_WIDTH-1 downto 0);
    type rate_counter_array is array (NR_ALGOS-1 downto 0) of std_logic_vector(RATE_COUNTER_WIDTH-1 downto 0);

-- *******************************************************************************************************
    
end package;
