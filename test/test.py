# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def test_full_adder(dut):

    dut._log.info("Starting Full Adder Test")

    # Initialize signals
    dut.ena.value = 1
    dut.rst_n.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.clk.value = 0

    # Reset delay
    await Timer(20, unit="ns")

    # Release reset
    dut.rst_n.value = 1

    # Full Adder test vectors
    test_vectors = [
        # A B Cin Sum Cout
        (0, 0, 0, 0, 0),
        (0, 0, 1, 1, 0),
        (0, 1, 0, 1, 0),
        (0, 1, 1, 0, 1),
        (1, 0, 0, 1, 0),
        (1, 0, 1, 0, 1),
        (1, 1, 0, 0, 1),
        (1, 1, 1, 1, 1),
    ]

    # Apply all inputs
    for A, B, Cin, exp_sum, exp_cout in test_vectors:

        # Apply inputs
        dut.ui_in.value = (Cin << 2) | (B << 1) | A

        # Wait for propagation
        await Timer(10, unit="ns")

        # Read outputs
        sum_out = int(dut.uo_out.value[0])
        cout_out = int(dut.uo_out.value[1])

        dut._log.info(
            f"A={A} B={B} Cin={Cin} "
            f"=> Sum={sum_out} Cout={cout_out}"
        )

        # Assertions
        assert sum_out == exp_sum, (
            f"SUM ERROR for A={A}, B={B}, Cin={Cin}"
        )

        assert cout_out == exp_cout, (
            f"COUT ERROR for A={A}, B={B}, Cin={Cin}"
        )

    dut._log.info("All Full Adder test cases passed!")

    await Timer(20, unit="ns")
