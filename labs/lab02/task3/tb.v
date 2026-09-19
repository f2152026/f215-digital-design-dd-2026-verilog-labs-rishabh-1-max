

module tb;
  reg  [1:0] t_a;
  reg  [1:0] t_b;
  wire       t_gt;
  wire       t_lt;
  wire       t_eq;

  
  reg exp_gt;
  reg exp_lt;
  reg exp_eq;

  integer a_idx, b_idx;
  integer errors = 0;
  integer total_tests = 0;

  
  comp2 DUT (
    .A (t_a),
    .B (t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
  );

  
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);$dumpvars(0, DUT);
    end
  end

  initial begin
    
    for (a_idx = 0; a_idx < 4; a_idx = a_idx + 1) begin
      for (b_idx = 0; b_idx < 4; b_idx = b_idx + 1) begin
        t_a = a_idx[1:0];
        t_b = b_idx[1:0];
        #5;

        // Independent calculation
        exp_gt = (t_a > t_b);
        exp_lt = (t_a < t_b);
        exp_eq = (t_a == t_b);
        total_tests = total_tests + 1;

        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b | got GT=%b LT=%b EQ=%b | expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    $write("Summary: %0d / %0d tests passed.\n", (total_tests - errors), total_tests);
    if (errors == 0)
      $display("ALL TESTS PASSED.");
    else
      $display("VERIFICATION FAILED with %0d errors.", errors);

    $finish;
  end
endmodule