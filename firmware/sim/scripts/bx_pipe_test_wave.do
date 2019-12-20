onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /bx_pipe_test_tb/dut/clk
add wave -noupdate -radix hexadecimal -radixshowbase 0 /bx_pipe_test_tb/dut/data_in
add wave -noupdate /bx_pipe_test_tb/dut/data_int
add wave -noupdate -divider new
add wave -noupdate -radix hexadecimal -childformat {{/bx_pipe_test_tb/dut/data_tmp(0) -radix hexadecimal} {/bx_pipe_test_tb/dut/data_tmp(1) -radix hexadecimal} {/bx_pipe_test_tb/dut/data_tmp(2) -radix hexadecimal} {/bx_pipe_test_tb/dut/data_tmp(3) -radix hexadecimal} {/bx_pipe_test_tb/dut/data_tmp(4) -radix hexadecimal}} -radixshowbase 0 -expand -subitemconfig {/bx_pipe_test_tb/dut/data_tmp(0) {-height 17 -radix hexadecimal -radixshowbase 0} /bx_pipe_test_tb/dut/data_tmp(1) {-height 17 -radix hexadecimal -radixshowbase 0} /bx_pipe_test_tb/dut/data_tmp(2) {-height 17 -radix hexadecimal -radixshowbase 0} /bx_pipe_test_tb/dut/data_tmp(3) {-height 17 -radix hexadecimal -radixshowbase 0} /bx_pipe_test_tb/dut/data_tmp(4) {-height 17 -radix hexadecimal -radixshowbase 0}} /bx_pipe_test_tb/dut/data_tmp
add wave -noupdate -divider legacy
add wave -noupdate /bx_pipe_test_tb/dut/data_o_new
add wave -noupdate /bx_pipe_test_tb/dut/data_o_new_bx_p2
add wave -noupdate /bx_pipe_test_tb/dut/data_o_new_bx_p1
add wave -noupdate /bx_pipe_test_tb/dut/data_o_new_bx_0
add wave -noupdate /bx_pipe_test_tb/dut/data_o_new_bx_m1
add wave -noupdate /bx_pipe_test_tb/dut/data_o_new_bx_m2
add wave -noupdate /bx_pipe_test_tb/dut/data_o_new
add wave -noupdate /bx_pipe_test_tb/dut/data_bx_p2
add wave -noupdate /bx_pipe_test_tb/dut/data_bx_p1
add wave -noupdate /bx_pipe_test_tb/dut/data_bx_0
add wave -noupdate /bx_pipe_test_tb/dut/data_bx_m1
add wave -noupdate /bx_pipe_test_tb/dut/data_bx_m2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {200000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 298
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {232448 ps}
