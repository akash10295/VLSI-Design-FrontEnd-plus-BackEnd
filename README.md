# VLSI Design Project (FrontEnd + BackEnd)

This was my first academic project in my graduate studies under course __EE6325: VLSI Design__. This was a complete long project consisting of complete VLSI design process from front end designing (RTL coding) to backend design (layout design). For the better flow, the project was divided into parts as follows:
1. RTL Coding (Frontend part)
2. Synthesis
3. Layout designing (Backend part) (With a sub-part where aim was to minimize the Energy-Delay Product while minimizing the cell area)
4. Library creation and synthesis using it
5. Routing and floorplanning.

## 1. RTL Coding (Frontend part)
Our first job was to select an arbitary digital circuit to deisgn in HDL form. For this project I proceeded by selecting The Arithmetic and Logic Unit (ALU) of two 24 bit inputs and one 25 bit output. It was capable of performing 8 operations
> Adition, Subtraction, Division, Remainder, OR, AND, NOR & XOR.


RTL design abstraction is used in Hardware Descriptive Languages like Verilog or VHDL. For this project I decided to use Verilog-HDL to design the ALU. Verilog uses a C like structure which consist of modules. Following simple addition verilog module will give a better idea of the language.

```verilog
module addition (in1, in2, out);
input in1, in2;
output out;

assign out = in1 + in2;

endmodule
```
For more learning about Verilog with examples you can visit [ASIC-World](http://www.asic-world.com/).

My behavioral code for this project is [alu.v](https://github.com/akash10295/Complete-VLSI-Project-Front-end-Back-end-/blob/master/alu.v)
In HDL, testbench is needed to test the correct response of the code without needing of actual hardware. Test benches are of same file format as that of HDL code, i.e. they are verilog files. The testbench for my verilog is [alu_tb.v](https://github.com/akash10295/Complete-VLSI-Project-Front-end-Back-end-/blob/master/alu_tb.v).
There are many simulators available to run the verilog code. The one which I use is Xilinx ISE.
[Here](https://github.com/akash10295/Complete-VLSI-Project-Front-end-Back-end-/blob/master/Screenshots/alu%20outputs.jpg) is the screenshot of the output waveforms after simulating the above code on testbench.
