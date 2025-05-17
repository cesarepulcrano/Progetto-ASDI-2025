----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 01:50:45 PM
-- Design Name: 
-- Module Name: uc - Behavioral
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

entity selettore is
    Port (
            clk: in std_logic; 
            rst: in std_logic;
            req: in std_logic_vector(3 downto 0); 
            selezione: out std_logic_vector(1 downto 0) 
            );
end selettore;


    
architecture Behavioral of selettore is
    signal temp: std_logic_vector(1 downto 0) ;
begin
    
    process (req)
    begin
        
        if(req(0)='1') then
            temp<="00";
        elsif(req(1)='1') then
            temp<="01";
        elsif(req(2)='1') then
            temp<="10";
        elsif(req(3)='1') then
            temp<="11";
        end if;
        
    end process;
    selezione<=temp;
end Behavioral;
