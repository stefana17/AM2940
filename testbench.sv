// Code your testbench here
// or browse Examples
module tb_AM2940;
  reg clkt, acit, wcit;
  reg [2:0] It;
  reg [7:0] dataint;
  wire [7:0] dataoutt;
  wire [7:0] addroutt;
  wire acot,wcot,donet;
  AM2940 DUT(.clk(clkt), .I(It), .datain(dataint), .dataout(dataoutt), .addrout(addroutt), .done(donet), .aci(acit), .aco(acot), .wci(wcit), .wco(wcot));
  
  initial
    begin
      #0 clkt = 1'b0;
      forever #5 clkt = ~clkt;
    end

  initial
    begin
      #0 dataint=8'b1010_0011;
      //Instructiunea 0 : Write Control Register
      #5 dataint = 8'b110; It =3'b0;  acit = 1'b0; wcit = 1'b0;
      //Instructiunea 1 : Read Control Register
      #10 It = 3'b001;
      //Instructiunea 6 : Load Word Count
      #10 It = 3'b110; dataint = 8'haa;
      
      
      //Instructiunea 5 : Load Address
      #10 It = 3'b101;
      //Instructiunea 3 : Read Address Counter
      #10 It = 3'b011;
      //Instructiunea 0 : Write Control Register
      #10 It =3'b0; dataint = 8'b0;
      //Instructiunea 7 : Enable Counters
      #10 It = 3'b111;
      //Instructiunea 4 : Reinitialize Counters
      #10 It = 3'b100;
      //Instructiunea 3 : Read Address Counter
      #10 It = 3'b011;
      
      //Instructiunea 6 : Load Word Count
      #10 It = 3'b110;
      //Instructiunea 0 : Write Control Register
      #10 It =3'b0; dataint = 8'b1;
      //Instructiunea 6 : Load Word Count
      #10 It = 3'b110; dataint = 8'hbb;
      //Instructiunea 0 : Write Control Register
      #10 It =3'b0; dataint = 8'b1;
      //Instructiunea 4 : Reinitialize Counters
      #10 It = 3'b100;
      //Instructiunea 0 : Write Control Register
      #10 It =3'b0; dataint = 8'b0;
      //Instructiunea 4 : Reinitialize Counters
      #10 It = 3'b100;
      //Instructiunea 0 : Write Control Register
      #10 It =3'b0;

      
 /*   //Instructiunea 0 : Write Control Register
      #0 It =3'b0; dit = 8'b0; acit = 1'b0; wcit = 1'b0;
      //Instructiunea 1 : Read Control Register
      #10 It = 3'b001;
      //Instructiunea 5 : Load Address
      #10 It = 3'b101; dit = 8'b00001100;
      //Instructiunea 6 : Load Word Count
      #10 It = 3'b110; dit = 8'b00001000;
      //Instructiunea 2 : Read Word Counter
      #10 It = 3'b010;
      //Instructiunea 3 : Read Address Counter
      #10 It = 3'b011;
      //Instructiunea 7 : Enable Counters
      #10 It = 3'b111;
      
      //Instructiunea 0 : Write Control Register
      #40 It =3'b0; dit = 8'b00000111;
      //Instructiunea 4 : Reinitialize Counters
      #10 It = 3'b100;
      //Instructiunea 7 : Enable Counters
      #10 It = 3'b111;
      
      //Instructiunea 0 : Write Control Register
      #40 It =3'b0; dit = 8'b00000011;
      //Instructiunea 6 : Load Word Count
      #10 It = 3'b110; dit = 8'b00000011;
      //Instructiunea 5 : Load Address
      #10 It = 3'b101; dit = 8'hfe;
      //Instructiunea 7 : Enable Counters
      #10 It = 3'b111;
      
      //Instructiunea 6 : Load Word Count
      #10 It = 3'b110; dit = 8'hf0;
      //Instructiunea 0 : Write Control Register
      #40 It =3'b0; dit = 8'b0;
    */  
    end
  
    
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0, DUT);
    end
  
  initial
    #500 $finish;
  
endmodule