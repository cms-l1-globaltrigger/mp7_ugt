-- Description:
-- Combinatorial conditions

-- Version-history:
-- HB 2020-01-24: Bug fix for quad conditions.
-- HB 2019-12-18: Improved logic.
-- HB 2019-09-03: Bug fix on inputs.
-- HB 2019-07-16: Cleaned up.
-- HB 2019-06-28: Changed types, inserted use clause.
-- HB 2018-12-21: First design.

library ieee;
use ieee.std_logic_1164.all;

use work.lhc_data_pkg.all;
use work.gtl_pkg.all;

entity combinatorial_conditions is
    generic(
        N_OBJ : positive;
        N_REQ : positive;
        SLICES : slices_type_array;
        CHARGE_CORR_SEL : boolean
    );
    port(
        clk : in std_logic;        
        comb_1 : in std_logic_vector(0 to N_OBJ-1) := (others => '0');
        comb_2 : in std_logic_vector(0 to N_OBJ-1) := (others => '0');
        comb_3 : in std_logic_vector(0 to N_OBJ-1) := (others => '0');
        comb_4 : in std_logic_vector(0 to N_OBJ-1) := (others => '0');
        tbpt : in corr_cuts_array(0 to N_OBJ-1, 0 to N_OBJ-1) := (others => (others => '1'));
        charge_corr_double : in muon_cc_double_std_logic_array := (others => (others => '1'));
        charge_corr_triple : in muon_cc_triple_std_logic_array := (others => (others => (others => '1')));
        charge_corr_quad : in muon_cc_quad_std_logic_array := (others => (others => (others => (others => '1'))));
        cond_o : out std_logic
    );
end combinatorial_conditions;

architecture rtl of combinatorial_conditions is

    constant index_len : positive := 4096;
    
    constant N_SLICE_1 : positive := SLICES(1)(1) - SLICES(1)(0) + 1;
    constant N_SLICE_2 : positive := SLICES(2)(1) - SLICES(2)(0) + 1;
    constant N_SLICE_3 : positive := SLICES(3)(1) - SLICES(3)(0) + 1;
    constant N_SLICE_4 : positive := SLICES(4)(1) - SLICES(4)(0) + 1;
    
    signal cond_and_or, cond_o_v : std_logic_vector(0 to 0);

begin

-- AND-OR matrix
    and_or_p: process(comb_1, comb_2, comb_3, comb_4, charge_corr_double, charge_corr_triple, charge_corr_quad, tbpt)
        variable index : integer := 0;
        variable and_vec1 : std_logic_vector(index_len downto 1) := (others => '0');
        variable and_vec2 : std_logic_vector(index_len*2 downto index_len+1) := (others => '0');
        variable and_vec3 : std_logic_vector(index_len*3 downto index_len*2+1) := (others => '0');
        variable and_vec4 : std_logic_vector(index_len*4 downto index_len*3+1) := (others => '0');
        variable tmp1, tmp2, tmp3, tmp4 : std_logic := '0';
    begin
        index := 0;
        and_vec1 := (others => '0');
        and_vec2 := (others => '0');
        and_vec3 := (others => '0');
        and_vec4 := (others => '0');
        tmp1 := '0';
        tmp2 := '0';
        tmp3 := '0';
        tmp4 := '0';
        for i in SLICES(1)(0) to SLICES(1)(1) loop
            if N_REQ = 1 then
                index := index + 1;
                and_vec1(index) := comb_1(i);
            end if;
            for j in SLICES(2)(0) to SLICES(2)(1) loop
                if N_REQ = 2 and (j/=i) then
                    index := index + 1;
                    if CHARGE_CORR_SEL then
                        and_vec1(index) := comb_1(i) and comb_2(j) and charge_corr_double(i,j) and tbpt(i,j);
                    else
                        and_vec1(index) := comb_1(i) and comb_2(j) and tbpt(i,j);
                    end if;
                end if;
                for k in SLICES(3)(0) to SLICES(3)(1) loop
                    if N_REQ = 3 and (j/=i and k/=i and k/=j) then
                        index := index + 1;
                        if CHARGE_CORR_SEL then
                            and_vec1(index) := comb_1(i) and comb_2(j) and comb_3(k) and charge_corr_triple(i,j,k);
                        else
                            and_vec1(index) := comb_1(i) and comb_2(j) and comb_3(k);
                        end if;
                    end if;
                    for l in SLICES(4)(0) to SLICES(4)(1) loop
                        if N_REQ = 4 and (j/=i and k/=i and k/=j and l/=i and l/=j and l/=k) then
                            index := index + 1;
                            if CHARGE_CORR_SEL then
                                if index <= index_len then
                                    and_vec1(index) := comb_1(i) and comb_2(j) and comb_3(k) and comb_4(l) and charge_corr_quad(i,j,k,l);
                                elsif index > index_len and index <= 2*index_len then
                                    and_vec2(index) := comb_1(i) and comb_2(j) and comb_3(k) and comb_4(l) and charge_corr_quad(i,j,k,l);
                                elsif index > 2*index_len and index <= 3*index_len then
                                    and_vec3(index) := comb_1(i) and comb_2(j) and comb_3(k) and comb_4(l) and charge_corr_quad(i,j,k,l);
                                elsif index > 3*index_len and index <= 4*index_len then
                                    and_vec4(index) := comb_1(i) and comb_2(j) and comb_3(k) and comb_4(l) and charge_corr_quad(i,j,k,l);
                                end if;
                            else
                                if index <= index_len then
                                    and_vec1(index) := comb_1(i) and comb_2(j) and comb_3(k) and comb_4(l);
                                elsif index > index_len and index <= 2*index_len then
                                    and_vec2(index) := comb_1(i) and comb_2(j) and comb_3(k) and comb_4(l);
                                elsif index > 2*index_len and index <= 3*index_len then
                                    and_vec3(index) := comb_1(i) and comb_2(j) and comb_3(k) and comb_4(l);
                                elsif index > 3*index_len and index <= 4*index_len then
                                    and_vec4(index) := comb_1(i) and comb_2(j) and comb_3(k) and comb_4(l);
                                end if;
                            end if;
                        end if;
                    end loop;
                end loop;
            end loop;
        end loop;
        for i in 1 to index loop
            if i <= index_len then
                tmp1 := tmp1 or and_vec1(i);
            elsif i > index_len and i <= 2*index_len then
                tmp2 := tmp2 or and_vec2(i);
            elsif i > 2*index_len and i <= 3*index_len then
                tmp3 := tmp3 or and_vec3(i);
            elsif i > 3*index_len and i <= 4*index_len then
                tmp4 := tmp4 or and_vec4(i);
            end if;
        end loop;
        cond_and_or(0) <= tmp1 or tmp2 or tmp3 or tmp4;
    end process and_or_p;

-- Condition output register (default setting: no register)
    out_reg_i : entity work.reg_mux
        generic map(1, OUT_REG_COND)  
        port map(clk, cond_and_or, cond_o_v);
    
    cond_o <= cond_o_v(0);
    
end architecture rtl;



