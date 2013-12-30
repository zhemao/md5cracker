//lpm_mult CBX_SINGLE_OUTPUT_FILE="ON" LPM_HINT="MAXIMIZE_SPEED=5" LPM_REPRESENTATION="UNSIGNED" LPM_TYPE="LPM_MULT" LPM_WIDTHA=4 LPM_WIDTHB=3 LPM_WIDTHP=7 LPM_WIDTHS=1 dataa datab result
//VERSION_BEGIN 13.1 cbx_mgl 2013:10:17:04:34:36:SJ cbx_stratixii 2013:10:17:04:07:49:SJ cbx_util_mgl 2013:10:17:04:07:49:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 1991-2013 Altera Corporation
//  Your use of Altera Corporation's design tools, logic functions 
//  and other software and tools, and its AMPP partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Altera Program License 
//  Subscription Agreement, Altera MegaCore Function License 
//  Agreement, or other applicable license agreement, including, 
//  without limitation, that your use is for the sole purpose of 
//  programming logic devices manufactured by Altera and sold by 
//  Altera or its authorized distributors.  Please refer to the 
//  applicable agreement for further details.



//synthesis_resources = lpm_mult 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mg4bh
	( 
	dataa,
	datab,
	result) /* synthesis synthesis_clearbox=1 */;
	input   [3:0]  dataa;
	input   [2:0]  datab;
	output   [6:0]  result;

	wire  [6:0]   wire_mgl_prim1_result;

	lpm_mult   mgl_prim1
	( 
	.dataa(dataa),
	.datab(datab),
	.result(wire_mgl_prim1_result));
	defparam
		mgl_prim1.lpm_representation = "UNSIGNED",
		mgl_prim1.lpm_type = "LPM_MULT",
		mgl_prim1.lpm_widtha = 4,
		mgl_prim1.lpm_widthb = 3,
		mgl_prim1.lpm_widthp = 7,
		mgl_prim1.lpm_widths = 1,
		mgl_prim1.lpm_hint = "MAXIMIZE_SPEED=5";
	assign
		result = wire_mgl_prim1_result;
endmodule //mg4bh
//VALID FILE
