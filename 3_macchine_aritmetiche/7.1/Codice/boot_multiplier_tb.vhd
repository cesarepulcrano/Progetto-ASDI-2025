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

entity boot_multiplier_tb is
    Generic(N: natural :=8);
--  Port ( );
end boot_multiplier_tb;

architecture Behavioral of boot_multiplier_tb is
    component booth_multiplier is
        Generic(N: natural :=8);
        Port (  CLK:    in  std_logic;
                RST:    in  std_logic;
                ENABLE: in  std_logic;
                X:      in  std_logic_vector(N-1 downto 0);
                Y:      in  std_logic_vector(N-1 downto 0);
                output: out std_logic_vector(2*N-1 downto 0) 
         );
    end component;
    
    signal clock: std_logic;
    signal rst:std_logic:='0';
    signal enable: std_logic:='0';
    signal x: std_logic_vector(N-1 downto 0):=(others=>'0');
    signal y: std_logic_vector(N-1 downto 0):=(others=>'0');         
    signal output: std_logic_vector(2*N-1 downto 0);
    signal CLOCK_PERIOD : time :=10 ns;
begin
    
    uut:booth_multiplier
        Generic Map(N=>N)
        Port Map(   CLK=>clock,
                    RST=>rst,
                    ENABLE=>enable,
                    X=>x,
                    Y=>y,
                    output=>output 
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
        x<="00000010";
        y<="00000010";
        enable<='1';
        wait for 1000 ns;
        enable<='0';
        rst<='0';
        wait;
    end process;
    
end Behavioral;
