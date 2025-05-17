----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 11:43:00 AM
-- Design Name: 
-- Module Name: M_register - Behavioral
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

entity reg is
    Generic(N: natural:=8);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           load : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR(N-1 downto 0);
           output : out STD_LOGIC_VECTOR(N-1 downto 0)
           );
end reg;

architecture Behavioral of reg is
    
    signal temp: std_logic_vector(N-1 downto 0):=(others=>'0');
    
begin
    
    process(CLK)
    begin
        if(rising_edge(CLK)) then
            if(RST='1') then
                temp<=(others=>'0');
            elsif(load='1') then
                temp<=input;
            end if;
        end if;
    end process;
    
    output<=temp;    
end Behavioral;
