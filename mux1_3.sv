module mux1_3(clk,di0,di1,di2,dataout,seld);
  input clk;
  input [7:0] di0, di1;
  input [2:0] di2;
  output reg [7:0] dataout;
  input [1:0] seld;
    
  always @(di0 or di1 or di2 or seld)
      casex(seld)
        2'b00: dataout = di0;
        2'b01: dataout = di1;
        2'b1x: dataout = {5'b11111,di2};
      endcase
endmodule