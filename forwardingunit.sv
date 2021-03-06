module forwardingunit
#(
	BUS_DATA_WIDTH = 64
)
(
	input [4:0] inRegisterRs,  
	input [4:0] inRegisterRt,
	input [4:0] inDestRegisterEx,
	input [4:0] inDestRegisterMem,
	input inRegWriteEx, 
	input inRegWriteMem,	
	
	output [1:0] outForwardA, 	
	output [1:0] outForwardB
);

`include "Sysbus.defs"

always_comb begin
	$display("Inside forwarding unit\n");
	if(inRegWriteEx && (inDestRegisterEx != 0) && (inDestRegisterEx == inRegisterRs)) begin
		outForwardA = 2'b10;
	end else if(inRegWriteMem && (inDestRegisterMem != 0) && (inDestRegisterEx != inRegisterRs) && (inDestRegisterMem == inRegisterRs)) begin
		outForwardA = 2'b01;
	end else begin	
		outForwardA = 2'b00;
	end
end

always_comb begin
	if(inRegWriteEx && (inDestRegisterEx != 0) && (inDestRegisterEx == inRegisterRt)) begin
		outForwardB = 2'b10;
	end else if(inRegWriteMem && (inDestRegisterMem != 0) && (inDestRegisterEx != inRegisterRt) && (inDestRegisterMem == inRegisterRt)) begin
		outForwardB = 2'b01;
	end else begin
		outForwardB = 2'b00;
	end
end

endmodule


