-- Desription:
-- Calculation of charge correlations for muon conditions.

-- Version history:
-- HB 2019-12-18: Improved logic.
-- HB 2019-12-10: Replaces "MUON/muon" by "MU/mu".
-- HB 2019-10-31: Added comments: table of charge correlations.
-- HB 2018-11-26: First design.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

use work.lhc_data_pkg.all;
use work.gtl_pkg.all;

entity muon_charge_correlations is
    port(
        in_1: in obj_parameter_array;
        in_2: in obj_parameter_array;
        cc_double: out muon_cc_double_array;
        cc_triple: out muon_cc_triple_array;
        cc_quad: out muon_cc_quad_array
    );
end muon_charge_correlations;

architecture rtl of muon_charge_correlations is
    
    signal charge_bits1, charge_bits2 : muon_charge_bits_array;
begin

-- *********************************************************
-- CHARGE: 2 bits => charge_valid, charge_sign
-- definition:
-- charge_bits(1) = charge_valid
-- charge_bits(0) = charge_sign
-- charge_sign = '0' => positive muon
-- charge_sign = '1' => negative muon
-- *********************************************************
-- "like sign" (CC_LS) = "01", "opposite sign" (CC_OS) = "10", "not valid charge" (CC_NOT_VALID) = "00"
-- *********************************************************

-- cc_double:
-- + + : LS both positive muons
-- - - : LS both negative muons
-- + - : OS two muons of opposite sign
-- - + : OS two muons of opposite sign

-- cc_triple:
-- + + + : LS three muons of positive charge
-- - - - : LS three muons of negative charge
-- + - - : OS a pair plus a negative muon
-- + + - : OS a pair plus a positive muon
-- + - + : OS a pair plus a positive muon
-- - + + : OS a pair plus a positive muon
-- - - + : OS a pair plus a negative muon
-- - + - : OS a pair plus a negative muon

-- cc_quad:
-- + + + + : LS four muons of positive charge
-- - - - - : LS four muons of negative charge
 -- + + + - : OS a pair plus two positive muons
 -- + + - + : OS a pair plus two positive muons
 -- + + - - : OS two pairs
 -- + - + + : OS a pair plus two positive muons
 -- + - + - : OS two pairs
 -- + - - + : OS two pairs
 -- + - - - : OS a pair plus two negative muons
 -- - + + + : OS a pair plus two positive muons
 -- - + + - : OS two pairs
 -- - + - + : OS two pairs
 -- - + - - : OS a pair plus two negative muons
 -- - - + + : OS two pairs
 -- - - + - : OS a pair plus two negative muons
 -- - - - + : OS a pair plus two negative muons
 
-- *********************************************************
 
    charge_bits_l: for i in 0 to N_MU_OBJECTS-1 generate 
        charge_bits1(i) <= in_1(i)(MU_CHARGE_WIDTH-1 downto 0);
        charge_bits2(i) <= in_2(i)(MU_CHARGE_WIDTH-1 downto 0);
    end generate charge_bits_l;
    
    loop_2_1: for i in 0 to N_MU_OBJECTS-1 generate 
        loop_2_2: for j in 0 to N_MU_OBJECTS-1 generate
-- HB 2015-11-20: charge correlation for different Bx needed for muon muon correlation conditions, therefore removed "if j/=i generate"
            cc_double(i,j) <= CC_NOT_VALID when charge_bits1(i)(MU_CHARGE_WIDTH-1) = '0' or charge_bits2(j)(MU_CHARGE_WIDTH-1) = '0' else -- : not valid
                              CC_LS when charge_bits1(i) = "10" and charge_bits2(j) = "10" else -- + + : LS both positive muons
                              CC_LS when charge_bits1(i) = "11" and charge_bits2(j) = "11" else -- - - : LS both negative muons
                              CC_OS;
        end generate loop_2_2;
    end generate loop_2_1;
    
    loop_3_1: for i in 0 to N_MU_OBJECTS-1 generate 
        loop_3_2: for j in 0 to N_MU_OBJECTS-1 generate 
            loop_3_3: for k in 0 to N_MU_OBJECTS-1 generate 
                if_3: if (j/=i and k/=i and k/=j) generate
                    cc_triple(i,j,k) <= CC_NOT_VALID when charge_bits1(i)(MU_CHARGE_WIDTH-1) = '0' else -- : not valid
                                        CC_LS when charge_bits1(i) = "10" and charge_bits1(j) = "10" and charge_bits1(k) = "10" else -- + + + : LS three muons of positive charge
                                        CC_LS when charge_bits1(i) = "11" and charge_bits1(j) = "11" and charge_bits1(k) = "11" else -- - - - : LS three muons of negative charge
                                        CC_OS;
                end generate if_3;
            end generate loop_3_3;
        end generate loop_3_2;
    end generate loop_3_1;
    
    loop_4_1: for i in 0 to N_MU_OBJECTS-1 generate 
        loop_4_2: for j in 0 to N_MU_OBJECTS-1 generate 
            loop_4_3: for k in 0 to N_MU_OBJECTS-1 generate 
                loop_4_4: for l in 0 to N_MU_OBJECTS-1 generate 
                    if_4: if (j/=i and k/=i and k/=j and l/=i and l/=j and l/=k) generate
                        cc_quad(i,j,k,l) <= CC_NOT_VALID when charge_bits1(i)(MU_CHARGE_WIDTH-1) = '0' else -- : not valid
                                            CC_LS when charge_bits1(i) = "10" and charge_bits1(j) = "10" and charge_bits1(k) = "10" and charge_bits1(l) = "10" else -- + + + + : LS four muons of positive charge
                                            CC_LS when charge_bits1(i) = "11" and charge_bits1(j) = "11" and charge_bits1(k) = "11" and charge_bits1(l) = "11" else -- - - - - : LS four muons of negative charge
                                        CC_OS;
                    end generate if_4;
                end generate loop_4_4;
            end generate loop_4_3;
        end generate loop_4_2;
    end generate loop_4_1;
    
end architecture rtl;
