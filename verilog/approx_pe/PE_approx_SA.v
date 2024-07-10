`timescale 1ns/10ps
//approx. PE for systolic array
module PE_approx_SA		(
							clk,
							rst,
							activation_in,
							weight_in,
							partial_sum_in,
							reg_partial_sum,
							reg_activation,
							reg_weight,
							weight_en
									);
							
input clk,rst;
input weight_en;
input signed [15:0] 	activation_in;
input signed [15:0] 	weight_in;
input signed [15:0] 	partial_sum_in;
output  signed [15:0]	reg_partial_sum,reg_weight,reg_activation;
wire signed [15:0]	n_psum_reg;

reg signed[15:0] reg_partial_sum,reg_weight,reg_activation;
wire signed[15:0] n_approx_ofmap;


wire [15:0] n_exact_ofmap;
wire detect_error;
wire  signed[15:0] approx_P;


//////////////////////////////////////////////////////////////////
/////////////////// arrporx //////////////////////////////////////
//////////////////////////////////////////////////////////////////

always @(posedge clk or posedge rst) begin
    if(rst)
        reg_activation <= 16'd0;
    else
        reg_activation <= activation_in;    
end

always @(posedge clk or posedge rst) begin
    if(rst)
        reg_weight <= 16'd0;
    else if(weight_en)
        reg_weight <= weight_in;   
    else
        reg_weight <= reg_weight; 
end

wire [17:0] reg_activation_append ;
wire [17:0] weight_append ;
wire [5:0] approx_temp_P;
wire sign_temp;
wire [15:0] two_reg_activation;
wire [15:0] two_weight;
wire [2:0] approx_reg_activation_value;
wire [2:0] approx_weight_value;
wire [3:0] approx_reg_activation_idx;

wire [3:0] approx_weight_idx;
wire zero_check;
find_ones find_ones123(.x(two_reg_activation),.y(approx_reg_activation_idx));
find_ones find_ones1(.x(two_weight),.y(approx_weight_idx));
assign two_reg_activation = (reg_activation[15])? (~reg_activation[15:0]+1) : reg_activation ;
assign two_weight = (reg_weight[15])? ~(reg_weight[15:0])+1 : reg_weight ;

assign reg_activation_append = {two_reg_activation,2'd0} ;
assign weight_append = {two_weight,2'd0} ;

cut cut0(.append(reg_activation_append),.idx(approx_reg_activation_idx),.value(approx_reg_activation_value));
cut cut1(.append(weight_append),.idx(approx_weight_idx),.value(approx_weight_value));

wire [3:0] shift_idx;


wire [17:0]s_approx_temp_P;
wire  [14:0] approx_temp;




assign approx_temp_P = approx_reg_activation_value*approx_weight_value;

assign zero_check = (|reg_activation) && (|reg_weight);
assign shift_idx = ((approx_reg_activation_idx + approx_weight_idx)>='d10 ) && (zero_check)?  
					(approx_reg_activation_idx + approx_weight_idx)- 'd10 : 'd15;

assign sign_temp = reg_activation[15] ^ reg_weight[15];
decoder decoder0(	.leading_value(approx_temp_P[5:2]),
					.shift_idx(shift_idx),
					.value(approx_temp)) ;

assign approx_P = (sign_temp)? {1'b1,~approx_temp} : {1'b0,approx_temp} ;


assign n_approx_ofmap = $signed(approx_P) + $signed(partial_sum_in);

always@(posedge clk or posedge rst)
begin
	if(rst)
		begin
		reg_partial_sum <= 'd0;
		end
	else 
		begin 
		reg_partial_sum <= n_approx_ofmap;
		end
end
endmodule

////////////////////////////////////////////////////////////
////////////////////////// find_one ////////////////////////
////////////////////////////////////////////////////////////

module find_ones(
					input [15:0] x,
					output [3:0] y
									);

wire [7:0]temp_16;
wire [3:0]temp_4;
wire [1:0]temp_2;


assign y[3] = | x[15:8];
assign temp_16 = (y[3])?  x[15:8] : x[7:0];
assign y[2] = | temp_16[7:4] ;
assign temp_4 = (y[2])? temp_16[7:4] :temp_16[3:0];
assign y[1] = | temp_4[3:2];
assign temp_2 = y[1] ? temp_4[3:2] : temp_4[1:0];
assign y[0] = temp_2[1];
endmodule
//////////////////////////////////////////
module cut(
				input [17:0] append,
				input [3:0] idx,
				output [2:0]value
						);
						
assign value = append[idx+:3];

endmodule
//////////////////////////////////////////

module decoder (
				
				input [3:0]shift_idx ,
				input [3:0]leading_value ,
				output reg[14:0]value
										);

always@(*)
case(shift_idx)   // ,{1{1'b0}}
	'd0: value = {{13{1'b0}},leading_value[3:2]};
	'd1: value = {{12{1'b0}},leading_value[3:1]};
	'd2: value = {{11{1'b0}},leading_value[3:0]};
	'd3: value = {{10{1'b0}},leading_value[3:0],{1{1'b1}}};
	'd4: value = {{9{1'b0}},leading_value[3:0],{2{1'b1}}};
	'd5: value = {{8{1'b0}},leading_value[3:0],{3{1'b1}}};
	'd6: value = {{7{1'b0}},leading_value[3:0],{4{1'b1}}};
	'd7: value = {{6{1'b0}},leading_value[3:0],{5{1'b1}}};
	'd8: value = {{5{1'b0}},leading_value[3:0],{6{1'b1}}};
	'd9: value = {{4{1'b0}},leading_value[3:0],{7{1'b1}}};
	'd10: value = {{3{1'b0}},leading_value[3:0],{8{1'b1}}};
	'd11: value = {{2{1'b0}},leading_value[3:0],{9{1'b1}}};
	'd12: value = {{1{1'b0}},leading_value[3:0],{10{1'b1}}};
	'd13: value = {leading_value[3:0],{11{1'b1}}};
	'd14: value = {leading_value[2:0],{12{1'b1}}};
	'd15: value = 15'b000_0000_0000_0000;  
	default : value = 15'b000_0000_0000_0000;
	
endcase 

endmodule