
# SPDX-FileCopyrightText: Copyright 2024 Darryl L. Miles
# SPDX-License-Identifier: Apache-2.0

import sys
import random

import cocotb
from cocotb.clock import Clock
from cocotb.binary import BinaryValue
from cocotb.triggers import ClockCycles

from cocotb_stuff.cocotbutil import *

DEBUG_LEVEL = 1


def uart_rx_mark(ui_in: int) -> int:
    return ui_in | 0x80


def uart_rx_space(ui_in: int) -> int:
    return ui_in & ~(0x80)


def uart_rx(ui_in: int, bf: bool) -> int:
    if bf:
        return uart_rx_mark(ui_in)
    else:
        return uart_rx_space(ui_in)


TICKS_PER_UART_RX_BIT = 64	# 1:1
TICKS_PER_UART_RX_BIT = 32	# 2:1

async def uart_host_to_dut(dut, ui_in: int, ch: int, ticks_per_bit: int = TICKS_PER_UART_RX_BIT) -> int:
    ui_in = uart_rx_space(ui_in)	# START
    dut.ui_in.value = ui_in
    await ClockCycles(dut.clk, ticks_per_bit)

    for bit in range(8):		# LSB first
        #debug(dut, f"{bit}")
        bf = ch & (1 << bit) != 0	# bit as bool
        ui_in = uart_rx(ui_in, bf)
        dut.ui_in.value = ui_in
        await ClockCycles(dut.clk, ticks_per_bit)

    debug(dut, f"STOP")
    ui_in = uart_rx_mark(ui_in)		# STOP
    dut.ui_in.value = ui_in    
    await ClockCycles(dut.clk, ticks_per_bit)

    return ui_in


@cocotb.test()
async def test_fskmodem(dut):
    dut._log.info("Start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    await ClockCycles(dut.clk, 2)       # show X

    debug(dut, 'RESET')

    # ena=0 state
    dut.ena.value = 0
    dut.rst_n.value = 0
    dut.clk.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    await ClockCycles(dut.clk, 2)       # show muted inputs ena=0

    dut._log.info("ena (active)")
    dut.ena.value = 1                   # ena=1
    await ClockCycles(dut.clk, 2)

    dut._log.info("reset (inactive)")
    dut.rst_n.value = 1                 # leave reset
    await ClockCycles(dut.clk, 32)

    assert dut.uio_oe.value == 0xff, f"CFG expected 0xff with CFG=0x0000"

    debug(dut, 'CFG=ffff')

    # Validate reset configuration latches
    dut.ui_in.value = 0xff
    dut.uio_in.value = 0xff
    dut.rst_n.value = 0			# rst_n=0 active
    await ClockCycles(dut.clk, 2)

    dut.rst_n.value = 1			# rst_n=0 inactive
    await ClockCycles(dut.clk, 2)

    assert dut.uio_oe.value == 0x00, f"CFG expected OE=0x00 with CFG=0xffff"

    dut.ui_in.value = 0
    dut.uio_in.value = 0
    await ClockCycles(dut.clk, 6)


    debug(dut, 'CFG=ffff')

    # The actual configuration for use here
    # bit 01234567
    #     0 ------ RX PRESCALE 0=x16(1:2 data rate, recommended), 1=slower
    #      1 ----- TX PRESCALE 0=x16(1:2 data rate, recommended), 1=slower
    #       2 ---- RX DATA     0=internal nominal,                1=external
    #        3 --- TX DATA     0=UART internal nominal,           1=external provided PIN
    #         4 -- TX CLOCK    0=output (internally sourced)      1=external provided PIN
    #          5 - RX CLOCK    0=output (internally recovered)    1=external provided PIN
    #           6  UP/DOWN     0=internal source (faked here)     1=external provided PIN
    #            7 ADDR        0=internal source (from state)     1=external provided PINs
    dut.ui_in.value = 0xfc
    #
    # bit 01234567
    #     0 ------ NC
    #         4 -- TABLE LATENCY  0=0 clocks                      1=1 clocks
    #          5 - RX CLOCK       0=output                        1=input external provided
    #           67 BERT MODE      00=nominal  01=nominal inverted 10=BERT zero  11=BERT ones
    dut.uio_in.value = 0xff
    dut.rst_n.value = 0			# rst_n=0 active
    await ClockCycles(dut.clk, 2)

    dut.rst_n.value = 1			# rst_n=0 inactive
    await ClockCycles(dut.clk, 2)

    dut.ui_in.value = 0
    dut.uio_in.value = 0
    await ClockCycles(dut.clk, 6)

    assert dut.uio_oe.value == 0x00, f"CFG expected OE=0x00 with CFG=0xffff"


    debug(dut, 'START')

    await ClockCycles(dut.clk, 16)

    ui_in = 0
    uio_in = 0
    
    ui_in = uart_rx_mark(ui_in)		# simulate line connection

    dut.ui_in.value = ui_in
    await ClockCycles(dut.clk, 32)	# FSM  DISC to IDLE

    # FEND 0xc0 = 11000000 (LSB first)

    debug(dut, 'UART RX[FEND 0xc0]')
    ui_in = uart_rx_space(ui_in)	# START BIT edge
    dut.ui_in.value = ui_in
    await ClockCycles(dut.clk, 32)	# START mid sample
    await ClockCycles(dut.clk, 32)	# LSB0
    await ClockCycles(dut.clk, 32)
    await ClockCycles(dut.clk, 32)
    await ClockCycles(dut.clk, 32)
    await ClockCycles(dut.clk, 32)
    await ClockCycles(dut.clk, 32)	# LSB5

    ui_in = uart_rx_mark(ui_in)		# simulate line connection
    dut.ui_in.value = ui_in
    await ClockCycles(dut.clk, 32)	# bit6
    await ClockCycles(dut.clk, 32)	# bit7
    await ClockCycles(dut.clk, 32)	# STOP bit

    debug(dut, 'UART RX[FEND 0xc0]')
    # back-to-back async check
    ui_in = uart_rx_space(ui_in)	# START BIT edge
    dut.ui_in.value = ui_in
    await ClockCycles(dut.clk, 32)	# START mid sample
    await ClockCycles(dut.clk, 32)	# LSB0
    await ClockCycles(dut.clk, 32)
    await ClockCycles(dut.clk, 32)
    await ClockCycles(dut.clk, 32)
    await ClockCycles(dut.clk, 32)
    await ClockCycles(dut.clk, 32)	# LSB5

    ui_in = uart_rx_mark(ui_in)		# simulate line connection
    dut.ui_in.value = ui_in
    await ClockCycles(dut.clk, 32)	# bit6
    await ClockCycles(dut.clk, 32)	# bit7
    await ClockCycles(dut.clk, 32)	# STOP bit

    debug(dut, 'UART RX[0x00]')
    await uart_host_to_dut(dut, ui_in, 0x00)
    debug(dut, 'UART RX[0x55]')
    await uart_host_to_dut(dut, ui_in, 0x55)
    debug(dut, 'UART RX[0xaa]')
    await uart_host_to_dut(dut, ui_in, 0xaa)

    # This should look like the first packet
    debug(dut, 'UART RX[FEND 0xc0]')
    await uart_host_to_dut(dut, ui_in, 0xc0)
    debug(dut, 'UART RX[0xff]')
    await uart_host_to_dut(dut, ui_in, 0xff)	# CONTROL BYTE
    debug(dut, 'UART RX[FEND 0xc0]')
    await uart_host_to_dut(dut, ui_in, 0xc0)

    # empty packet NOOP check

    # This should look like the first packet
    debug(dut, 'UART RX[FEND 0xc0]')
    await uart_host_to_dut(dut, ui_in, 0xc0)
    debug(dut, 'UART RX[0x00]')
    await uart_host_to_dut(dut, ui_in, 0x00)	# CONTROL BYTE
    debug(dut, 'UART RX[FESC 0xdb]')
    await uart_host_to_dut(dut, ui_in, 0xdb)	# FESC
    debug(dut, 'UART RX[TFEND 0xdc]')
    await uart_host_to_dut(dut, ui_in, 0xdc)	# TFEND (0xc0)
    # expect [addr=01]0xc0
    debug(dut, 'UART RX[0x02]')
    await uart_host_to_dut(dut, ui_in, 0x02)
    debug(dut, 'UART RX[FESC 0xdb]')
    await uart_host_to_dut(dut, ui_in, 0xdb)	# FESC
    debug(dut, 'UART RX[TFESC 0xdd]')
    await uart_host_to_dut(dut, ui_in, 0xdd)	# TFESC (0xdb)
    # expect [addr=03]0xdb
    debug(dut, 'UART RX[0x04]')
    await uart_host_to_dut(dut, ui_in, 0x04)
    debug(dut, 'UART RX[0x05]')
    await uart_host_to_dut(dut, ui_in, 0x05)	# CTS assert check
    
    # command byte for key-up full-duplex
    # command byte for key-down full-duplex
    # command byte for key-up half-duplex
    # command byte for key-down half-duplex
    
    # dump synchronous
    
    # sync send continous SYNC
    
    # dump from UART RX FIFO
    
    # bitstuff
    # NRZI
    # TXDATA present
    # scramble

    # see ROM lookup

    dut._log.info("Test project behavior")

    # Set the input values you want to test
    #dut.ui_in.value = 20
    #dut.uio_in.value = 30

    await ClockCycles(dut.clk, 1000)
