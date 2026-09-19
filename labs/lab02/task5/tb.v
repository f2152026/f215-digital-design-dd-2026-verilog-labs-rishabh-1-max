

module tb;
  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  reg  [3:0] exp_result;
  integer    errors = 0;
  integer    total_tests = 0;

  alu DUT (
    .a     (t_a),
    .b     (t_b),
    .op    (t_op),
    .result(t_result)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);$dumpvars(0, DUT);
    end
  end

  task check_op;
    input [3:0] in_a;
    input [3:0] in_b;
    input       in_op;
    begin
      t_a  = in_a;
      t_b  = in_b;
      t_op = in_op;
      #5;

      exp_result  = (in_op == 1'b0) ? (in_a + in_b) : (in_a - in_b);
      total_tests = total_tests + 1;

      if (t_result !== exp_result) begin
        $display("FAIL at time %0t: op=%b a=%0d b=%0d | got %0d, expected %0d",
                 $time, t_op, t_a, t_b, t_result, exp_result);
        errors = errors + 1;
      end
    end
  endtask

  initial begin
    // Bug 1 trigger: Keep a and b the same, flip op from 0 to 1
    check_op(4'd7, 4'd3, 1'b0); // 7 + 3 = 10
    check_op(4'd7, 4'd3, 1'b1); // 7 - 3 = 4 (FAILS due to missing op in sensitivity list)

    // Bug 2 trigger: Subtraction dependency chain
    check_op(4'd9, 4'd2, 1'b1); // 9 - 2 = 7 (FAILS due to non-blocking <=)
    check_op(4'd5, 4'd5, 1'b1); // 5 - 5 = 0
    check_op(4'd2, 4'd3, 1'b1); // 2 - 3 = 15 (modular wrap)

    $write("Summary: %0d / %0d tests passed.\n", (total_tests - errors), total_tests);
    if (errors == 0)
      $display("ALL TESTS PASSED.");
    else
      $display("VERIFICATION FAILED with %0d errors.", errors);

    $finish;
  end
endmodule