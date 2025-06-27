module fsm(
    input logic clk, rst,
    input logic [4:0] keyout,
    input logic [31:0] seq,
    output logic [3:0] state
);
    typedef enum logic [3:0] {
        LS0=0,
        LS1=1,
        LS2=2,
        LS3=3,
        LS4=4,
        LS5=5,
        LS6=6,
        LS7=7,
        OPEN=8,
        ALARM=9,
        INIT=10
    } state_t;
    logic [3:0] next_state;
    logic [31:0] seq1;
    
    always_ff @(posedge clk, posedge rst) begin
        if(rst) begin
            state <= INIT;
            seq1 <= 0;
        end
        else if (keyout == 5'd16) begin
          seq1 <= seq;
          state <= next_state;
        end
        else begin
            state <= next_state;
        end
    end
    always_comb begin
        
        case (state)
            INIT: next_state = (keyout == 5'd16) ? LS0:INIT;
            LS0 : next_state = (seq1[31:28] == keyout[3:0]) ? LS1:ALARM;
            LS1 : next_state = (seq1[27:24] == keyout[3:0]) ? LS2:ALARM;
            LS2 : next_state = (seq1[23:20] == keyout[3:0]) ? LS3:ALARM;
            LS3 : next_state = (seq1[19:16] == keyout[3:0]) ? LS4:ALARM;
            LS4 : next_state = (seq1[15:12] == keyout[3:0]) ? LS5:ALARM;
            LS5 : next_state = (seq1[11:8] == keyout[3:0]) ? LS6:ALARM;
            LS6 : next_state = (seq1[7:4] == keyout[3:0]) ? LS7:ALARM;
            LS7 : next_state = (seq1[3:0] == keyout[3:0]) ? OPEN:ALARM;
            OPEN : next_state = OPEN;
            ALARM: next_state = ALARM;
            default: next_state = INIT;

        endcase
    end

endmodule
