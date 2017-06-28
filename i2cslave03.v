`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:21:50 06/03/2017
// Design Name:   i2cmaster03
// Module Name:   E:/sem2/xilinxvcode/i2c01/i2cslave03.v
// Project Name:  i2c01
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: i2cmaster03
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module i2cslave03;

	// Inputs
	reg reset;
	reg clk;

	// Outputs
	wire sda;
	wire sclk;
	wire clk_div;
	wire clkout;
	//wire sclk_div;

	// Instantiate the Unit Under Test (UUT)
	i2cmaster03 uut (
		.reset(reset), 
		.clk_div(clkout), 
		.sda(sda), 
		.sclk(sclk)
	);
	i2c_clkdiv divi (
    .reset(reset), 
    .clk(clk), 
    .clkout(clkout)
    );


initial begin
		// Initialize Inputs
		reset = 0;
		clk = 0;
	#10;
	reset = 1'b1;
	#3000 reset = 0;
		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here

	end
always #5 clk <= ~clk;   
      
endmodule

