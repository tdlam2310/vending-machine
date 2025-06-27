module display(
    input logic [3:0] state,
    input logic [31:0] seq,
    output logic [63:0] ss,
    output logic red, green, blue
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
    // 
    // logic [3:0] c_state;
    
    // assign ss = {ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0};
    logic [7:0] ss1 [7:0];
    ssdec a(.in(seq[31:28]), .enable(1'b1), .out(ss1[7]));
    ssdec b(.in(seq[27:24]), .enable(1'b1), .out(ss1[6]));
    ssdec c(.in(seq[23:20]), .enable(1'b1), .out(ss1[5]));
    ssdec d(.in(seq[19:16]), .enable(1'b1), .out(ss1[4]));
    ssdec e(.in(seq[15:12]), .enable(1'b1), .out(ss1[3]));
    ssdec f(.in(seq[11:8]), .enable(1'b1), .out(ss1[2]));
    ssdec g(.in(seq[7:4]), .enable(1'b1), .out(ss1[1]));
    ssdec h(.in(seq[3:0]), .enable(1'b1), .out(ss1[0]));
    
    

    always_comb begin
    
        case(state)
            4'd10: begin
              ss[63:56] = ss1[7];
              ss[55:48] = ss1[6];
              ss[47:40] = ss1[5];
              ss[39:32] = ss1[4];
              ss[31:24] = ss1[3];
              ss[23:16] = ss1[2]; 
              ss[15:8] = ss1[1];
              ss[7:0] = ss1[0];
              red = 1'b0; green = 1'b0; blue = 1'b0 ;
            end
            4'd0: begin
              ss[63:56] = 8'b10000000;
              ss[55:48] = 8'b10000000;
              ss[47:40] = 8'b10000000;
              ss[39:32] = 8'b10000000;
              ss[31:24] = 8'b10000000;
              ss[23:16] = 8'b10000000;
              ss[15:8] = 8'b10000000;
              ss[7:0] = 8'b10000000;
              red = 1'b0; green = 1'b0; blue = 1'b0 ;
            end
            4'd1: begin
              ss[63:56] = 8'b10000000;
              ss[55:48] = 8'b10000000;
              ss[47:40] = 8'b10000000;
              ss[39:32] = 8'b10000000;
              ss[31:24] = 8'b10000000;
              ss[23:16] = 8'b10000000;
              ss[15:8] = 8'b10000000;
              ss[7:0] = ss1[0];
              red = 1'b0; green = 1'b0; blue = 1'b0 ;
            end
            4'd2: begin
              ss[63:56] = 8'b10000000;
              ss[55:48] = 8'b10000000;
              ss[47:40] = 8'b10000000;
              ss[39:32] = 8'b10000000;
              ss[31:24] = 8'b10000000;
              ss[23:16] = 8'b10000000;
              ss[15:8] = ss1[1];
              ss[7:0] = ss1[0];
              red = 1'b0; green = 1'b0; blue = 1'b0 ;
            end
            4'd3: begin
              ss[63:56] = 8'b10000000;
              ss[55:48] = 8'b10000000;
              ss[47:40] = 8'b10000000;
              ss[39:32] = 8'b10000000;
              ss[31:24] = 8'b10000000;
              ss[23:16] = ss1[2];
              ss[15:8] = ss1[1];
              ss[7:0] = ss1[0];
              red = 1'b0; green = 1'b0; blue = 1'b0 ;
            end
            4'd4: begin
              ss[63:56] = 8'b10000000;
              ss[55:48] = 8'b10000000;
              ss[47:40] = 8'b10000000;
              ss[39:32] = 8'b10000000;
              ss[31:24] = ss1[3];
              ss[23:16] = ss1[2];
              ss[15:8] = ss1[1];
              ss[7:0] = ss1[0];
              red = 1'b0; green = 1'b0; blue = 1'b0 ;
            end
            4'd5: begin
              ss[63:56] = 8'b10000000;
              ss[55:48] = 8'b10000000;
              ss[47:40] = 8'b10000000;
              ss[39:32] = ss1[4];
              ss[31:24] = ss1[3];
              ss[23:16] = ss1[2];
              ss[15:8] = ss1[1];
              ss[7:0] = ss1[0];
              red = 1'b0; green = 1'b0; blue = 1'b0 ;
            end
            4'd6: begin
              ss[63:56] = 8'b10000000;
              ss[55:48] = 8'b10000000;
              ss[47:40] = ss1[5];
              ss[39:32] = ss1[4];
              ss[31:24] = ss1[3];
              ss[23:16] = ss1[2];
              ss[15:8] = ss1[1];
              ss[7:0] = ss1[0];
              red = 1'b0; green = 1'b0; blue = 1'b0 ;
            end
            // 4'd7: begin
            //   ss[63:56] = 8'b10000000;
            //   ss[55:48] = ss1[6];
            //   ss[47:40] = ss1[5];
            //   ss[39:32] = ss1[4];
            //   ss[31:24] = ss1[3];
            //   ss[23:16] = ss1[2];
            //   ss[15:8] = ss1[1];
            //   ss[7:0] = ss1[0];
            //   red = 1'b0; green = 1'b0; blue = 1'b0 ;
            //end
            4'd7: begin
              ss[63:56] = ss1[7];
              ss[55:48] = ss1[6];
              ss[47:40] = ss1[5];
              ss[39:32] = ss1[4];
              ss[31:24] = ss1[3];
              ss[23:16] = ss1[2];
              ss[15:8] = ss1[1];
              ss[7:0] = ss1[0];
              red = 1'b0; green = 1'b0; blue = 1'b0 ;
            end
// 911
            4'd9: begin  // State 9 - Show "911"
                ss[63:56] = 8'b00111001;
                ss[55:48] = 8'b01110111;
                ss[47:40] = 8'b00111000;
                ss[39:32] = 8'b00111000;
                ss[31:24] = 8'b00000000;
                ss[23:16] = 8'b01101111; 
                ss[15:8] = 8'b00000110;
                ss[7:0] = 8'b00000110;
                blue = 1'b1;
                red = '0;
                green = '0;
            end
//OPEN
            4'd8: begin  
                ss[63:56] = 8'b00000000;
                ss[55:48] = 8'b00000000;
                ss[47:40] = 8'b00000000;
                ss[39:32] = 8'b00000000;
                ss[31:24] = 8'b00111111;
                ss[23:16] = 8'b01110011;
                ss[15:8] = 8'b01111001;
                ss[7:0] = 8'b01010100;
                
                green = 1'b1;
                red = '0;
                blue = '0;
            end
            
            default: begin
              red = 1'b0; green = 1'b0; blue = 1'b0 ;
      
              ss[63:56] = 8'b00111111;
              ss[55:48] = 8'b00111111;
              ss[47:40] = 8'b00111111;
              ss[39:32] = 8'b00111111;
              ss[31:24] = 8'b00111111;
              ss[23:16] = 8'b00111111;
              ss[15:8] = 8'b00111111;
              ss[7 : 0] = 8'b00111111;
            end
        endcase
    end
endmodule
