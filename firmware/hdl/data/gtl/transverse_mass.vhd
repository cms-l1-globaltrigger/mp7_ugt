-- Description:
-- Calculation of transverse mass based on LUTs.

-- Version history:
-- HB 2020-01-08: Full matrix for transverse_mass_sq_div.
-- HB 2019-11-16: Inserted trans_mass_calc, updated and cleaned code.
-- HB 2019-08-20: Changed types.
-- HB 2019-01-14: No output register.
-- HB 2018-11-26: First design.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.gtl_pkg.all;

entity transverse_mass is
    generic(
        N_OBJ_1 : positive;
        N_OBJ_2 : positive;
        OBJ : obj_type_array;
        BX : bx_array;
        PT1_WIDTH : positive;
        PT2_WIDTH : positive;
        COSH_COS_WIDTH : positive;
        COSH_COS_PREC : positive
    );
    port(
        pt1 : in conv_pt_vector_array;
        pt2 : in conv_pt_vector_array;
        cos_dphi : in corr_cuts_std_logic_array;
        trans_mass_o : out corr_cuts_std_logic_array := (others => (others => (others => '0')))
    );
end transverse_mass;

architecture rtl of transverse_mass is

    constant MASS_WIDTH : positive := PT1_WIDTH+PT2_WIDTH+COSH_COS_WIDTH;
    type mass_vector_i_array is array (0 to N_OBJ_1-1, 0 to N_OBJ_2-1) of std_logic_vector(MASS_WIDTH-1 downto 0);
    signal transverse_mass_sq_div2_temp, transverse_mass_sq_div2 : mass_vector_i_array := (others => (others => (others => '0')));
    signal cos_dphi_i : cosh_cos_vector_array;
    
begin

-- HB 2015-10-01: calculation of invariant mass with formular M**2/2=pt1*pt2*(cosh(eta1-eta2)-cos(phi1-phi2))
    l_1: for i in 0 to  N_OBJ_1-1 generate
        l_2: for j in 0 to N_OBJ_2-1 generate
            conv_i: for k in 0 to  COSH_COS_WIDTH-1 generate
                cos_dphi_i(i,j)(k) <= cos_dphi(i,j,k);
            end generate conv_i;
            same_obj_t: if (OBJ(1) = OBJ(2)) and (BX(1) = BX(2)) and j>i generate
-- less resources
                mass_calc_i : entity work.trans_mass_calc
                    generic map(PT1_WIDTH, PT2_WIDTH, COSH_COS_WIDTH, COSH_COS_PREC, MASS_WIDTH)  
                    port map(
                        pt1(i)(PT1_WIDTH-1 downto 0), pt2(j)(PT2_WIDTH-1 downto 0),
                        cos_dphi_i(i,j)(COSH_COS_WIDTH-1 downto 0),
                        transverse_mass_sq_div2_temp(i,j)
                    );
                    transverse_mass_sq_div2(i,j) <= transverse_mass_sq_div2_temp(i,j); 
                    transverse_mass_sq_div2(j,i) <= transverse_mass_sq_div2_temp(i,j); 
            end generate same_obj_t;    
            diff_obj_t: if (OBJ(1) /= OBJ(2)) or ((OBJ(1) = OBJ(2)) and (BX(1) /= BX(2))) generate
                mass_calc_i : entity work.trans_mass_calc
                    generic map(PT1_WIDTH, PT2_WIDTH, COSH_COS_WIDTH, COSH_COS_PREC, MASS_WIDTH)  
                    port map(
                        pt1(i)(PT1_WIDTH-1 downto 0), pt2(j)(PT2_WIDTH-1 downto 0),
                        cos_dphi_i(i,j)(COSH_COS_WIDTH-1 downto 0),
                        transverse_mass_sq_div2(i,j)
                    );
            end generate diff_obj_t;    
            l_3: for k in 0 to MASS_WIDTH-1 generate
                trans_mass_o(i,j,k) <= transverse_mass_sq_div2(i,j)(k);                 
            end generate l_3;
        end generate l_2;
    end generate l_1;
        
end architecture rtl;
