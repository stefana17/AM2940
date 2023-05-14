module control_register(clk,plcr,din,dataout);
  input clk,plcr;
  input [2:0] din;
  output reg [2:0] dataout;
    
    always @(posedge clk)
      if(plcr)
        dataout <= din;
          
endmodule