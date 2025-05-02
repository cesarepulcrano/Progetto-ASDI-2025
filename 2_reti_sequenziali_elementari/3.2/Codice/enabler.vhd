----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2025 12:50:54 PM
-- Design Name: 
-- Module Name: enabler - Behavioral
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

entity enabler is
    Port (  clock : in std_logic;
            input: in std_logic;
            mode: in std_logic;
            enable  :   in std_logic;
            output  :   out std_logic
    
     );
end enabler;

architecture Behavioral of enabler is
    
    
    
begin
    
    process(clock,enable)
        begin
            if(rising_edge(clock)) then
                if (enable='1') then
                    output<=enable;
                    
                end if;
            end if;
            
        end process;
        

end Behavioral;
