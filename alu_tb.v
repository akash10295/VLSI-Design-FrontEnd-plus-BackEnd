`timescale 1ns / 1ps


module balu_24_tb;

	// Inputs
	reg [23:0] input1;
	reg [23:0] input2;
	reg [2:0] select;
	reg clock;
	reg reset;

	// Outputs
	wire [24:0] out;
	wire [24:0] mux;

	// Instantiate the Unit Under Test (UUT)
	balu_24 uut (
		.in1(in1), 
		.in2(in2), 
		.select(select), 
		.clock(clock), 
		.reset(reset), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
	input1 = 24'b111101010011010110000110;
	input2 = 24'b111101010011010110000001;
	reset = 0;
	clock = 1;
	select = 3'b000; //addition
	#125
	select = 3'b001; //subtraction
	#125
	select = 3'b010; //division
	#125
	select = 3'b011; //remainder
	#125
	select = 3'b100; //bitwise AND
	#125
	select = 3'b101; //bitwise OR
	#125
	select = 3'b110; //bitwise ExOR
	#125
	select = 3'b111; //bitwise ExNOR
	end
//clock
	always begin
	#5 clock=~clock; //invert after every 5ns
	end
      
endmodule