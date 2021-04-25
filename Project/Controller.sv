module Controller(
    input logic reset,
    input logic [2:0] operationCode,
    output logic stop, add, branch, registerWriteEnable, memoryWriteEnable,
    output logic [2:0] aluControl);
      
    always_comb
    begin
        if( reset) 
        begin
            add = 0;
            branch = 0;
            stop = 0;
            memoryWriteEnable = 0;
            registerWriteEnable = 0;
            aluControl = 3'b000;
        end
        else begin
        
        case(operationCode)
            3'b000: // store
            begin 
                add = 0;
                branch = 0;
                stop = 0;
                memoryWriteEnable = 1;
                registerWriteEnable = 0;
                aluControl = 3'b000;
            end
            
            3'b001:  //load
            begin
                add = 0;
                branch = 0;
                stop = 0;
                memoryWriteEnable = 0;
                registerWriteEnable = 1;
                aluControl = 3'b001;
            end
            
            
            3'b010: // add
            begin
                add = 1;
                stop = 0;
                branch = 0;
                memoryWriteEnable = 0;
                registerWriteEnable = 1;
                aluControl = 3'b010;
            end
            
            3'b101: // branch if equals
            begin
                add = 0;
                stop = 0;
                branch = 1;
                memoryWriteEnable = 0;
                registerWriteEnable = 0;
                aluControl = 3'b101;
            end
            
            3'b111: // stop
            begin
                add = 0;
                stop = 1;
                branch = 0;
                memoryWriteEnable = 0;
                registerWriteEnable = 0;
                aluControl = 3'b000;
            end
            
            default:
            begin
                add = 0;
                stop = 0;
                branch = 0;
                memoryWriteEnable = 0;
                registerWriteEnable = 0;
                aluControl = 3'b000;
            end
         endcase
        end
    end
endmodule
