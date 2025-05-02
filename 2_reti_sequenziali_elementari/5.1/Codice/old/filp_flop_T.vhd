----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2025 02:47:09 PM
-- Design Name: 
-- Module Name: filp_flop_jk - Behavioral
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

entity flip_flop_T is
    Port (  clock   :   in  std_logic;
            reset   :   in  std_logic;
            y   :   out std_logic
            
    );
end flip_flop_T;

architecture Behavioral of flip_flop_T is
    signal TY:  std_logic;
    
    begin
        
        process(clock,reset)
            begin
                if(reset='1')   then
                    TY<='0';
                elsif(clock'event AND clock='1') then
                    TY<=not TY;
                end if;    
                
        end process;
    y<=TY;
end Behavioral;
