 //32bits Q7.25定點數運算
module PE(activation_in, 
	weight_in, 
	partial_sum_in, 
	reg_activation, 
	reg_weight, 
	reg_partial_sum, 
	clk, 
	rst, 
	weight_en);

//===========================================
input signed[31:0]     activation_in, weight_in, partial_sum_in ;
input           clk, rst;
input           weight_en;
output signed[31:0]    reg_activation, reg_weight, reg_partial_sum;

reg signed[31:0] reg_activation, reg_weight, reg_partial_sum ;
wire signed[31:0]multi, adder;
wire signed[63:0]product;
//===========================================
always @(posedge clk or posedge rst) begin
    if(rst)
        reg_activation <= 32'd0;
    else
        reg_activation <= activation_in;    
end

always @(posedge clk or posedge rst) begin
    if(rst)
        reg_weight <= 32'd0;
    else if(weight_en)
        reg_weight <= weight_in;   
    else
        reg_weight <= reg_weight; 
end

always @(posedge clk or posedge rst) begin
    if(rst)
        reg_partial_sum <= 32'd0;
    else
        reg_partial_sum <= adder;    
end    

assign product = reg_activation*reg_weight;
assign adder = $signed(product[55:24]) + partial_sum_in;

endmodule