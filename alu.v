module boosted_alu(in1,in2,select,clock,reset,out);
	input [15:0]input1,input2;	//Two input numbers
	input clock,reset;			//clock and reset for flipflop circuit
	input [2:0]select;			//select input to determine one of the eight operations
	output [16:0]out;
	
	reg [16:0]mux;
	
	
	//code for ALU
		always@(*)
		begin
		case (select)
			3'b000 : mux<=in1+in2;
			3'b001 : mux<=in1-in2;
			3'b010 : mux<=in1/in2;
			3'b011 : mux<=in1%in2;
			3'b100 : mux<=in1&in2;
			3'b101 : mux<=in1|in2;
			3'b110 : mux<=in1^in2;
			3'b111 : mux<=in1^~in2;
			default $display("select input is wrong");
			endcase
		end
		
		//Flip-flop code module
		always@(posedge clock)
			begin
			if (reset) begin
				out<=0;
				end
			else begin
				out<=mux;
				end
			end
endmodule
