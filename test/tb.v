`default_nettype none
`timescale 1ns / 1ps

module tb ();

  // Dump waveform
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
  end

  // Inputs
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;

  // Outputs
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Instantiate DUT
  tt_um_example user_project (

`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in(ui_in),
      .uo_out(uo_out),
      .uio_in(uio_in),
      .uio_out(uio_out),
      .uio_oe(uio_oe),
      .ena(ena),
      .clk(clk),
      .rst_n(rst_n)
  );

  // Clock generation
  always #5 clk = ~clk;

  integer i;

  initial begin

    // Initialize signals
    clk = 0;
    rst_n = 0;
    ena = 1;
    ui_in = 0;
    uio_in = 0;

    // Apply reset
    #10;
    rst_n = 1;

    $display(" A B Cin | Sum Cout ");
    $display("--------------------");

    // Test all combinations
    for (i = 0; i < 8; i = i + 1) begin

      ui_in[0] = i[0]; // A
      ui_in[1] = i[1]; // B
      ui_in[2] = i[2]; // Cin

      #10;

      $display(" %b %b  %b  |  %b    %b",
                ui_in[0],
                ui_in[1],
                ui_in[2],
                uo_out[0],   // Sum
                uo_out[1]);  // Cout
    end

    #20;
    $finish;
  end

endmodule
