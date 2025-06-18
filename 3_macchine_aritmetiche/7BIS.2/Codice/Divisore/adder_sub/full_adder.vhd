----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 12:33:38 PM
-- Design Name: 
-- Module Name: full_adder - Dataflow
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_adder is
    Port (  a:in std_logic;
            b:in std_logic;
            c_in:in std_logic;
            s:out std_logic;
            c_out:out std_logic
            );
end full_adder;

architecture Dataflow of full_adder is

begin
    
    s<=((a xor b) xor c_in);
    c_out<=( (a and b) or (c_in and (a xor b)) );

end Dataflow;
