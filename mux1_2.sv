module mux1_2(di0,di1,dataout,sel);
  input [7:0] di0,di1;
  input sel;
  output [7:0] dataout;
    
    assign dataout = sel ? di1 : di0;
      
endmodule