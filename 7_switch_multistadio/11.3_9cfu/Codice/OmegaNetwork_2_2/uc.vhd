----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 04:29:16 PM
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

entity uc is
    Port (  
            r0       : in  std_logic;
            r1       : in  std_logic;
            r2       : in  std_logic;
            r3       : in  std_logic;
            dest0    : in std_logic_vector(1 downto 0);
            dest1    : in std_logic_vector(1 downto 0);
            dest2    : in std_logic_vector(1 downto 0);
            dest3    : in std_logic_vector(1 downto 0);
            source   : out std_logic_vector(1 downto 0);
            dest     : out std_logic_vector(1 downto 0)
     );
end uc;

    
architecture Behavioral of uc is
    signal source_temp: std_logic_vector(1 downto 0);
    signal dest_temp: std_logic_vector(1 downto 0);
begin
    
    process(r0,r1,r2,r3,dest0,dest1,dest2,dest3) 
    begin        
        if(r0='1') then
            source_temp<="00";
            dest_temp<=dest0;
        elsif(r1='1') then
            source_temp<="01";
            dest_temp<=dest1;
        elsif(r2='1') then
            source_temp<="10";
            dest_temp<=dest2;       
        elsif(r3='1') then
            source_temp<="11";
            dest_temp<=dest3;
        end if;    
    end process;
    
    source<=source_temp;
    dest<=dest_temp;

end Behavioral;
