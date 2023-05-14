module register(clk,pl,din,dataout);
  input clk,pl;
  input [7:0] din;
  output reg [7:0] dataout;
    
    always @(posedge clk)
      if(pl)
        dataout <= din;
          
endmodule