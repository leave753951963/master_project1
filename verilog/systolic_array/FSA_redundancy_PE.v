module FSA_redundancy_PE(begin_repair,cs,activation_in, weight_in, partial_sum_in,  partial_sum_out, clk, rst, weight_en);
input[1:0]      cs;//mux statement
input[15:0]     activation_in, weight_in, partial_sum_in ;
input           clk, rst;
input           weight_en;
output reg[15:0]    partial_sum_out;

reg[15:0] reg_partial_sum ;
wire[15:0]multi, adder; 
reg[15:0]n_reg_partial_sum;



always @(posedge clk or posedge rst) begin
    if(rst)
        reg_partial_sum <= 16'd0;
    else
        reg_partial_sum <= n_reg_partial_sum;    
end    

always@(*)begin
case(cs)
    2'b00:n_reg_partial_sum = adder;//cycle1
    2'b01:n_reg_partial_sum = adder;//cycle N
    2'b10:n_reg_partial_sum = reg_partial_sum;//cycle 2N
    default:n_reg_partial_sum = reg_partial_sum;
endcase
end
always@(*)begin
case(cs)
    2'b00:partial_sum_out = n_reg_partial_sum;//cycle1
    2'b01:partial_sum_out = reg_partial_sum;//cycle N
    2'b10:partial_sum_out = reg_partial_sum;//cycle 2N
    default:partial_sum_out = 16'd0;
endcase
end
assign multi = activation_in*weight_in;
assign adder = multi + partial_sum_in;





endmodule