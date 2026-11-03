module dff #(
    parameter int USE_EN = 1
) (
    input  logic clk,
    input  logic rst,
    input  logic d  ,
    input  logic en ,
    output logic q 
);

    always_ff @(posedge clk) begin
        if(rst) begin
            q <= 0;
        end
        else if(USE_EN == 1 ) begin
            if(en)begin
                q <= d;
            end    
        end else begin
            q <= d;
        end
    end
endmodule