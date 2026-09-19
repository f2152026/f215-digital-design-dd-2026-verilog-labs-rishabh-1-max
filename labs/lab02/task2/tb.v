// tb.v
// Starter testbench template -- YOU complete this file.

module tb;
  localparam TEST_WIDTH = 8;
  localparam TEST_DEPTH = 8;

  // TODO: declare the inputs and outputs
  reg  [$clog2(TEST_DEPTH)-1:0] t_sel;
  wire [TEST_WIDTH-1:0]         t_dout;

  // TODO: instantiate DUT here
  lut #(
    .WIDTH(TEST_WIDTH),
    .DEPTH(TEST_DEPTH)
  ) DUT (
    .sel (t_sel),
    .dout(t_dout)
  );

  integer i;
  integer errors = 0;
  reg [TEST_WIDTH-1:0] expected;

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations
    for (i = 0; i < TEST_DEPTH; i = i + 1) begin
      t_sel = i;
      #5;
      expected = i * i;
      if (t_dout !== expected) begin
        $display("FAIL at address %0d: got %0d, expected %0d", i, t_dout, expected);
        errors = errors + 1;
      end
    end

    if (errors == 0)
      $display("PASS: All %0d memory locations verified correctly.", TEST_DEPTH);
    else
      $display("FAIL: Found %0d mismatches.", errors);

    $finish;
  end

  

  initial
    $monitor($time, " sel=%0d | dout=%0d", t_sel, t_dout); // change as required

endmodule