----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/01/2025 02:08:45 PM
-- Design Name: 
-- Module Name: switch_caputure - Behavioral
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

entity switch_capture is
    Port (  clock   :   in std_logic;
            button  :   in  std_logic;
            input : in std_logic;
            output  :   out std_logic
    );
end switch_capture;

architecture Behavioral of switch_capture is

begin

    capture: process(clock)
        begin
            
            if(rising_edge(clock))  then
                if(button='1')      then
                
                    output<=input;
               end if;
            end if;     
    end process;
end Behavioral;
