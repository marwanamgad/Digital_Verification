module dff_t1_tb;
    logic clk, rst, d, en;
    logic q_exp, q_dut;

    localparam USE_EN = 1;

    integer error_count = 0;
    integer correct_count = 0;

    dff #(.USE_EN(USE_EN)) DUT(.clk(clk), .rst(rst), .d(d), .q(q_dut), .en(en));

    // Waveform for GTKWave
    initial begin
        $dumpfile("dff_t1.vcd");
        $dumpvars(0, dff_t1_tb);
    end

    // Create the clock and rst
    initial begin
        clk= 0;
        forever
            #1 clk= ~clk;
    end

    initial begin
        rst = 1; d = 0; en = 0; check_result;
        rst = 1; d = 0; en = 1; check_result;
        rst = 1; d = 1; en = 0; check_result;
        rst = 1; d = 1; en = 1; check_result;
        rst = 0; d = 0; en = 0; check_result;
        rst = 0; d = 0; en = 1; check_result;
        rst = 0; d = 1; en = 0; check_result;
        rst = 0; d = 1; en = 1; check_result;

        rst = 1; check_result;

        $display("%t: At end of test error count is %0d and correct count = %0d", $time, error_count, correct_count);
        $stop;
    end

    // Golden model
    always @(posedge clk) begin
        if (rst)
            q_exp <= 0;
        else if (USE_EN == 1) begin
            if (en)
                q_exp <= d;
        end
        else
            q_exp <= d;
    end

    //Checker
    task check_result;
        @(negedge clk);
        if (q_dut !== q_exp) begin
            $display("%t: Error - for rst=%b d=%b en=%b : q_dut = %b, but expected q = %b", $time, rst, d, en, q_dut, q_exp);
            error_count = error_count + 1;
        end
        else begin
            correct_count = correct_count + 1;
        end
    endtask
endmodule