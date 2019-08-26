-- Description:
-- Correlation conditions

-- Version-history:
-- HB 2019-07-16: Cleaned up.
-- HB 2019-06-28: Changed types, inserted use clause.
-- HB 2018-12-21: First design.

library ieee;
use ieee.std_logic_1164.all;

use work.lhc_data_pkg.all;
use work.gtl_pkg.all;

entity correlation_conditions is
    generic(
        N_OBJ_1 : positive;
        N_OBJ_2 : positive;
        SLICES : slices_type_array;
        DETA_SEL : boolean;
        DPHI_SEL : boolean;
        DR_SEL : boolean;
        INV_MASS_SEL : boolean;
        TRANS_MASS_SEL : boolean;
        TBPT_SEL : boolean;
        CHARGE_CORR_SEL : boolean
    );
    port(
        clk : in std_logic;
        in_1 : in std_logic_vector(0 to N_OBJ_1-1);
        in_2 : in std_logic_vector(0 to N_OBJ_2-1);        
        deta : in corr_cuts_array(0 to N_OBJ_1-1, 0 to N_OBJ_2-1) := (others => (others => '1'));
        dphi : in corr_cuts_array(0 to N_OBJ_1-1, 0 to N_OBJ_2-1) := (others => (others => '1'));
        delta_r : in corr_cuts_array(0 to N_OBJ_1-1, 0 to N_OBJ_2-1) := (others => (others => '1'));
        inv_mass : in corr_cuts_array(0 to N_OBJ_1-1, 0 to N_OBJ_2-1) := (others => (others => '1'));
        trans_mass : in corr_cuts_array(0 to N_OBJ_1-1, 0 to N_OBJ_2-1) := (others => (others => '1'));
        tbpt : in corr_cuts_array(0 to N_OBJ_1-1, 0 to N_OBJ_2-1) := (others => (others => '1'));
        charge_corr_double : in muon_cc_double_std_logic_array := (others => (others => '1'));
        cond_o : out std_logic
    );
end correlation_conditions;

architecture rtl of correlation_conditions is

    constant N_SLICE_1 : positive := SLICES(1)(1) - SLICES(1)(0) + 1;
    constant N_SLICE_2 : positive := SLICES(2)(1) - SLICES(2)(0) + 1;
    signal cc_double_i : corr_cuts_array(0 to N_OBJ_1-1, 0 to N_OBJ_2-1) := (others => (others => '1'));
    signal cond_and_or, cond_o_v : std_logic_vector(0 to 0);

begin

-- Creating internal charge correlations for muon objects
    cc_i: if CHARGE_CORR_SEL generate
        l1: for i in 0 to N_MUON_OBJECTS-1 generate
            l2: for j in 0 to N_MUON_OBJECTS-1 generate
                cc_double_i(i,j) <= charge_corr_double(i,j);
             end generate;    
        end generate;    
    end generate;    

-- AND-OR matrix
    and_or_p: process(in_1, in_2, deta, dphi, delta_r, inv_mass, trans_mass, tbpt, cc_double_i)
        variable index : integer := 0;
        variable and_vec : std_logic_vector((N_SLICE_1*N_SLICE_2) downto 1) := (others => '0');
        variable tmp : std_logic := '0';
    begin
        index := 0;
        and_vec := (others => '0');
        tmp := '0';
        for i in SLICES(1)(0) to SLICES(1)(1) loop
            for j in SLICES(2)(0) to SLICES(2)(1) loop
                index := index + 1;
                and_vec(index) := in_1(i) and in_2(j) and deta(i,j) and dphi(i,j) and delta_r(i,j) and 
                    inv_mass(i,j) and trans_mass(i,j) and tbpt(i,j) and cc_double_i(i,j);
            end loop;
        end loop;
        for i in 1 to index loop
            tmp := tmp or and_vec(i);
        end loop;
        cond_and_or(0) <= tmp;
    end process and_or_p;

-- Condition output register (default setting: no register)
    out_reg_i : entity work.reg_mux
        generic map(1, OUT_REG_COND)  
        port map(clk, cond_and_or, cond_o_v);
    
    cond_o <= cond_o_v(0);
    
end architecture rtl;



