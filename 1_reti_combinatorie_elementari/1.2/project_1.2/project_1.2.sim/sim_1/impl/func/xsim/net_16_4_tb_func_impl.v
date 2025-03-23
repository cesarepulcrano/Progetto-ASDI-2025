// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
// Date        : Thu Mar 20 13:54:23 2025
// Host        : cesare-desktop running 64-bit Ubuntu 24.04.2 LTS
// Command     : write_verilog -mode funcsim -nolib -force -file
//               /home/cesare/ASDI/1/1.2/project_1.2/project_1.2.sim/sim_1/impl/func/xsim/net_16_4_tb_func_impl.v
// Design      : net_16_4
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module demux_1_4
   (y,
    output_control_IBUF,
    input_control_IBUF,
    \y_reg[3]_i_4_0 ,
    \y_reg[3]_i_4_1 ,
    \y_reg[3]_i_4_2 ,
    \y_reg[3]_i_4_3 ,
    \y_reg[3]_i_4_4 ,
    \y_reg[3]_i_4_5 ,
    \y_reg[3]_i_4_6 ,
    \y_reg[3]_i_4_7 ,
    \y_reg[3]_i_3_0 ,
    \y_reg[3]_i_3_1 ,
    \y_reg[3]_i_3_2 ,
    \y_reg[3]_i_3_3 ,
    \y_reg[3]_i_3_4 ,
    \y_reg[3]_i_3_5 );
  output [3:0]y;
  input [1:0]output_control_IBUF;
  input [3:0]input_control_IBUF;
  input \y_reg[3]_i_4_0 ;
  input \y_reg[3]_i_4_1 ;
  input \y_reg[3]_i_4_2 ;
  input \y_reg[3]_i_4_3 ;
  input \y_reg[3]_i_4_4 ;
  input \y_reg[3]_i_4_5 ;
  input \y_reg[3]_i_4_6 ;
  input \y_reg[3]_i_4_7 ;
  input \y_reg[3]_i_3_0 ;
  input \y_reg[3]_i_3_1 ;
  input \y_reg[3]_i_3_2 ;
  input \y_reg[3]_i_3_3 ;
  input \y_reg[3]_i_3_4 ;
  input \y_reg[3]_i_3_5 ;

  wire [3:0]input_control_IBUF;
  wire [1:0]output_control_IBUF;
  wire [3:0]y;
  wire y0;
  wire \y_reg[0]_i_1_n_0 ;
  wire \y_reg[1]_i_1_n_0 ;
  wire \y_reg[2]_i_1_n_0 ;
  wire \y_reg[3]_i_2_n_0 ;
  wire \y_reg[3]_i_3_0 ;
  wire \y_reg[3]_i_3_1 ;
  wire \y_reg[3]_i_3_2 ;
  wire \y_reg[3]_i_3_3 ;
  wire \y_reg[3]_i_3_4 ;
  wire \y_reg[3]_i_3_5 ;
  wire \y_reg[3]_i_3_n_0 ;
  wire \y_reg[3]_i_4_0 ;
  wire \y_reg[3]_i_4_1 ;
  wire \y_reg[3]_i_4_2 ;
  wire \y_reg[3]_i_4_3 ;
  wire \y_reg[3]_i_4_4 ;
  wire \y_reg[3]_i_4_5 ;
  wire \y_reg[3]_i_4_6 ;
  wire \y_reg[3]_i_4_7 ;
  wire \y_reg[3]_i_4_n_0 ;
  wire \y_reg[3]_i_5_n_0 ;
  wire \y_reg[3]_i_6_n_0 ;
  wire \y_reg[3]_i_7_n_0 ;
  wire \y_reg[3]_i_8_n_0 ;

  (* XILINX_LEGACY_PRIM = "LD" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE GND:CLR" *) 
  LDCE #(
    .INIT(1'b0)) 
    \y_reg[0] 
       (.CLR(1'b0),
        .D(y0),
        .G(\y_reg[0]_i_1_n_0 ),
        .GE(1'b1),
        .Q(y[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \y_reg[0]_i_1 
       (.I0(output_control_IBUF[1]),
        .I1(output_control_IBUF[0]),
        .O(\y_reg[0]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE GND:CLR" *) 
  LDCE #(
    .INIT(1'b0)) 
    \y_reg[1] 
       (.CLR(1'b0),
        .D(y0),
        .G(\y_reg[1]_i_1_n_0 ),
        .GE(1'b1),
        .Q(y[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \y_reg[1]_i_1 
       (.I0(output_control_IBUF[0]),
        .I1(output_control_IBUF[1]),
        .O(\y_reg[1]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE GND:CLR" *) 
  LDCE #(
    .INIT(1'b0)) 
    \y_reg[2] 
       (.CLR(1'b0),
        .D(y0),
        .G(\y_reg[2]_i_1_n_0 ),
        .GE(1'b1),
        .Q(y[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \y_reg[2]_i_1 
       (.I0(output_control_IBUF[1]),
        .I1(output_control_IBUF[0]),
        .O(\y_reg[2]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE GND:CLR" *) 
  LDCE #(
    .INIT(1'b0)) 
    \y_reg[3] 
       (.CLR(1'b0),
        .D(y0),
        .G(\y_reg[3]_i_2_n_0 ),
        .GE(1'b1),
        .Q(y[3]));
  MUXF8 \y_reg[3]_i_1 
       (.I0(\y_reg[3]_i_3_n_0 ),
        .I1(\y_reg[3]_i_4_n_0 ),
        .O(y0),
        .S(input_control_IBUF[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \y_reg[3]_i_2 
       (.I0(output_control_IBUF[1]),
        .I1(output_control_IBUF[0]),
        .O(\y_reg[3]_i_2_n_0 ));
  MUXF7 \y_reg[3]_i_3 
       (.I0(\y_reg[3]_i_5_n_0 ),
        .I1(\y_reg[3]_i_6_n_0 ),
        .O(\y_reg[3]_i_3_n_0 ),
        .S(input_control_IBUF[2]));
  MUXF7 \y_reg[3]_i_4 
       (.I0(\y_reg[3]_i_7_n_0 ),
        .I1(\y_reg[3]_i_8_n_0 ),
        .O(\y_reg[3]_i_4_n_0 ),
        .S(input_control_IBUF[2]));
  LUT3 #(
    .INIT(8'hB8)) 
    \y_reg[3]_i_5 
       (.I0(\y_reg[3]_i_3_4 ),
        .I1(input_control_IBUF[0]),
        .I2(\y_reg[3]_i_3_5 ),
        .O(\y_reg[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \y_reg[3]_i_6 
       (.I0(\y_reg[3]_i_3_0 ),
        .I1(\y_reg[3]_i_3_1 ),
        .I2(input_control_IBUF[1]),
        .I3(\y_reg[3]_i_3_2 ),
        .I4(input_control_IBUF[0]),
        .I5(\y_reg[3]_i_3_3 ),
        .O(\y_reg[3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \y_reg[3]_i_7 
       (.I0(\y_reg[3]_i_4_4 ),
        .I1(\y_reg[3]_i_4_5 ),
        .I2(input_control_IBUF[1]),
        .I3(\y_reg[3]_i_4_6 ),
        .I4(input_control_IBUF[0]),
        .I5(\y_reg[3]_i_4_7 ),
        .O(\y_reg[3]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \y_reg[3]_i_8 
       (.I0(\y_reg[3]_i_4_0 ),
        .I1(\y_reg[3]_i_4_1 ),
        .I2(input_control_IBUF[1]),
        .I3(\y_reg[3]_i_4_2 ),
        .I4(input_control_IBUF[0]),
        .I5(\y_reg[3]_i_4_3 ),
        .O(\y_reg[3]_i_8_n_0 ));
endmodule

(* ECO_CHECKSUM = "d8cbbc3c" *) 
(* NotValidForBitStream *)
(* \DesignAttr:ENABLE_NOC_NETLIST_VIEW  *) 
(* \DesignAttr:ENABLE_AIE_NETLIST_VIEW  *) 
module net_16_4
   (\input ,
    input_control,
    output_control,
    \output );
  input [15:0]\input ;
  input [3:0]input_control;
  input [1:0]output_control;
  output [3:0]\output ;

  wire [15:0]\input ;
  wire [3:0]input_control;
  wire [3:0]input_control_IBUF;
  wire [3:0]\output ;
  wire [3:0]output_OBUF;
  wire [1:0]output_control;
  wire [1:0]output_control_IBUF;
  wire \y_reg[3]_i_10_n_0 ;
  wire \y_reg[3]_i_11_n_0 ;
  wire \y_reg[3]_i_12_n_0 ;
  wire \y_reg[3]_i_13_n_0 ;
  wire \y_reg[3]_i_14_n_0 ;
  wire \y_reg[3]_i_15_n_0 ;
  wire \y_reg[3]_i_16_n_0 ;
  wire \y_reg[3]_i_17_n_0 ;
  wire \y_reg[3]_i_18_n_0 ;
  wire \y_reg[3]_i_19_n_0 ;
  wire \y_reg[3]_i_20_n_0 ;
  wire \y_reg[3]_i_21_n_0 ;
  wire \y_reg[3]_i_22_n_0 ;
  wire \y_reg[3]_i_9_n_0 ;

  demux_1_4 demux0
       (.input_control_IBUF(input_control_IBUF),
        .output_control_IBUF(output_control_IBUF),
        .y(output_OBUF),
        .\y_reg[3]_i_3_0 (\y_reg[3]_i_11_n_0 ),
        .\y_reg[3]_i_3_1 (\y_reg[3]_i_12_n_0 ),
        .\y_reg[3]_i_3_2 (\y_reg[3]_i_13_n_0 ),
        .\y_reg[3]_i_3_3 (\y_reg[3]_i_14_n_0 ),
        .\y_reg[3]_i_3_4 (\y_reg[3]_i_9_n_0 ),
        .\y_reg[3]_i_3_5 (\y_reg[3]_i_10_n_0 ),
        .\y_reg[3]_i_4_0 (\y_reg[3]_i_19_n_0 ),
        .\y_reg[3]_i_4_1 (\y_reg[3]_i_20_n_0 ),
        .\y_reg[3]_i_4_2 (\y_reg[3]_i_21_n_0 ),
        .\y_reg[3]_i_4_3 (\y_reg[3]_i_22_n_0 ),
        .\y_reg[3]_i_4_4 (\y_reg[3]_i_15_n_0 ),
        .\y_reg[3]_i_4_5 (\y_reg[3]_i_16_n_0 ),
        .\y_reg[3]_i_4_6 (\y_reg[3]_i_17_n_0 ),
        .\y_reg[3]_i_4_7 (\y_reg[3]_i_18_n_0 ));
  IBUF \input_control_IBUF[0]_inst 
       (.I(input_control[0]),
        .O(input_control_IBUF[0]));
  IBUF \input_control_IBUF[1]_inst 
       (.I(input_control[1]),
        .O(input_control_IBUF[1]));
  IBUF \input_control_IBUF[2]_inst 
       (.I(input_control[2]),
        .O(input_control_IBUF[2]));
  IBUF \input_control_IBUF[3]_inst 
       (.I(input_control[3]),
        .O(input_control_IBUF[3]));
  OBUF \output[0]_INST_0 
       (.I(output_OBUF[0]),
        .O(\output [0]));
  OBUF \output[1]_INST_0 
       (.I(output_OBUF[1]),
        .O(\output [1]));
  OBUF \output[2]_INST_0 
       (.I(output_OBUF[2]),
        .O(\output [2]));
  OBUF \output[3]_INST_0 
       (.I(output_OBUF[3]),
        .O(\output [3]));
  IBUF \output_control_IBUF[0]_inst 
       (.I(output_control[0]),
        .O(output_control_IBUF[0]));
  IBUF \output_control_IBUF[1]_inst 
       (.I(output_control[1]),
        .O(output_control_IBUF[1]));
  IBUF \y_reg[3]_i_10 
       (.I(\input [0]),
        .O(\y_reg[3]_i_10_n_0 ));
  IBUF \y_reg[3]_i_11 
       (.I(\input [7]),
        .O(\y_reg[3]_i_11_n_0 ));
  IBUF \y_reg[3]_i_12 
       (.I(\input [6]),
        .O(\y_reg[3]_i_12_n_0 ));
  IBUF \y_reg[3]_i_13 
       (.I(\input [5]),
        .O(\y_reg[3]_i_13_n_0 ));
  IBUF \y_reg[3]_i_14 
       (.I(\input [4]),
        .O(\y_reg[3]_i_14_n_0 ));
  IBUF \y_reg[3]_i_15 
       (.I(\input [11]),
        .O(\y_reg[3]_i_15_n_0 ));
  IBUF \y_reg[3]_i_16 
       (.I(\input [10]),
        .O(\y_reg[3]_i_16_n_0 ));
  IBUF \y_reg[3]_i_17 
       (.I(\input [9]),
        .O(\y_reg[3]_i_17_n_0 ));
  IBUF \y_reg[3]_i_18 
       (.I(\input [8]),
        .O(\y_reg[3]_i_18_n_0 ));
  IBUF \y_reg[3]_i_19 
       (.I(\input [15]),
        .O(\y_reg[3]_i_19_n_0 ));
  IBUF \y_reg[3]_i_20 
       (.I(\input [14]),
        .O(\y_reg[3]_i_20_n_0 ));
  IBUF \y_reg[3]_i_21 
       (.I(\input [13]),
        .O(\y_reg[3]_i_21_n_0 ));
  IBUF \y_reg[3]_i_22 
       (.I(\input [12]),
        .O(\y_reg[3]_i_22_n_0 ));
  IBUF \y_reg[3]_i_9 
       (.I(\input [3]),
        .O(\y_reg[3]_i_9_n_0 ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
