----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2025 06:25:20 PM
-- Design Name: 
-- Module Name: contatore_mod_N - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contatore_mod_N is
    Generic (N: integer := 60);
    Port (      clock   :   in  std_logic;
                reset   :   in  std_logic;
                set     :   in  std_logic;
                load    :   in  std_logic_vector(integer(ceil(log2(real(N))))-1 downto  0);
                cont    :   out  std_logic_vector(integer(ceil(log2(real(N))))-1    downto  0);
                co      :   out std_logic
    );
end contatore_mod_N;

architecture Behavioral of contatore_mod_N is
    signal temp: std_logic_vector(integer(ceil(log2(real(N))))-1 downto  0):=(others=>'0');
    signal co_temp: std_logic:='0';
begin
    
    count:process(clock,reset,set,load)
        begin
              co_temp<='0';  
              if(reset='1') then
                temp<=(others=>'0');
              elsif(set='1') then
                if(load>=std_logic_vector(to_unsigned(N-1,integer(ceil(log2(real(N)))))) ) then
                    temp<=std_logic_vector(to_unsigned(N-1,integer(ceil(log2(real(N))))) );
                    co_temp<='1';
                else 
                    temp<=load;
                end if;      
              elsif(falling_edge(clock))then  
                if(std_logic_vector(unsigned(temp) + 1) = std_logic_vector(to_unsigned(N-1,integer(ceil(log2(real(N)))))) ) then
                    temp <= std_logic_vector(unsigned(temp) + 1);
                    co_temp<='1';   
                elsif(temp = std_logic_vector(to_unsigned(N-1,integer(ceil(log2(real(N)))))) ) then
                    temp<=(others=>'0');
                    --co_temp<='0';
                else    
                    temp <= std_logic_vector(unsigned(temp) + 1);
                end if;
            end if;
        end process;
        
        cont<=temp;
        co<=co_temp;
        
end Behavioral;
