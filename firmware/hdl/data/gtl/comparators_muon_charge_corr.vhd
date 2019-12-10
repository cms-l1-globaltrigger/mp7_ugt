-- Description:
-- Comparators for muon charge correlations.

-- Version-history:
-- HB 2019-12-10: Replaces "MUON/muon" by "MU/mu"
-- HB 2019-10-31: Reduced instances of comp_unsigned with additional if-statements for triple and quad, cleaned up code.
-- HB 2019-10-30: Changed entity name.
-- HB 2019-06-28: Changed types.
-- HB 2018-11-26: First design.

library ieee;
use ieee.std_logic_1164.all;

-- used for CONV_INTEGER
use ieee.std_logic_unsigned.all;

use work.lhc_data_pkg.all;
use work.gtl_pkg.all;

entity comparators_muon_charge_corr is
    generic(
        MODE : comp_mode_cc; -- double, triple or quad
        REQ : std_logic_vector(MUON_CHARGE_WIDTH-1 downto 0)
    );
    port(
        clk : in std_logic;
        cc_double: in muon_cc_double_array := (others => (others => (others => '0')));
        cc_triple: in muon_cc_triple_array := (others => (others => (others => (others => '0'))));
        cc_quad: in muon_cc_quad_array := (others => (others => (others => (others => (others => '0')))));
        comp_o_double : out muon_cc_double_std_logic_array := (others => (others => '0'));
        comp_o_triple : out muon_cc_triple_std_logic_array := (others => (others => (others => '0')));
        comp_o_quad : out muon_cc_quad_std_logic_array := (others => (others => (others => (others => '0'))))
    );
end comparators_muon_charge_corr;

architecture rtl of comparators_muon_charge_corr is
        
    signal cc_double_i :muon_cc_double_array;
    signal cc_triple_i :muon_cc_triple_array;
    signal cc_quad_i :muon_cc_quad_array;
    
    type comp_i_double_array is array (0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1) of std_logic_vector(0 downto 0);
    type comp_i_triple_array is array (0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1) of std_logic_vector(0 downto 0);
    type comp_i_quad_array is array (0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1, 0 to N_MU_OBJECTS-1) of std_logic_vector(0 downto 0);
    signal comp_i_double : comp_i_double_array := (others => (others => (others => '0')));
    signal comp_r_double : comp_i_double_array;
    signal comp_i_triple : comp_i_triple_array := (others => (others => (others => (others => '0'))));
    signal comp_r_triple : comp_i_triple_array;
    signal comp_i_quad : comp_i_quad_array := (others => (others => (others => (others => (others => '0')))));
    signal comp_r_quad : comp_i_quad_array;

begin
    
    l1: for i in 0 to N_MU_OBJECTS-1 generate
        l2: for j in 0 to N_MU_OBJECTS-1 generate
            double_i: if MODE = double generate
                in_reg_i : entity work.reg_mux
                    generic map(MU_CHARGE_WIDTH, IN_REG_COMP)  
                    port map(clk, cc_double(i,j), cc_double_i(i,j));
                comp_i : entity work.comp_unsigned
                    generic map(chargeCorr, "00", "00", REQ)  
                    port map(cc_double_i(i,j), comp_i_double(i,j)(0));
                out_reg_i : entity work.reg_mux
                    generic map(1, OUT_REG_COMP)  
                    port map(clk, comp_i_double(i,j), comp_r_double(i,j));
                comp_o_double(i,j) <= comp_r_double(i,j)(0);
            end generate double_i;
            l3: for k in 0 to N_MU_OBJECTS-1 generate
                triple_i: if MODE = triple generate
                    in_reg_i : entity work.reg_mux
                        generic map(MU_CHARGE_WIDTH, IN_REG_COMP)  
                        port map(clk, cc_triple(i,j,k), cc_triple_i(i,j,k));
                    if_i: if (j/=i and k/=i and k/=j) generate 
                        comp_i : entity work.comp_unsigned
                            generic map(chargeCorr, "00", "00", REQ)  
                            port map(cc_triple_i(i,j,k), comp_i_triple(i,j,k)(0));
                    end generate if_i;
                    out_reg_i : entity work.reg_mux
                        generic map(1, OUT_REG_COMP)  
                        port map(clk, comp_i_triple(i,j,k), comp_r_triple(i,j,k));
                    comp_o_triple(i,j,k) <= comp_r_triple(i,j,k)(0);
                end generate triple_i;
                l4: for l in 0 to N_MU_OBJECTS-1 generate
                    quad_i: if MODE = quad generate
                        in_reg_i : entity work.reg_mux
                            generic map(MU_CHARGE_WIDTH, IN_REG_COMP)  
                            port map(clk, cc_quad(i,j,k,l), cc_quad_i(i,j,k,l));
                        if_i: if (j/=i and k/=i and k/=j and l/=i and l/=j and l/=k) generate 
                            comp_i : entity work.comp_unsigned
                                generic map(chargeCorr, "00", "00", REQ)  
                                port map(cc_quad_i(i,j,k,l), comp_i_quad(i,j,k,l)(0));
                        end generate if_i;
                        out_reg_i : entity work.reg_mux
                            generic map(1, OUT_REG_COMP)  
                            port map(clk, comp_i_quad(i,j,k,l), comp_r_quad(i,j,k,l));
                        comp_o_quad(i,j,k,l) <= comp_r_quad(i,j,k,l)(0);
                    end generate quad_i;
                end generate l4;
            end generate l3;
        end generate l2;
    end generate l1;

end architecture rtl;
