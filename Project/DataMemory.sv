module DataMemory( 
input logic clk,
input logic reset,
input logic writeEnable,
input logic [3:0] writeAddress,
input logic [7:0] writeData,
input logic [3:0] readAddress1,
input logic [3:0] readAddress2,
output logic [7:0] readData1,
output logic [7:0] readData2);
logic [7:0] mem [15:0];
always_ff @(posedge clk)
    begin
    if(reset) begin  
                mem[0] <= 8'b0;
                mem[1] <= 8'b0;
                mem[2] <= 8'b0;
                mem[3] <= 8'b0;
                mem[4] <= 8'b0;
                mem[5] <= 8'b0;
                mem[6] <= 8'b0;
                mem[7] <= 8'b0;
                mem[8] <= 8'b0;
                mem[9] <= 8'b0;
                mem[10] <= 8'b0;
                mem[11] <= 8'b0;
                mem[12] <= 8'b0;
                mem[13] <= 8'b0;
                mem[14] <= 8'b0;
                mem[15] <= 8'b0;          
           end  
    else
        if (writeEnable == 1)
        mem[writeAddress] <= writeData;         
    end
    
    assign readData1 = mem[readAddress1];
    assign readData2 = mem[readAddress2]; 
    
 
endmodule