onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /comparators_mass_3_obj_tb/lhc_clk
add wave -noupdate /comparators_mass_3_obj_tb/data_temp
add wave -noupdate /comparators_mass_3_obj_tb/data
add wave -noupdate /comparators_mass_3_obj_tb/dut/data_vec
add wave -noupdate -expand /comparators_mass_3_obj_tb/dut/data_vec_i
add wave -noupdate -expand /comparators_mass_3_obj_tb/dut/comp
add wave -noupdate /comparators_mass_3_obj_tb/dut/comp_i
add wave -noupdate /comparators_mass_3_obj_tb/dut/comp_r
add wave -noupdate -expand -subitemconfig {/comparators_mass_3_obj_tb/dut/comp_o(0)(1) -expand} /comparators_mass_3_obj_tb/dut/comp_o
add wave -noupdate /comparators_mass_3_obj_tb/dut/l1comp(0)/l2comp(1)/l3comp(2)/sum_i/sum_mass_calc_i/in1
add wave -noupdate /comparators_mass_3_obj_tb/dut/l1comp(0)/l2comp(1)/l3comp(2)/sum_i/sum_mass_calc_i/in2
add wave -noupdate /comparators_mass_3_obj_tb/dut/l1comp(0)/l2comp(1)/l3comp(2)/sum_i/sum_mass_calc_i/in3
add wave -noupdate /comparators_mass_3_obj_tb/dut/l1comp(0)/l2comp(1)/l3comp(2)/sum_i/sum_mass_calc_i/sum_mass_1
add wave -noupdate /comparators_mass_3_obj_tb/dut/l1comp(0)/l2comp(1)/l3comp(2)/sum_i/sum_mass_calc_i/sum_mass
add wave -noupdate /comparators_mass_3_obj_tb/dut/l1comp(0)/l2comp(3)/l3comp(7)/sum_i/sum_mass_calc_i/in1
add wave -noupdate /comparators_mass_3_obj_tb/dut/l1comp(0)/l2comp(3)/l3comp(7)/sum_i/sum_mass_calc_i/in2
add wave -noupdate /comparators_mass_3_obj_tb/dut/l1comp(0)/l2comp(3)/l3comp(7)/sum_i/sum_mass_calc_i/in3
add wave -noupdate /comparators_mass_3_obj_tb/dut/l1comp(0)/l2comp(3)/l3comp(7)/sum_i/sum_mass_calc_i/sum_mass_1
add wave -noupdate /comparators_mass_3_obj_tb/dut/l1comp(0)/l2comp(3)/l3comp(7)/sum_i/sum_mass_calc_i/sum_mass
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {90746 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 501
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
WaveRestoreZoom {0 ps} {200522 ps}
