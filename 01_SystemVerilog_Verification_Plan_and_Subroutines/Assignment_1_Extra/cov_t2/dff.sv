//      // verilator_coverage annotation
        module dff #(
            parameter int USE_EN = 1
        ) (
 000009     input  logic clk,
 000002     input  logic rst,
 000002     input  logic d  ,
 000004     input  logic en ,
 000001     output logic q 
        );
        
 000009     always_ff @(posedge clk) begin
 000005         if(rst) begin
 000005             q <= 0;
                end
~000004         else if(USE_EN == 1 ) begin
%000000             if(en)begin
%000000                 q <= d;
                    end    
 000004         end else begin
 000004             q <= d;
                end
            end
        endmodule
