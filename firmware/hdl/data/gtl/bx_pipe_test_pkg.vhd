library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

package bx_pipe_test_pkg is

    constant BX_PIPELINE_STAGES : positive := 5;

    type data_array is array (0 to BX_PIPELINE_STAGES-1) of std_logic_vector(7 downto 0);       
    
    function bx(i : integer) return natural;

end package;

package body bx_pipe_test_pkg is

-- Function to convert bx values from utm (e.g.: +2 to -2) to array index of bx data (e.g.: 0 to 4)
    function bx(i : integer) return natural is
        variable conv_val : integer := 0;
        variable bx_conv : natural := 0;
    begin
        conv_val := (BX_PIPELINE_STAGES/2)-(i*2);
        bx_conv := i+conv_val;        
        return bx_conv;
    end function;

end package body bx_pipe_test_pkg;
