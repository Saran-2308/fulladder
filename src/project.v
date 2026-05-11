/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path
    input  wire       ena,      // always 1
    input  wire       clk,      // clock
    input  wire       rst_n     // active low reset
);

    // Full Adder Inputs
    wire A;
    wire B;
    wire Cin;

    // Full Adder Outputs
    wire Sum;
    wire Cout;

    assign A   = ui_in[0];
    assign B   = ui_in[1];
    assign Cin = ui_in[2];

    // Full Adder Logic
    assign Sum  = A ^ B ^ Cin;
    assign Cout = (A & B) | (B & Cin) | (A & Cin);

    // Output assignment
    assign uo_out[0] = Sum;
    assign uo_out[1] = Cout;

    // Unused outputs set to 0
    assign uo_out[7:2] = 6'b000000;

    // IOs not used
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Prevent unused signal warnings
    wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule
