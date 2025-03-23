-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity net_16_4 is
  Port ( 
    input : in STD_LOGIC_VECTOR ( 15 downto 0 );
    input_control : in STD_LOGIC_VECTOR ( 3 downto 0 );
    output_control : in STD_LOGIC_VECTOR ( 1 downto 0 );
    output : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );

end net_16_4;

architecture stub of net_16_4 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
begin
end;
