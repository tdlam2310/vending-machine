`default_nettype none
// Empty top module

module top (
  // I/O ports
  input  logic hz100, reset,
  input  logic [20:0] pb,
  output logic [7:0] left, right,
         ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue,

  // UART ports
  output logic [7:0] txdata,
  input  logic [7:0] rxdata,
  output logic txclk, rxclk,
  input  logic txready, rxready
);
    logic [4:0] vm_balance;
    logic [1:0] vm_state;
    vm vendm(.five(pb[5]), .ten(pb[10]), .clk(pb[0]) , .rst(pb[1]), .balance(vm_balance), .state(vm_state));
    display dis(.state(vm_state), .balance(vm_balance), .ss0(ss0), .ss1(ss1), .red(red), .green(green), .blue(blue));
endmodule

module display(
    input logic [1:0] state,
    input logic [4:0] balance,
    output logic [7:0] ss0, ss1,
    output logic red, blue, green
);

    typedef enum logic [1:0]{
        Good = 0,
        Reset = 1,
        Dispensed = 2
    }state_t;
    logic [7:0] ss0a;
    logic [7:0] ss1a;
    logic [4:0] tens_digits;
    logic [4:0] unit_digits;
    assign tens_digits = balance / 5'd10;
    assign unit_digits = balance % 5'd10;
    ssdec a(.in(tens_digits), .enable(1'b1), .out(ss1a));
    ssdec b(.in(unit_digits), .enable(1'b1), .out(ss0a));


   
    always_comb begin
       
        case(state)
            Good: begin //display balance
                ss0 = ss0a;
                ss1 = ss1a;
                red = '0; green = '0; blue = '0;
            end

            Reset: begin
                red = '0; green = '0; blue = '1;
                //dispaly balance
                ss0 = ss0a;
                ss1 = ss1a;
            end
            Dispensed: begin
                red = '0; green = '1; blue = '0;
                //display balance
                ss0 = ss0a;
                ss1 = ss1a;
            end
            default: begin
                ss0 = ss0a;
                ss1 = ss1a;
                red = '0; green = '0; blue = '0;
            end

        endcase
      end
endmodule

module vm(
    //input logic [4:0] money_in,
    input logic five, ten,
    input clk, rst,
    output logic [4:0] balance,
    output logic [1:0] state
);  
    typedef enum logic [1:0]{
        Good = 0,
        Reset = 1,
        Dispensed = 2
    }state_t;
    logic [4:0] money_in;
   
    logic [4:0] n_balance;
    logic [1:0] n_state;
   
   
    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            balance <= '0;
            state <= Good;
        end
        else begin
            balance <= n_balance;
            state <= n_state;
        end

    end
   
    always_comb begin
        money_in = '0;
        n_balance = '0;
    // Default: hold current value
        n_state = state;
        if (five) begin
            money_in = 5'd5;
           
        end
        else if(ten) begin
            money_in = 5'd10;
        end
    // end
   
   
    // always_comb begin

        if(balance + money_in < 5'd25) begin
            n_balance = balance + money_in;
        end
        else if ((balance + money_in >= 5'd25)) begin
            n_balance = balance + money_in - 5'd25;
        end

    // end
   
   
    // always_comb begin
        case(state)
            Good:
                if(rst) begin
                    n_state = Reset;
                end else if (balance + money_in >= 5'd25) begin
                    n_state = Dispensed;
                end else begin
                    n_state = Good;
                end
               
            Reset:
                n_state = (money_in == 5'd5 || money_in == 5'd1)? Good: Reset;
            Dispensed:
                n_state = (money_in == 5'd5 || money_in == 5'd1)? Good: Dispensed;
            default: begin
              n_state = Good;
            end


        endcase
    end
endmodule
module ssdec(
    input logic [4:0] in,
    input logic enable,
    output logic [7:0] out
);
    always_comb begin
        if (enable == 0) begin
            out = 8'b00000000;
        end
        else begin
            case(in)
                5'b00000: out = 8'b00111111;  // 0
                5'b00001: out = 8'b00000110;  // 1
                5'b00010: out = 8'b01011011;  // 2
                5'b00011: out = 8'b01001111;  // 3
                5'b00100: out = 8'b01100110;  // 4
                5'b00101: out = 8'b01101101;  // 5
                5'b00110: out = 8'b01111101;  // 6
                5'b00111: out = 8'b00000111;  // 7
                5'b01000: out = 8'b01111111;  // 8
                5'b01001: out = 8'b01101111;  // 9
                5'b01010: out = 8'b01110111;  // A
                5'b01011: out = 8'b01111100;  // B
                5'b01100: out = 8'b00111001;  // C
                5'b01101: out = 8'b01011110;  // D
                5'b01110: out = 8'b01111001;  // E
                5'b01111: out = 8'b01110001;  // F
                default:  out = 8'b00000000;
            endcase
        end
    end
endmodule

	

