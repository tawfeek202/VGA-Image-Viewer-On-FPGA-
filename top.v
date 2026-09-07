module top (
    input wire clk_50,
    input wire rstn,
    input wire [2:0] i_switch,

    output wire h_sync,
    output wire v_sync,
    output wire [7:0] red,
    output wire [7:0] blue,
    output wire [7:0] green,
    output wire vga_clk,
    output wire vga_sync_N,
    output wire vga_blank_N
);

  wire clk_25;
  wire video_on;
  wire rst;

  wire [9:0] pixel_x;
  wire [9:0] pixel_y;
  wire [16:0] rom_addr;
  wire [23:0] rom_data;

  assign vga_clk = clk_25;
  assign vga_sync_N = 1'b0;
  assign vga_blank_N = video_on;
  assign rst = ~rstn;

  // Scale 640x480 down to 320x240 by dropping the LSB (bit 0)
  // Address formula: (Y * width) + X
  assign rom_addr = (pixel_y[9:1] * 17'd320) + pixel_x[9:1];

  // ROM Instantiation
  ROM R1 (
      .address(rom_addr),
      .clock(clk_25),
      .q(rom_data)
  );

  // Extract the 24-bit output (RRGGBB) into the 8-bit channels
  assign red   = video_on ? rom_data[23:16] : 8'd0;
  assign green = video_on ? rom_data[15:8] : 8'd0;
  assign blue  = video_on ? rom_data[7:0] : 8'd0;

  // VGA Timing Generator
  VGA V1 (
      .clk(clk_25),
      .rst(rstn),
      .h_sync(h_sync),
      .v_sync(v_sync),
      .video_on(video_on),
      .pixel_x(pixel_x),
      .pixel_y(pixel_y)
  );

  // PLL Instantiation
  PLL P1 (
      .refclk(clk_50),
      .rst(rst),
      .outclk_0(clk_25)
  );

endmodule
