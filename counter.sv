module counter(clk,pl,reset,enc,inc,dec,cin,di,co,dataout);
  input clk,pl,enc,inc,dec,cin,reset;
  input [7:0] di;
  output co;
  output reg [7:0] dataout;
    
    always @(posedge clk)
     begin
      if(reset)
        dataout <= 8'b0;
  	  else
       if(pl)
        dataout <= di;
          else
            if(enc)
              if(inc && ~cin)
                begin
                  dataout <= dataout + 1;
                end
  				else
                  if(dec && ~cin)
                    begin
                      dataout <= dataout - 1;
                    end
  end
  
  assign co = (~((dataout===8'hff) && inc && enc)) && (~((dataout===8'h00) && dec && enc)) || cin;
                
endmodule
