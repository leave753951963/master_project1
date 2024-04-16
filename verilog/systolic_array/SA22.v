`include "/home/wzc/verilog/systolic_array/PE.v"
module SA22(clk, rst, partial_sum_in11, partial_sum_in12, weight_in11, weight_in12, activation_in11, activation_in21, reg_partial_sum21, reg_partial_sum22, reg_weight21, reg_weight22, reg_activation12, reg_activation22, weight_en);

input  clk, rst;
input signed[15:0] partial_sum_in11, partial_sum_in12;
input signed[15:0] weight_in11, weight_in12;
input signed[15:0] activation_in11, activation_in21;
input signed weight_en;

output signed[15:0]reg_partial_sum21, reg_partial_sum22;
output signed[15:0]reg_weight21, reg_weight22;
output signed[15:0] reg_activation12, reg_activation22;

wire signed[15:0] reg_weight11, reg_weight12;
wire signed[15:0] reg_activation11, reg_activation21;
wire signed[15:0] reg_partial_sum11, reg_partial_sum12;

PE u11(.activation_in(activation_in11), .weight_in(weight_in11), .partial_sum_in(partial_sum_in11), .reg_activation(reg_activation11), .reg_weight(reg_weight11), .reg_partial_sum(reg_partial_sum11), .clk(clk), .rst(rst), .weight_en(weight_en));
PE u12(.activation_in(reg_activation11), .weight_in(weight_in12), .partial_sum_in(partial_sum_in12),.reg_activation(reg_activation12), .reg_weight(reg_weight12), .reg_partial_sum(reg_partial_sum12), .clk(clk), .rst(rst), .weight_en(weight_en));
PE U21(.activation_in(activation_in21), .weight_in(reg_weight11), .partial_sum_in(reg_partial_sum11), .reg_activation(reg_activation21), .reg_weight(reg_weight21), .reg_partial_sum(reg_partial_sum21), .clk(clk), .rst(rst), .weight_en(weight_en));
PE u22(.activation_in(reg_activation21), .weight_in(reg_weight12), .partial_sum_in(reg_partial_sum12), .reg_activation(reg_activation22), .reg_weight(reg_weight22), .reg_partial_sum(reg_partial_sum22), .clk(clk), .rst(rst), .weight_en(weight_en));

endmodule
