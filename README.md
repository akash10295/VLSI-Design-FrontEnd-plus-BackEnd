# VLSI Design Project (FrontEnd + BackEnd)

This was my first academic project in my graduate studies under course __EE6325: VLSI Design__. This was a complete long project consisting of complete VLSI design process from front end designing (RTL coding/verification) to backend design (layout design). For the better flow, the project was divided into parts as follows:
1. RTL Coding (Frontend part)
2. Synthesis
3. Layout designing (Backend part) (With a sub-part where aim was to minimize the Energy-Delay Product while minimizing the cell area)
4. Library creation and synthesis using it
5. Routing, floorplanning and Static Time Analysis (STA).

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
There are many simulators available to run the verilog code. The one which I used is Xilinx ISE.
[Here](https://github.com/akash10295/Complete-VLSI-Project-Front-end-Back-end-/blob/master/Screenshots/alu%20outputs.jpg) is the screenshot of the output waveforms after simulating the above code on testbench.



## 2. Synthesis
The code which I wrote was a behvioral code and it needs to be converted to structural code. In simpler words, structural code describes the actual physical structure of the system whereas the behavioral code describes the behavior of the system for different conditions.
This process is also known as 'Synthesis'.
Using Synopsys's Design Vision I imported the library file provided by the college. Using this same library I synthesized my code. Once done, the [structural code](https://github.com/akash10295/Complete-VLSI-Project-Front-end-Back-end-/blob/master/alu_syn.v) was generated. This is also called mapped netlist.
In the same step I also pulled out the cell report. Below is the _part_ of that cell report.
```
Information: Updating graph... (UID-83)
 
****************************************
Report : cell
Design : b_alu_24_nr
Version: L-2016.03-SP3
Date   : Tue Sep 19 12:25:43 2017
****************************************

Attributes:
    b - black box (unknown)
    h - hierarchical
    n - noncombinational
    r - removable
    u - contains unmapped logic

Cell                      Reference       Library             Area  Attributes
--------------------------------------------------------------------------------
U358                      nor2            library         1.000000  
U359                      inv             library         1.000000  
U360                      oai22           library         2.000000  
U361                      oai22           library         2.000000  
U362                      nor2            library         1.000000  
U363                      inv             library         1.000000  
U364                      aoi22           library         2.000000  
U365                      inv             library         1.000000  
U366                      nand2           library         1.000000  
U367                      nor2            library         1.000000  
U368                      inv             library         1.000000  
U369                      nand3           library         1.000000  
U370                      aoi22           library         2.000000  
U371                      xor2            library         3.000000  
U372                      nor2            library         1.000000  
U373                      xor2            library         3.000000  
U374                      nand2           library         1.000000  
U375                      inv             library         1.000000  
U376                      aoi22           library         2.000000  
U377                      oai22           library         2.000000  
U378                      inv             library         1.000000  
U379                      nor2            library         1.000000  
U380                      nand3           library         1.000000  
U381                      nand2           library         1.000000  
U382                      nand3           library         1.000000  
U383                      nand2           library         1.000000  
U384                      nand2           library         1.000000  
U385                      oai12           library         2.000000  
U386                      oai22           library         2.000000  
U387                      oai22           library         2.000000  
U388                      nor2            library         1.000000  
U389                      inv             library         1.000000  
U390                      oai22           library         2.000000  
U391                      nor2            library         1.000000  
U392                      inv             library         1.000000  
U393                      nor2            library         1.000000  
U394                      inv             library         1.000000  
.
.
.
.
.
(Skipping 1030 lines)
.
.
.
.
out_reg[12]               dff             library         7.000000  n
out_reg[13]               dff             library         7.000000  n
out_reg[14]               dff             library         7.000000  n
out_reg[15]               dff             library         7.000000  n
out_reg[16]               dff             library         7.000000  n
out_reg[17]               dff             library         7.000000  n
out_reg[18]               dff             library         7.000000  n
out_reg[19]               dff             library         7.000000  n
out_reg[20]               dff             library         7.000000  n
out_reg[21]               dff             library         7.000000  n
out_reg[22]               dff             library         7.000000  n
out_reg[23]               dff             library         7.000000  n
out_reg[24]               dff             library         7.000000  n
--------------------------------------------------------------------------------
Total 4039 cells                                          6960.000000

```
This shows that there were 4039 cells in the final design.

## 3.Layout designing (Backend part).
As I mentioned in part 2 that the library which I used to synthesize the code was provided by the college. Now My job was to create my own cell library just like that. The very first step to create my own library was to start designing the layouts of the gates/cells. The most popular tool for layout designing (a.k.a. Physical designing/BackEnd Designing) is Cadence Virtuso and schematic.

Before I start the layout designing of the all cells in the library there was a sub part in this step which aimed to design a layout of an inverter and size it in such a way that it will provide minimum Energy-Delay Product (EDP) while minimizing the total cell area. Now it is normal for a rookie/non-technical person to think that this may need a hit-n-try method to get the optimum cell size along with optimum EDP. But that is not the case. For this, I designed a simple inverter layout and generated its spice netlist (.sp file) after performing DRC/LVS/QRC. Then with the help of [HSPICE](https://github.com/akash10295/Complete-VLSI-Project-Front-end-Back-end-/blob/master/inv_SPICE.sp) and the spice netlist I swept the value of Wp (Width of the p-mos) while keeping the Wn (Width of the n-mos) constant.

Once done with the sub part, I designed layout of all the required cells. The screenshot of layout of D Flipflop is shown below. Rest of the screenshots you can find [here](https://github.com/akash10295/Complete-VLSI-Project-Front-end-Back-end-/tree/master/Screenshots/Layouts).

![alt text](https://github.com/akash10295/Complete-VLSI-Project-Front-end-Back-end-/blob/master/Screenshots/Layouts/dff.JPG "D flip flop layout")

## 4.Library creation and synthesis using it.
Once all the layouts were done, next step was to create the library file using it. This included several steps as follows:
1. Using SiliconSmart ACE craeting a .lib file from the Cadence library which consist of all the required layouts.
2. From the .lib file, creating the .db file using Library Compiler (LC shell).
3. Using this library, now synthesize the original verilog code to generate a new mapped netlist based on newly created library.
4. Creating a Library Exchange File (LEF) from the Cadence library and also its ASCII file.
5. Another LEF file was created usign previously created LEF and ASCII file which will support Cadence Encounter.


## 5.Routing, floorplanning and Static Time Analysis (STA).
For routing and floorplanning the tool I used was Cadence Encounter. This tool uses the mapped netlist and LEF file which I created in the steps 3 and 5 in part 4 above. Once these files are imported in the tool and required settings are set floorplanning and routing is done as per need. The snippit below shows the screenshot of the user interface of Encounter.

![alt text](http://www.utdallas.edu/~xxx110230/images/encounter19.jpg "Encounter UI")


I also did the Static Time Analysis (STA) using PrimeTime to get the slack of the system.


## 6.Final Layout and schematic imprt and matching of them.
After done with the routing and floorplanning in Encounter I got the final layout of the system but this layout needs to be exported to Cadence Virtuso. To do so a Data Extraction File (DEF) is created/exported from Encounter. This DEF file is imported to cadence Virtuso which generated the final layout of an ALU in Cadence Virtuso. Below is the complete and zoomed in screenshot of the same.
![alt text](https://github.com/akash10295/Complete-VLSI-Project-Front-end-Back-end-/blob/master/Screenshots/Layouts/final.JPG "Final layout")
![alt text](https://github.com/akash10295/Complete-VLSI-Project-Front-end-Back-end-/blob/master/Screenshots/Layouts/alu%20zoomed.JPG "Zoomed final layout")
