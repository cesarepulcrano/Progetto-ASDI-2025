----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 01:04:11 PM
-- Design Name: 
-- Module Name: demux1_2 - Dataflow
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

entity demux1_2 is
    Port (
            x: in std_logic;
            s: in std_logic;
            y: out std_logic_vector(1 downto 0) 
            );
end demux1_2;

architecture Dataflow of demux1_2 is

begin
    
    y(0)<=x and not(s);
    y(1)<=x and s;

end Dataflow;
