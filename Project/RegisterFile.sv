module RegisterFile(
input logic clk, 
input logic reset, 
input logic regWriteEnable,  
input logic [3:0] regWriteAddress,  
input logic [7:0] regWriteData,  
input logic [3:0] regReadAddress1,  
input logic [3:0] regReadAddress2,
output logic [7:0] regReadData1,  
output logic [7:0] regReadData2);  
      logic [7:0] regMem[15:0];  
      
      always_ff@ (posedge clk, posedge reset) begin  
        if(reset) 
            begin  
                regMem[0] <= 8'b0;
                regMem[1] <= 8'b0;
                regMem[2] <= 8'b0;
                regMem[3] <= 8'b0;
                regMem[4] <= 8'b0;
                regMem[5] <= 8'b0;
                regMem[6] <= 8'b0;
                regMem[7] <= 8'b0;
                regMem[8] <= 8'b0;
                regMem[9] <= 8'b0;
                regMem[10] <= 8'b0;
                regMem[11] <= 8'b0;
                regMem[12] <= 8'b0;
                regMem[13] <= 8'b0;
                regMem[14] <= 8'b0;
                regMem[15] <= 8'b0;          
           end  
           else 
            begin  
                if(regWriteEnable == 1) 
                    begin  
                     regMem[regWriteAddress] <= regWriteData;  
                end  
           end 
           end

      assign regReadData1 = regMem[regReadAddress1];  
      assign regReadData2 = regMem[regReadAddress2];  
 endmodule 