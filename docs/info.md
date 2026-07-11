<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This is the "Overture" architecture from the game [Turing Complete](https://turingcomplete.game/),
built as a schematic and exported to Verilog from the `sandbox` circuit.

The design (`src/sandbox.v`) is composed of Turing Complete's built-in components
(the `TC_*` modules under `src/`): registers, a counter used as a program counter,
a RAM/ROM initialized from `src/1948035650992482295.hex`, decoders, an ALU
(add / not / nand / and / or / xor), muxes, and bit splitters/makers.

`src/project.v` is a thin Tiny Tapeout wrapper (`tt_um_jorropo_overture`) that adapts
the exported module to the TT pin interface:

| TT pin        | Overture signal | Notes                                  |
| ------------- | --------------- | -------------------------------------- |
| `ui_in[7:0]`  | `in[7:0]`       | 8-bit input bus                        |
| `uo_out[7:0]` | `out[7:0]`      | 8-bit output bus                       |
| `uio_out[0]`  | `out_en`        | high when the design drives `out`      |
| `uio_out[1]`  | `in_en`         | high when the design requests an input |
| `rst_n`       | `~rst`          | TT reset is active-low; Overture is active-high |

`uio[0]` and `uio[1]` are configured as outputs (`uio_oe = 0b00000011`); the remaining
bidirectional pins are unused.

## How to test

Drive `ui_in` with the input byte and pulse `clk`. Watch `uo_out` for the output byte and
`uio_out[0]` (`out_en`) to know when the output is valid; `uio_out[1]` (`in_en`) indicates the
design is requesting the next input. Hold `rst_n` low for a few cycles first to reset the
program counter and registers. The program executed comes from
`src/1948035650992482295.hex`.

## External hardware

None.
