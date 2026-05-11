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

  // DUT Instance
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
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Initialize inputs
  initial begin
    ena = 1'b1;
    rst_n = 1'b0;
    ui_in = 8'b0;
    uio_in = 8'b0;

    #20;
    rst_n = 1'b1;
  end

endmodule
