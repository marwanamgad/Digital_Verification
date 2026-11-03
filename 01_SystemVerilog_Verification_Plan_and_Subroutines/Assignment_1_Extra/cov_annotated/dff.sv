//      // verilator_coverage annotation
        module dff #(
            parameter int USE_EN = 1
        ) (
 000018     input  logic clk,
 000004     input  logic rst,
 000004     input  logic d  ,
 000008     input  logic en ,
 000002     output logic q 
        );
        
 000018     always_ff @(posedge clk) begin
 000010         if(rst) begin
 000010             q <= 0;
                end
 000004         else if(USE_EN == 1 ) begin
 000002             if(en)begin
 000002                 q <= d;
                    end    
 000004         end else begin
 000004             q <= d;
                end
            end
        endmodule
