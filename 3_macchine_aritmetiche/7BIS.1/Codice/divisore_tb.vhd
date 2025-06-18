----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 01:57:23 PM
-- Design Name: 
-- Module Name: boot_multiplier_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divisore_tb is
    Generic(N: natural :=4);
--  Port ( );
end divisore_tb;

architecture Behavioral of divisore_tb is
    component divisore is
        Generic     (   N           :   natural :=4); 
    Port        (   clk         :   in      std_logic;
                    rst         :   in      std_logic;
                    start       :   in      std_logic;
                    D           :   in      std_logic_vector(   N-1 downto  0   );
                    V           :   in      std_logic_vector(   N-1 downto  0   );
                    risultato   :   out     std_logic_vector(   N-1 downto  0   );
                    resto       :   out     std_logic_vector(   N-1 downto  0   )
                 );
    end component;
    
    signal clock: std_logic;
    signal rst:std_logic:='0';
    signal enable: std_logic:='0';
    signal x: std_logic_vector(N-1 downto 0):=(others=>'0');
    signal y: std_logic_vector(N-1 downto 0):=(others=>'0');         
    signal output: std_logic_vector(N-1 downto 0);
    signal routput: std_logic_vector(N-1 downto 0);
    signal CLOCK_PERIOD : time :=10 ns;
begin
    
    uut:divisore
        Generic Map(N=>N)
        Port Map(   CLK=>clock,
                    RST=>rst,
                    start=>enable,
                    D=>x,
                    V=>y,
                    risultato=>output,
                    resto=>routput 
         );
    
    cwave:process
    begin
        clock<='0';
        wait for CLOCK_PERIOD/2;
        clock<='1';
        wait for CLOCK_PERIOD/2;
    end process;
    
    stim:process
    begin
        rst<='0';
        wait for 10 ns;
        rst<='0';
        x<="1100";
        y<="0010";
        enable<='1';
        wait for 100 ns;
        
        enable<='0';
        wait;
    end process;
    
end Behavioral;