# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./adder_64.sv"
vlog "./addsub.sv"
vlog "./alu.sv"
vlog "./bit_and.sv"
vlog "./D_FF.sv"
vlog "./decoder.sv"
vlog "./decoder_1_2.sv"
vlog "./decoder_2_4.sv"
vlog "./decoder_4_16.sv"
vlog "./full_adder.sv"
vlog "./is_zero.sv"
vlog "./mux2_1.sv"
vlog "./mux4_1.sv"
vlog "./mux8_1.sv"
vlog "./mux16_1.sv"
vlog "./mux32_1.sv"
vlog "./mux64x2_1.sv"
vlog "./mux64x8_1.sv"
vlog "./mux64x32_1.sv"
vlog "./regfile.sv"
vlog "./registerx64.sv"
vlog "./ZeroExtend.sv"
vlog "./PC.sv"
vlog "./SignedExtend.sv"
vlog "./shift_2.sv"
vlog "./instructmem.sv"
vlog "./instr_fetch.sv"
vlog "./mux5x2_1.sv"
vlog "./datapath.sv"
vlog "./datamem.sv"
vlog "./mux64x4_1.sv"
vlog "./flag_reg.sv"
vlog "./control_unit.sv"
vlog "./CPU.sv"
vlog "./IF_RF_register.sv"
vlog "./RF.sv"
vlog "./RF_EX_register.sv"
vlog "./EX.sv"
vlog "./EX_MEM_register.sv"
vlog "./MEM.sv"
vlog "./MEM_WB_register.sv"
vlog "./mux64_4.sv"
vlog "./mux_4.sv"
vlog "./instr_path.sv"
vlog "./forwarding_unit.sv"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work CPU_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do bench_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
