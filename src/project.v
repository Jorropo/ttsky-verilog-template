/*
 * Copyright (c) 2024 Jorropo
 * SPDX-License-Identifier: Apache-2.0
 *
 * Tiny Tapeout wrapper for the Turing Complete "Overture" architecture,
 * exported from the sandbox schematic (src/sandbox.v).
 */

`default_nettype none

module tt_um_jorropo_overture (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // The Turing Complete design uses an active-high reset.
  wire rst = ~rst_n;

  wire       out_en;
  wire       in_en;

  sandbox overture (
      .clk    (clk),
      .rst    (rst),
      .in     (ui_in),   // 8-bit input bus
      .out    (uo_out),  // 8-bit output bus
      .out_en (out_en),  // high when the design is driving `out`
      .in_en  (in_en)    // high when the design is requesting input
  );

  // Expose the enable/handshake signals on the bidirectional pins as outputs.
  assign uio_out = {6'b0, in_en, out_en};
  assign uio_oe  = 8'b0000_0011;  // uio[0] and uio[1] are outputs

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in, 1'b0};

endmodule
