-- Description:
-- Condition for invariant mass with 3 objects (of same type and same bx)

-- Version-history:
-- HB 2020-02-24: Changed number of instances of and_vec.
-- HB 2020-02-19: Inserted charge correlation (for muons).
-- HB 2020-02-18: First design.

library ieee;
use ieee.std_logic_1164.all;

use work.lhc_data_pkg.all;
use work.gtl_pkg.all;

entity mass_3_obj_condition is
    generic(
        N_OBJ : positive;
        SLICES : slices_type_array;
        CHARGE_CORR_SEL : boolean
    );
    port(
        clk : in std_logic;
        in_1 : in std_logic_vector(0 to N_OBJ-1);
        in_2 : in std_logic_vector(0 to N_OBJ-1);        
        in_3 : in std_logic_vector(0 to N_OBJ-1);        
        inv_mass : in mass_3_obj_array(0 to N_OBJ-1, 0 to N_OBJ-1, 0 to N_OBJ-1);
        charge_corr_triple : in muon_cc_triple_std_logic_array := (others => (others => (others => '1')));
        cond_o : out std_logic
    );
end mass_3_obj_condition;

architecture rtl of mass_3_obj_condition is

    constant N_SLICE_1 : positive := SLICES(1)(1) - SLICES(1)(0) + 1;
    constant N_SLICE_2 : positive := SLICES(2)(1) - SLICES(2)(0) + 1;
    constant N_SLICE_3 : positive := SLICES(3)(1) - SLICES(3)(0) + 1;
    signal cond_and_or, cond_o_v : std_logic_vector(0 to 0);

begin

-- AND-OR matrix
    and_or_p: process(in_1, in_2, in_3, inv_mass)
        variable index : integer := 0;
        variable and_vec : std_logic_vector((N_SLICE_1*N_SLICE_2*N_SLICE_3) downto 1) := (others => '0');
        variable tmp : std_logic := '0';
    begin
        index := 0;
        and_vec := (others => '0');
        tmp := '0';
        for i in SLICES(1)(0) to SLICES(1)(1) loop
            for j in SLICES(2)(0) to SLICES(2)(1) loop
                for k in SLICES(3)(0) to SLICES(3)(1) loop
                    if j/=i and k/=i and k/=j then
                        index := index + 1;
                        if CHARGE_CORR_SEL then
                            and_vec(index) := in_1(i) and in_2(j) and in_3(k) and inv_mass(i,j,k) and charge_corr_triple(i,j,k);
                        else
                            and_vec(index) := in_1(i) and in_2(j) and in_3(k) and inv_mass(i,j,k);
                        end if;
                    end if;
                end loop;
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



