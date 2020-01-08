-- Description:
-- DeltaR (based on values from LUTs for diff_eta and diff_phi).

-- Version history:
-- HB 2020-01-08: Full matrix for dr_squared.
-- HB 2019-08-28: Instantiated delta_r_calc.
-- HB 2019-08-27: Cases for "same objects" and "different objects" (less resources for "same objects").
-- HB 2019-07-04: Changed type of inputs (and therefore inserted type conversion).
-- HB 2019-06-28: Changed type of outputs.
-- HB 2018-11-26: First design.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.gtl_pkg.all;

entity delta_r is
    generic(
        N_OBJ_1 : positive;
        N_OBJ_2 : positive;
        OBJ : obj_type_array
    );
    port(
        diff_eta : in corr_cuts_std_logic_array;
        diff_phi : in corr_cuts_std_logic_array;
        dr_squared_o : out corr_cuts_std_logic_array := (others => (others => (others => '0')))
    );
end delta_r;

architecture rtl of delta_r is

    signal diff_eta_i : deta_dphi_vector_array;
    signal diff_phi_i : deta_dphi_vector_array;
    type diff_sq_i_array is array (0 to N_OBJ_1-1, 0 to N_OBJ_2-1) of std_logic_vector((2*DETA_DPHI_VECTOR_WIDTH)-1 downto 0);
    signal diff_eta_squared : diff_sq_i_array;
    signal diff_phi_squared : diff_sq_i_array;
    signal dr_squared_temp, dr_squared : diff_sq_i_array;
    
-- HB 2017-09-21: used "attribute use_dsp" instead of "use_dsp48" for "dr_squared" - see warning below
-- MP7 builds, synth_1, runme.log => WARNING: [Synth 8-5974] attribute "use_dsp48" has been deprecated, please use "use_dsp" instead
    attribute use_dsp : string;
    attribute use_dsp of diff_eta_squared : signal is "yes";
    attribute use_dsp of diff_phi_squared : signal is "yes";
    attribute use_dsp of dr_squared : signal is "yes";

begin

-- HB 2015-11-26: calculation of deltaR**2 with formular deltaR**2 = (eta1-eta2)**2+(phi1-phi2)**2
    l_1: for i in 0 to N_OBJ_1-1 generate
        l_2: for j in 0 to N_OBJ_2-1 generate
            l_3: for k in 0 to DETA_DPHI_VECTOR_WIDTH-1 generate
                diff_eta_i(i,j)(k) <= diff_eta(i,j,k);
                diff_phi_i(i,j)(k) <= diff_phi(i,j,k);
            end generate l_3;            
            same_obj_t: if (OBJ(1) = OBJ(2)) and j>i generate
-- less resources
                delta_r_calc_i : entity work.delta_r_calc
                    port map(
                        diff_eta_i(i,j), diff_phi_i(i,j), dr_squared_temp(i,j)
                    );
                    dr_squared(i,j) <= dr_squared_temp(i,j);
                    dr_squared(j,i) <= dr_squared_temp(i,j);
            end generate same_obj_t;    
            diff_obj_t: if (OBJ(1) /= OBJ(2)) generate
                delta_r_calc_i : entity work.delta_r_calc
                    port map(
                        diff_eta_i(i,j), diff_phi_i(i,j), dr_squared(i,j)
                    );
            end generate diff_obj_t;    
            l_4: for l in 0 to (2*DETA_DPHI_VECTOR_WIDTH)-1 generate
                dr_squared_o(i,j,l) <= dr_squared(i,j)(l);
            end generate l_4;
        end generate l_2;
    end generate l_1;
        
end architecture rtl;
