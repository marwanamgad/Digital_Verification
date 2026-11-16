module adder_tb ();

reg clk, reset;
reg  signed [3:0] A, B;
wire signed [4:0] C;

integer error_count;
integer correct_count;

localparam MAXPOS = 7;
localparam MAXNEG = -8;
localparam ZERO = 0;

adder a1 (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .C(C)
);

initial begin
 clk = 0;
 forever begin
   #1 clk = ~clk;
 end
end


initial begin
    error_count = 0;
    correct_count = 0;
    A = 0;
    B = 0;
    reset = 0;

    assert_reset;

    A = MAXPOS; B = MAXPOS;
    check_result(14);

    A = MAXNEG; B = MAXNEG;
    check_result(-16);

    A = MAXPOS; B = MAXNEG;
    check_result(-1);

    A = MAXNEG; B = MAXPOS;
    check_result(-1);

    A = MAXPOS; B = ZERO;
    check_result(7);

    A = MAXNEG; B = ZERO;
    check_result(-8);

    A = ZERO; B = MAXPOS;
    check_result(7);

    A = ZERO; B = MAXNEG;
    check_result(-8);

    A = ZERO; B = ZERO;
    check_result(0);

    assert_reset;

    $display("%t: At the end of test error count is %0d and correct count is %0d",$time, error_count, correct_count);
    $finish;


end


task check_result(input signed [4:0] expected_result);
    @(negedge clk);
    if(expected_result !== C) begin
        error_count = error_count + 1;
        $display("Error");
    end else begin
        correct_count = correct_count + 1;
    end

endtask


task assert_reset;
reset = 1;
check_result(0);
reset = 0;
endtask
    
endmodule