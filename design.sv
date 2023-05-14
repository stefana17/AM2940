// Code your design here
`include"register.sv"
`include"mux1_2.sv"
`include"counter.sv"
`include"control_register.sv"
`include"mux1_3.sv"
`include"done_gen.sv"
`include"instruction_decoder.sv"

module AM2940(clk, I, datain, dataout, addrout, done, aci, aco, wci, wco);
  input clk, aci, wci;
  input [2:0] I;
  input [7:0] datain;
  output [7:0] addrout;
  output [7:0] dataout;
  output wco, aco, done;
    
    //Semnale de comanda + variabile de transfer intre module(fire)
  wire plar,plwr,sela,selw,plcr,plac,ena,inca,deca,resw,plwc,enw,incw,decw,oedata;
  wire [1:0] seld; 
  wire [7:0] arout, wrout, addrmuxout, wordmuxout, acout, wcout;
  wire [2:0] crout;
    
  assign addrout = acout;
    
    //Registre
    //Registru adrese
  register address_register_inst(.clk(clk), .pl(plar), .din(datain), .dataout(arout));
    //Registru cuvinte
  register word_count_register_inst(.clk(clk), .pl(plwr), .din(datain), .dataout(wrout));
      
    //Multiplexor doua intrari - o iesire
    //Multiplexor adrese
  mux1_2 address_mux_inst(.di0(datain), .di1(arout), .dataout(addrmuxout), .sel(sela));
    //Multiplexor cuvinte
  mux1_2 word_count_mux_inst(.di0(datain), .di1(wrout), .dataout(wordmuxout), .sel(selw));
      
    //Numaratoare
    //Numarator adrese
    counter address_counter_inst(.clk(clk), .pl(plac), .reset(1'b0), .enc(ena), .inc(inca), .dec(deca), .cin(aci), .di(addrmuxout), .co(aco), .dataout(acout));
    //Numarator cuvinte
    counter word_count_counter_inst(.clk(clk), .pl(plac), .reset(resw), .enc(enw), .inc(incw), .dec(decw), .cin(wci), .di(wordmuxout), .co(wco), .dataout(wcout));
    
    //Registru Control
  control_register control_register_inst(.clk(clk), .plcr(plcr), .din(datain[2:0]), .dataout(crout));
      
    //Registru transfer de date complet
      done_gen done_gen_inst(.doac(acout), .dowc(wcout), .dowr(wrout), .cinw(wci), .mode(crout[1:0]), .done(done));
    
    //Multiplexor 3 intrari - o iesire
    //Multiplexor date
  mux1_3 datamux_inst(.clk(clk), .di0(acout), .di1(wcout), .di2(crout), .dataout(dataout), .seld(seld));
      
    //Decodor instructiuni
      instruction_decoder instruction_decoder_inst(.I(I), .CR(crout), .plar(plar), .plwr(plwr), .sela(sela), .selw(selw), .plcr(plcr), .plac(plac), .ena(ena), .inca(inca), .deca(deca), .resw(resw), .plwc(plwc), .enw(enw), .incw(incw), .decw(decw), .oedata(oedata));
      
endmodule
    
        
        
    