module lab1(
    input CLOCK_50,                  // CLOCK_50
    input [1:0] KEY,                // KEY[0] active-low reset
           // KEY[1] active-low start
    input [2:0] SW,             // SW[2:0] for A-H
    output reg [0:0] LEDR            // LEDR[0][0]
);

    // === FSM States ===
    parameter IDLE  = 3'b000;
    parameter LOAD  = 3'b001;
    parameter ON    = 3'b010;
    parameter GAP   = 3'b011;
    parameter DONE  = 3'b100;

    reg [2:0] state, next_state;

    // === Timing Constants (for 50MHz clock) ===
    localparam DOT  = 25_000_000;  // 0.5s
    localparam DASH = 75_000_000;  // 1.5s
    localparam GAPT = 25_000_000;  // 0.5s between symbols

    // === Morse Code Table ===
    reg [3:0] morse_code;
    reg [2:0] code_len;

    always @(*) begin
        case (SW)
            3'd0: begin morse_code = 4'b01;   code_len = 2; end // A: .-
            3'd1: begin morse_code = 4'b1000; code_len = 4; end // B: -...
            3'd2: begin morse_code = 4'b1010; code_len = 4; end // C: -.--
            3'd3: begin morse_code = 4'b100;  code_len = 3; end // D: -..
            3'd4: begin morse_code = 4'b0;    code_len = 1; end // E: .
            3'd5: begin morse_code = 4'b0010; code_len = 4; end // F: ..-.
            3'd6: begin morse_code = 4'b110;  code_len = 3; end // G: --.
            3'd7: begin morse_code = 4'b0000; code_len = 4; end // H: ....
            default: begin morse_code = 4'b0; code_len = 0; end
        endcase
    end

    // === Internal Registers ===
    reg [26:0] timer;
    reg [2:0] index;
    reg current_symbol;

    // === Combinational FSM Transition Logic ===
    always @(*) begin
        next_state = state;
        case (state)
            IDLE:  if (!KEY[1]) next_state = LOAD;

            LOAD:  next_state = ON;

            ON:    if (timer == 0) next_state = GAP;

            GAP:   if (timer == 0)
                       next_state = (index == code_len) ? DONE : LOAD;

            DONE:  next_state = IDLE;
        endcase
    end

    // === FSM Output Logic (Sequential) ===
    always @(posedge CLOCK_50 or negedge KEY[0]) begin
        if (!KEY[0]) begin
            state <= IDLE;
            LEDR[0] <= 0;
            timer <= 0;
            index <= 0;
            current_symbol <= 0;
        end else begin
            state <= next_state;

            case (next_state)
                IDLE: begin
                    LEDR[0] <= 0;
                    index <= 0;
                    timer <= 0;
                end

                LOAD: begin
                    current_symbol <= morse_code[code_len - 1 - index];
                end

                ON: begin
                    LEDR[0] <= 1;
                    if (timer == 0) begin
                        timer <= (current_symbol == 0) ? DOT : DASH;
                    end else begin
                        timer <= timer - 1;
                    end
                end

                GAP: begin
                    LEDR[0] <= 0;
                    if (timer == 0) begin
                        timer <= GAPT;
                        index <= index + 1;
                    end else begin
                        timer <= timer - 1;
                    end
                end

                DONE: begin
                    LEDR[0] <= 0;
                end
            endcase
        end
    end

endmodule
