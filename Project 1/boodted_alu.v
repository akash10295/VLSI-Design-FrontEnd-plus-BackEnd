module boosted_alu(input1,input2,select,clock,reset,out,mux,adn,sub,div,remainder,andd,orr,exxor,exxnor);
	input [15:0]input1,input2;	//Two input numbers
	input clock,reset;			//clock and reset for flipflop circuit
	input [2:0]select;			//select input to determine one of the eight operations
	output [16:0]out,mux,adn,sub;
		/*  out is a final output
			mux is an main output available at the output of multiplexer connected tot the input of flipflop
			adn is the addition output with carryout as MSB
			sub is the subtraction output with borrow as MSB */
	output [15:0]div,remainder,andd,orr,exxor,exxnor;
		/*	div is division of input numbers
			remainder is remainder after division of input numbers*/
	
	
	reg [15:0]a1,a2,a3,a4,a5,a6,a7,a0,b1,b2,b3,b4,b5,b6,b7,b0;
		/*a0 through a7 is input1 at the output of demux1
		  b0 through b7 is input2 at the output of demux2*/
	reg [16:0]out,mux;
	reg [15:0]div,remainder,andd,orr,exxor,exxnor;
	reg [16:0]adn,sub;
	
	//1:8 demux1 code for input1
	always@(*)
		begin
		case (select)
			3'b000 : a0<=input1;
			3'b001 : a1<=input1;
			3'b010 : a2<=input1;
			3'b011 : a3<=input1;
			3'b100 : a4<=input1;
			3'b101 : a5<=input1;
			3'b110 : a6<=input1;
			3'b111 : a7<=input1;
			default $display("select input is wrong");
			endcase
		end
		
	//1:8 demux2 code for input2
	always@(*)
		begin
		case (select)
			3'b000 : b0<=input2;
			3'b001 : b1<=input2;
			3'b010 : b2<=input2;
			3'b011 : b3<=input2;
			3'b100 : b4<=input2;
			3'b101 : b5<=input2;
			3'b110 : b6<=input2;
			3'b111 : b7<=input2;
			default $display("select input is wrong");
			endcase
		end
		
	//code for ALU
	always@(*)
		//Arithmatic and Logical operations
		begin
		
		//ARITHMATIC		
		adn=a0+b0;				//addtion module
		sub=a1-b1;				//subtraction module
		div=a2/b2;				//input1 is divided by input2
		remainder=a3%b3;		//remainder after input1 is divided by input2
		
		//LOGICAL
		andd=a4&b4;				//input1 AND input2
		orr=a5|b5;				//input1 OR input2
		exxor=a6^b6;			//input1 XOR input2
		exxnor=a7^~b7;			//input1 XNOR input2
		end

		//8:1 mux code for forwarding the output of selected operation
		always@(*)
		begin
		case (select)
			3'b000 : mux<=adn;
			3'b001 : mux<=sub;
			3'b010 : mux<=sl;
			3'b011 : mux<=sr;
			3'b100 : mux<=andd;
			3'b101 : mux<=orr;
			3'b110 : mux<=exxor;
			3'b111 : mux<=exxnor;
			default $display("select input is wrong");
			endcase
		end
		
		//Flip-flop code mudule
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
