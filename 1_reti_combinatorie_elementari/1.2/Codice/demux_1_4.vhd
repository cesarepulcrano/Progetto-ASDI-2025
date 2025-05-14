----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2025 11:57:31 AM
-- Design Name: 
-- Module Name: demux_1_4 - Behavioral
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

entity demux_1_4 is
    port(   x   :   in  std_logic;
            s0  :   in  std_logic;
            s1  :   in  std_logic;
            y   :   out std_logic_vector (3 downto 0)
    );
end demux_1_4;

architecture Behavioral of demux_1_4 is
    
    begin
        process(x,s1,s0)
            begin 
            	y<="0000";
                if(s1='0' and s0 = '0') then
                    y(0)<=x;
                elsif(s1='0' and s0 = '1') then
                    y(1)<=x;
                elsif(s1='1' and s0 = '0') then
                    y(2)<=x;
                elsif(s1='1' and s0 = '1') then  
                    y(3)<=x;
--                else    
--                    y<="----";
                    
                end if;
    end process;
 end Behavioral;
