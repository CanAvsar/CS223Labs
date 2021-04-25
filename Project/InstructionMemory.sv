module InstructionMemory(
input logic [4:0] readAddress, 
output logic [15:0] readData, readData2);

logic [15:0] rom[31:0];  

always_comb  
      begin
        rom[0] = 16'b001_0_0000_00000000;
        rom[1] = 16'b001_0_0000_00010001;
        rom[2] = 16'b001_1_0010_00000000;  
        rom[3] = 16'b001_1_0011_00000000;
        rom[4] = 16'b001_1_0100_00000001;
        rom[5] = 16'b101_0_1001_00100001;
        rom[6] = 16'b010_0_0011_00110000;
        rom[7] = 16'b010_0_0010_00100100;
        rom[8] = 16'b101_0_0101_0000_0000;
        rom[9] = 16'b000_0_0000_0011_0011;
        
        rom[10] = 16'b000_0_xxxx_0010_0010;
        rom[11] = 16'b000_0_xxxx_0011_0011;
        rom[12] = 16'b010_x_0101_0000_0001;
        rom[13] = 16'b010_x_0110_0001_0010;
        rom[14] = 16'b010_x_0111_0010_0011;
        rom[15] = 16'b010_x_1000_0011_0100;
        rom[16] = 16'b010_x_1000_0000_0001;
        rom[17] = 16'b010_x_1001_0010_0011;
        rom[18] = 16'b010_x_1010_0100_0101;
        rom[19] = 16'b010_x_1011_0110_0111;
        rom[20] = 16'b010_x_1100_1000_1001;
        rom[21] = 16'b010_x_1101_1010_1011;
        rom[22] = 16'b101_xxxxxxxxxxxxx;
        rom[23] = 16'b101_xxxxxxxxxxxxx;
        rom[24] = 16'b101_xxxxxxxxxxxxx; 
        rom[25] = 16'b101_xxxxxxxxxxxxx;
        rom[26] = 16'b101_00110_1000_1101;
        rom[27] = 16'b101_00010_1001_1011;
        rom[28] = 16'b011_xxxxxxxxxxxxx;
        rom[29] = 16'b100_xxxxxxxxxxxxx;
        rom[30] = 16'b101_xxxxxxxxxxxxx;
        rom[31] = 16'b111_xxxxxxxxxxxxx;
    end 

    assign readData = rom[readAddress];
    assign readData2 = rom[readAddress+1];
endmodule