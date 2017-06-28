`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:19:39 06/03/2017 
// Design Name: 
// Module Name:    i2cmaster03 
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
module i2cmaster03(
     input reset,clk_div,
    output reg sda, 
	 output sclk
    );
	 
reg [3:0] state;
reg busen;
reg [6:0]	addr; //first addr is the reg later turn to input
reg [8:0] data;
reg sclk_en;
integer i;
localparam idle  = 4'b0000;
localparam findslave = 4'h1;
localparam senddata = 4'h2;
localparam stop = 4'h3;

assign sclk = sclk_en? ~clk_div : 1'b1;

/*always@(negedge clk_div)
begin
if(reset == 1'b1)
	begin
	sclk_en <= 1'b0;
	//sclk <= 1'b1;
	end
else if (state == (findslave || senddata))
	 begin 
	 sclk_en <= 1'b1; 
	 end
else if (state == (idle || stop)) 
	begin 
	sclk_en <= 1'b0; 
	end

$display("i2c_scl = %h & clock = %h in main prog while sclk_en = %h and state = %h",sclk,clk_div, sclk_en,state);
end*/
 //sclk_en <= 1'b0; sclk <= 1'b1;
//else if (state == stop) sclk_en <=1'b0;//sclk <= 1'b1;

always@(posedge clk_div)
begin
$display("sda = %h, for clock - %h",sda,clk_div);
if(reset)
	begin
	sda <= 1'b1;
	busen <= 1'b1;
	//sclk <= 1'b1;
	state	<= idle;
	data <= 8'h59;
	addr <= 7'b0101011;
	end
else
	begin
	$display ("current state = %h",state);
	case(state)
	idle : 
		begin
		if(busen == 1'b1)//ie bus needs to be used
		begin 
		busen <= 0; //bus is busy
		sda <= 0; //sda goes low before clk
		state <= findslave;
		sclk_en <= 1'b0;
		i <= 6;
		 end
		else state <= idle;
		end
	findslave : // to send address
		begin
		sclk_en <= 1'b1;
		 sda <= addr[i]; //only sendign the address for now
		 if(i== 0) begin i <= 7; state <= senddata; end
		 else begin i <= i-1; state <= findslave; end
		 //end
		//else state <= findslave;
		end

	//ack: //sending the acknowledge bit
	//begin
	 // this is useful for when a slave has control over sda
	//end
	senddata : //sends data over sda for now
		begin
		//if(sclk == 0)
		//begin
		sclk_en <= 1'b1;
		sda <= data[i];
		if(i==0) state <= stop;
		else i <= i-1;
		end

	stop: // generates start sequence
		begin
		sda <= 0;
		sclk_en <= 1'b0;
		state <= idle;
		//busen <= 1'b1; bus available
		busen <= 1'b0; //so that the bus stops everything
		end
	endcase

	end
end

endmodule
