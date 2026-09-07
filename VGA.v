module VGA (
    input wire clk,
    input wire rst,

    output reg h_sync,
    output reg v_sync,
    output reg video_on,
    output wire [9:0] pixel_x,
    output wire [9:0] pixel_y
);

  localparam v_on = 2'b00, FP = 2'b01, SP = 2'b10, BP = 2'b11;

  reg [1:0] Current_state_h, next_state_h;
  reg [1:0] Current_state_v, next_state_v;
  reg [9:0] h_counter;
  reg [9:0] v_counter;

  wire h_tick = (h_counter == 10'd799);

  // Export counters to the top module
  assign pixel_x = h_counter;
  assign pixel_y = v_counter;

  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      h_counter <= 10'd0;
      v_counter <= 10'd0;
    end else begin
      if (h_counter == 10'd799) begin
        h_counter <= 10'd0;
        if (v_counter == 10'd524) v_counter <= 10'd0;
        else v_counter <= v_counter + 10'd1;
      end else begin
        h_counter <= h_counter + 10'd1;
      end
    end
  end

  // HSYNC FSM
  always @(posedge clk or negedge rst) begin
    if (!rst) Current_state_h <= v_on;
    else Current_state_h <= next_state_h;
  end
  always @(*) begin
    case (Current_state_h)
      v_on: next_state_h = (h_counter == 10'd640) ? FP : v_on;
      FP: next_state_h = (h_counter == 10'd656) ? SP : FP;
      SP: next_state_h = (h_counter == 10'd752) ? BP : SP;
      BP: next_state_h = (h_counter == 10'd799) ? v_on : BP;
      default: next_state_h = v_on;
    endcase
  end

  // VSYNC FSM
  always @(posedge clk or negedge rst) begin
    if (!rst) Current_state_v <= v_on;
    else Current_state_v <= next_state_v;
  end
  always @(*) begin
    case (Current_state_v)
      v_on: next_state_v = (v_counter == 10'd480) ? FP : v_on;
      FP: next_state_v = (v_counter == 10'd490) ? SP : FP;
      SP: next_state_v = (v_counter == 10'd492) ? BP : SP;
      BP: next_state_v = (v_counter == 10'd524 && h_tick) ? v_on : BP;
      default: next_state_v = v_on;
    endcase
  end

  // Outputs
  always @(*) begin
    h_sync   = (Current_state_h == SP) ? 1'b0 : 1'b1;
    v_sync   = (Current_state_v == SP) ? 1'b0 : 1'b1;
    video_on = (Current_state_h == v_on) && (Current_state_v == v_on);
  end

endmodule
