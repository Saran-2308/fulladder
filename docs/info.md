How it works

This project implements a 1-bit Full Adder using combinational logic.
The Full Adder adds three 1-bit binary inputs: A, B, and Carry-in (Cin).
It produces two outputs: Sum and Carry-out (Cout).

The Sum output is generated using XOR logic, and the Carry-out is generated using AND-OR logic.

Inputs:

ui_in[0] → A
ui_in[1] → B
ui_in[2] → Cin

Outputs:

uo_out[0] → Sum
uo_out[1] → Cout
How to test

Apply different combinations of binary inputs to A, B, and Cin through ui_in.

Verify the outputs:

Sum on uo_out[0]
Carry-out on uo_out[1]

Example:

A = 1
B = 1
Cin = 0

Expected Output:

Sum = 0
Cout = 1

Run simulation using the provided testbench to verify all input combinations.

External hardware

No external hardware is required for this project.
