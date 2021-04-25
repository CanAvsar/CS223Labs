module ALU(       
input logic [7:0] a, 
input logic [7:0] b,
input logic [2:0] aluControl,     
output logic [7:0] aluResult);
  
always_comb 
 begin   
      case(aluControl)  
      3'b000: aluResult = 0;
      3'b001: aluResult = 0;
      3'b010: aluResult = a + b; 
      3'b101: aluResult = ~(a ^ b); // xnor
      3'b111: aluResult = 0;
      default: aluResult = 0;
      endcase  
 end  
 endmodule  