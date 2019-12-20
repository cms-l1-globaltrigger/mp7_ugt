
##***************************** Beginning of Script ***************************
        
## If MTI_LIBS is defined, map unisim and simprim directories using MTI_LIBS
## This mode of mapping the unisims libraries is provided for backward 
## compatibility with previous wizard releases. If you don't set MTI_LIBS
## the unisim libraries will be loaded from the paths set up by compxlib in
## your modelsim.ini file

#set XILINX   $env(XILINX)
if [info exists env(MTI_LIBS)] {    
    set MTI_LIBS $env(MTI_LIBS)
    vlib UNISIM
    vlib SECUREIP
    vmap UNISIM $MTI_LIBS/unisim
    vmap SECUREIP $MTI_LIBS/secureip
  
}

## set your src files directory for your design
set HDL_DIR /home/bergauer/github/cms-l1-globaltrigger/mp7_ugt/firmware/hdl
set TB_DIR /home/bergauer/github/cms-l1-globaltrigger/mp7_ugt/firmware/sim/testbench

## Create and map work directory
vlib work
vmap work work

#Top Entity the design
vcom -93 -work work $HDL_DIR/data/gtl/bx_pipe_test_pkg.vhd
vcom -93 -work work $HDL_DIR/data/gtl/bx_pipe_test.vhd

#Testbench
vcom -93 -work work $TB_DIR/bx_pipe_test_tb.vhd

#Load Design
vsim -t 1ps work.bx_pipe_test_tb 

##Load signals in wave window
view wave
do $TB_DIR/../scripts/bx_pipe_test_wave.do

##Run simulation
run 200 ns

# eof



