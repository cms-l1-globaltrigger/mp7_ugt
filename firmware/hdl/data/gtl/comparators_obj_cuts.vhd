-- Description:
-- Object cuts comparisons.

-- Version-history:
-- HB 2019-11-06: Inserted logic for CHARGE.
-- HB 2019-09-06: Inserted logic of lut comparator for ISO and QUAL.
-- HB 2019-08-22: Updated for comp_unsigned.
-- HB 2019-08-21: First design.

library ieee;
use ieee.std_logic_1164.all;
-- used for CONV_INTEGER
use ieee.std_logic_unsigned.all;

use work.gtl_pkg.all;

entity comparators_obj_cuts is
    generic(
        N_OBJ : positive;
        DATA_WIDTH : positive;
        MODE : comp_mode;
        MIN_REQ : std_logic_vector(MAX_OBJ_PARAMETER_WIDTH-1 downto 0) := (others => '0');
        MAX_REQ : std_logic_vector(MAX_OBJ_PARAMETER_WIDTH-1 downto 0) := (others => '0');
        LUT : std_logic_vector(MAX_LUT_WIDTH-1 downto 0) := (others => '0');
        REQ_CHARGE: string(1 to 3) := "ign"
    );
    port(
        clk : in std_logic;
        data : in obj_parameter_array;
        comp_o : out std_logic_vector(0 to N_OBJ-1) := (others => '0')
    );
end comparators_obj_cuts;

architecture rtl of comparators_obj_cuts is

    constant MIN_I : std_logic_vector(DATA_WIDTH-1 downto 0) := MIN_REQ(DATA_WIDTH-1 downto 0);
    constant MAX_I : std_logic_vector(DATA_WIDTH-1 downto 0) := MAX_REQ(DATA_WIDTH-1 downto 0);
    signal comp : std_logic_vector(0 to N_OBJ-1);
    type data_i_array is array(0 to N_OBJ-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
    signal data_i : data_i_array;

begin

    l1: for i in 0 to N_OBJ-1 generate
        in_reg_i : entity work.reg_mux
            generic map(DATA_WIDTH, IN_REG_COMP)  
            port map(clk, data(i)(DATA_WIDTH-1 downto 0), data_i(i));
        if_pt: if MODE = GE or MODE = EQ or MODE = NE generate
            comp_unsigned_i: entity work.comp_unsigned
                generic map(MODE, MIN_I, MAX_I)  
                port map(data_i(i), comp(i));
        end generate if_pt;
        if_eta: if MODE = ETA generate
            comp_signed_i : entity work.comp_signed
                generic map(MIN_I, MAX_I)  
                port map(data_i(i), comp(i));
        end generate if_eta;
        if_phi: if MODE = PHI generate
            comp_unsigned_i: entity work.comp_unsigned
                generic map(MODE, MIN_I, MAX_I)  
                port map(data_i(i), comp(i));
        end generate if_phi;
        if_charge: if MODE = CHARGE generate
            comp(i) <= '1' when data_i(i) = "10" and REQ_CHARGE = "pos" else -- charge sign = '0' => positive
                       '1' when data_i(i) = "11" and REQ_CHARGE = "neg" else -- charge sign = '1' => negative
                       '1' when REQ_CHARGE = "ign" else '0';
        end generate if_charge;
        if_iso_qual: if MODE = ISO or MODE = QUAL generate
            comp(i) <= LUT(CONV_INTEGER(data_i(i)));
        end generate if_iso_qual;
    end generate l1;

    out_reg_i : entity work.reg_mux
        generic map(N_OBJ, OUT_REG_COMP)  
        port map(clk, comp, comp_o);

end architecture rtl;
