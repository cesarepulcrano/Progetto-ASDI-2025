// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module net_16_4(\input , input_control, output_control, 
  \output );
  input [15:0]\input ;
  input [3:0]input_control;
  input [1:0]output_control;
  output [3:0]\output ;
endmodule
