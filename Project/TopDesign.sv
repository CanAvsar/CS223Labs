module TopDesign
    (
    input logic clk,
    input logic [15:0] swIns,
    input logic [4:0] debouncer,
    output logic [15:0] insLed, 
    output logic [6:0]seg, 
    output logic dp,
    output logic[3:0] an
    );

    logic previous, next, getFromSwitches, getFromMemory, reset; 
    logic branch, stop, add;
    logic [7:0] data1;
    logic [3:0] data2;
    logic registerWriteEnable;
    logic [3:0] writeRegisterAddress;
    logic [7:0] readRegisterData1, readRegisterData2, writeRegisterData; 
    logic [4:0] romMemoryAddress = 5'b00000;
    logic [15:0] instruction;
    logic [15:0] romMemoryInstruction; 
    logic memoryWriteEnable;
    logic [3:0] writeDataAddress;
    logic [3:0] memoryAddress = 4'b0000;
    logic [7:0] readRamData1, readRamData2, writeData;  
    logic [2:0] aluControl;
    logic [7:0] aluResult;

 
    // create buttons
    Debouncer upButton( clk, debouncer[1], reset);
    Debouncer centerButton( clk, debouncer[0], getFromSwitches);
    Debouncer rightButton( clk, debouncer[3], next);
    Debouncer leftButton( clk, debouncer[2], previous);
    Debouncer downButton( clk, debouncer[4], getFromMemory);
    
    always_ff@(posedge clk, posedge reset) 
    begin
        if (reset)
            begin
            
            romMemoryAddress <= 5'b00000;
            
            end
            
        else begin 
        
        if (!stop) 
        begin
        
        instruction <= 16'b1000000000000000;
        
            if (previous)
                if (memoryAddress == 4'b0000)
                   memoryAddress <= 4'b1111;
                else
                   memoryAddress <= memoryAddress - 1;
                   
            else if (next)
                 if (memoryAddress == 4'b1111)
                     memoryAddress <= 4'b0000;
                 else
                     memoryAddress <= memoryAddress + 1;
             
             else if (getFromMemory) 
                begin
                instruction <= romMemoryInstruction;  
                if (romMemoryAddress == 5'b11111)
                   romMemoryAddress <= 5'b00000;
                else
                   romMemoryAddress <= romMemoryAddress + 1; 
            end
            
            else if (getFromSwitches)
                instruction <= swIns;
                
            else if (branch)
                romMemoryAddress <= instruction[12:8];
        end
        end
    end
        
    Controller controlUnit( reset, instruction[15:13], stop, add, branchEnable, registerWriteEnable, memoryWriteEnable, aluControl);
    
    Multiplexer multiplexer1(instruction[12], readRegisterData1, instruction[7:0], writeData);
    Multiplexer multiplexer2(instruction[12], readRamData1, instruction[7:0], data1);
    Multiplexer multiplexer3(add, data1, aluResult, writeRegisterData);
    
    MultiplexerBranch multiplexer4(branchEnable, 0, aluResult[0], branch);
    
    MultiplexerAddress multiplexer5(instruction[12], instruction[7:4], instruction[11:8], writeDataAddress);
    MultiplexerAddress multiplexer6(instruction[12], instruction[7:4], instruction[11:8], data2);
    MultiplexerAddress multiplexer7(add, data2, instruction[11:8], writeRegisterAddress);
            
    DataMemory memory(clk, reset, memoryWriteEnable, writeDataAddress, writeData, instruction[3:0], memoryAddress, readRamData1, readRamData2 );
    InstructionMemory instructions(romMemoryAddress, romMemoryInstruction, insLed);
    ALU alu(readRegisterData1, readRegisterData2, aluControl, aluResult);
    RegisterFile registerFile(clk, reset, registerWriteEnable, writeRegisterAddress, writeRegisterData, instruction[3:0], instruction[7:4], readRegisterData1, readRegisterData2);
    SevenSegmentDisplay sevenSegmentDisplay(clk, memoryAddress, 1, readRamData2[7:4], readRamData2[3:0], seg, dp, an);
 
endmodule