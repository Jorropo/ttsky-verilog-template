# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_reset_and_run(dut):
    """Smoke test for the Overture CPU.

    The design loads its program into RAM from ui_in while reset is asserted,
    then runs it. This test only checks that reset works and the design runs
    without producing X on the outputs. Replace the program bytes and add
    assertions once you have a concrete program to test.
    """
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset. While rst_n is low, the program is streamed in on ui_in.
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Run")
    # Let the CPU execute for a while.
    await ClockCycles(dut.clk, 20)

    # Outputs must be driven (no X/Z). uio[0]=out_en, uio[1]=in_en.
    assert dut.uo_out.value.is_resolvable, "uo_out has undefined bits"
    assert dut.uio_out.value.is_resolvable, "uio_out has undefined bits"
    assert dut.uio_oe.value == 0b00000011, "uio_oe should mark uio[0]/uio[1] as outputs"
