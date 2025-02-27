
module div_ghi_gh(
    clk,rst,sub_state_r,
    sum_ghi,N,
    reg_div,out_div,
    reg_x,out_x,
    en
);

//==== I/O port ==========================
input   clk,rst;
input   [3:0]sub_state_r;
input   en;

input  [26:0] sum_ghi;      // 15bit int + 12bit frac 
input  [19:0] N;            // 8bit  int + 12bit frac

input      [26:0] reg_x;    // 1bit  int + (20+6)bit frac
output reg [46:0] out_x;    // 21bit int + 26bit frac //[73:0]
// output reg [73:0] out_x;    // 22bit int + 52bit frac
input       [8:0] reg_div;  // 8bit  int + 1bit frac
output reg [53:0] out_div;  // 16bit int + 38bit frac

reg  [5:0]  a_r;

wire init_1 ;
wire init_2 ;
wire init_3 ;
wire init_4 ;
wire init_5 ;
wire init_6 ;
wire init_7 ;
wire init_8 ;
wire init_9 ;
wire init_10;
wire init_11;
wire init_12;
wire init_13;
wire init_14;
wire init_15;
wire init_16;
wire init_17;
wire init_18;
wire init_19;

assign init_1  = (N>20'h2      )?1'b1:1'b0;
assign init_2  = (N>20'h4      )?1'b1:1'b0;
assign init_3  = (N>20'h8      )?1'b1:1'b0;
assign init_4  = (N>20'h10     )?1'b1:1'b0;
assign init_5  = (N>20'h20     )?1'b1:1'b0;
assign init_6  = (N>20'h40     )?1'b1:1'b0;
assign init_7  = (N>20'h80     )?1'b1:1'b0;
assign init_8  = (N>20'h100    )?1'b1:1'b0;
assign init_9  = (N>20'h200    )?1'b1:1'b0;
assign init_10 = (N>20'h400    )?1'b1:1'b0;
assign init_11 = (N>20'h800    )?1'b1:1'b0;
assign init_12 = (N>20'h1000   )?1'b1:1'b0;
assign init_13 = (N>20'h2000   )?1'b1:1'b0;
assign init_14 = (N>20'h4000   )?1'b1:1'b0;
assign init_15 = (N>20'h8000   )?1'b1:1'b0;
assign init_16 = (N>20'h1_0000 )?1'b1:1'b0;
assign init_17 = (N>20'h2_0000 )?1'b1:1'b0;
assign init_18 = (N>20'h4_0000 )?1'b1:1'b0;
assign init_19 = (N>20'h8_0000 )?1'b1:1'b0;

// wire a_1 ;
wire a_2 ;
wire a_3 ;
wire a_4 ;
wire a_5 ;
wire a_6 ;
wire a_7 ;
wire a_8 ;
wire a_9 ;
wire a_10;
wire a_11;
wire a_12;
wire a_13;
wire a_14;
wire a_15;
wire a_16;
wire a_17;
wire a_18;
wire a_19;

assign a_2  = (!init_2 && init_1 )?1'b1:1'b0;
assign a_3  = (!init_3 && init_2 )?1'b1:1'b0;
assign a_4  = (!init_4 && init_3 )?1'b1:1'b0;
assign a_5  = (!init_5 && init_4 )?1'b1:1'b0;
assign a_6  = (!init_6 && init_5 )?1'b1:1'b0;
assign a_7  = (!init_7 && init_6 )?1'b1:1'b0;
assign a_8  = (!init_8 && init_7 )?1'b1:1'b0;
assign a_9  = (!init_9 && init_8 )?1'b1:1'b0;
assign a_10 = (!init_10&& init_9 )?1'b1:1'b0;
assign a_11 = (!init_11&& init_10)?1'b1:1'b0;
assign a_12 = (!init_12&& init_11)?1'b1:1'b0;
assign a_13 = (!init_13&& init_12)?1'b1:1'b0;
assign a_14 = (!init_14&& init_13)?1'b1:1'b0;
assign a_15 = (!init_15&& init_14)?1'b1:1'b0;
assign a_16 = (!init_16&& init_15)?1'b1:1'b0;
assign a_17 = (!init_17&& init_16)?1'b1:1'b0;
assign a_18 = (!init_18&& init_17)?1'b1:1'b0;
assign a_19 = (!init_19&& init_18)?1'b1:1'b0;

reg [53:0] temp;


reg [46:0] NX_r;
reg [46:0] NX_w;
reg [73:0] temp_NX;

always @(*) begin
    if (en) begin

        out_x   = {21'b0,reg_x};
        // out_x   = {21'b0,reg_x,26'b0};
        out_div = {20'b0,reg_div,25'b0};
        
        case(sub_state_r)
        3:begin
            if(  {a_14,a_15,a_16,a_17,a_18,a_19} ==  a_r && a_r!=0)begin
                out_x   = {21'b0,reg_x};
                // out_x   = {21'b0,reg_x,26'b0};
            end
            else begin
                out_x = {21'b0,1'b0,a_2,a_3,a_4,a_5,a_6,a_7,a_8,a_9,a_10,a_11,a_12,a_13,a_14,a_15,a_16,a_17,a_18,a_19,7'b0};
                // out_x = {22'b0,1'b0,a_2,a_3,a_4,a_5,a_6,a_7,a_8,a_9,a_10,a_11,a_12,a_13,a_14,a_15,a_16,a_17,a_18,a_19,33'b0};
            end
            // 29bit int + 66bit frac
        end
        // 4,5,6,7,8,9:begin
        //     out_x = (47'h800_0000 - N * reg_x)*reg_x;
        // end
        4,6,8:begin
            NX_w = (47'h800_0000 - N * reg_x);
        end
        5,7,9:begin
            temp_NX = NX_r*reg_x;
            out_x   = temp_NX[72:26];
            // out_x = {21'b0,temp_NX[72:26],26'b0};
        end
        10:begin
            temp    = reg_x * sum_ghi;
            out_div = {temp[53:26] + temp[25],26'b0};
        end
        endcase 
        
    end
    else begin
        out_x   = {21'b0,reg_x};
        out_div = {20'b0,reg_div,25'b0};
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        a_r     <= 0;
        NX_r    <= 0;
    end
    else begin
        a_r     <= {a_14,a_15,a_16,a_17,a_18,a_19};
        NX_r    <= NX_w;
    end
end


endmodule