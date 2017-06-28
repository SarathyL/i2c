`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:22:55 06/03/2017 
// Design Name: 
// Module Name:    i2c_clkdiv 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module i2c_clkdiv(
    input reset,clk,
    output reg clkout
    );
reg [9:0] count;
//intial count <= 10'b1111111111;
always@(posedge clk or posedge reset)
begin
if (reset == 1'b1)
begin
count <= 10'd0;
clkout <= 1'b1;
//$display("divided clock = %h with reset",clkout);
end
else begin
if (count == 10'd500)
	begin 
	clkout <= ~clkout; 
	count <= 10'd0;
	$display("divided clock = %h in clk div",clkout);
	 end
else count <= count + 1'b1;

end
end

endmodule
