----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 03:25:44 PM
-- Design Name: 
-- Module Name: uart_tb - Behavioral
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

entity uart_tb is
    Generic (   N   :   natural :=8;
                M   :   natural := 8);
--  Port ( );
end uart_tb;

architecture Behavioral of uart_tb is
    component a_b_system is
        Generic (   N   :   natural :=8;
                    M   :   natural := 8);
        Port (
                clk: in std_logic; 
                rst: in std_logic;
                start: in std_logic;
                output: out std_logic_vector (M-1 downto 0)
                 );
    end component;
    
    signal clock: std_logic;
    signal period:time := 10 ns; 
    signal rst: std_logic;
    signal start: std_logic;
    signal output: std_logic_vector(M-1 downto 0);
    
begin
    
    uut:a_b_system
        Port Map(
                clk=>clock, 
                rst=>rst,
                start=>start,
                output=>output);
     
     clock_process: process
     begin
         clock<='0';
         wait for period/2;
         clock<='1';
         wait for period/2;
     end process;           
    
    
     stim: process
     begin
         wait for period;
         --rst<='1';
         wait for period;
         rst<='0';
         start<='1';
--         wait for period;
--         start<='0';
         wait;
     end process; 
end Behavioral;
