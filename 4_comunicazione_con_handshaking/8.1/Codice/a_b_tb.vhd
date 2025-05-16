----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 02:20:33 PM
-- Design Name: 
-- Module Name: a_b_tb - Behavioral
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

entity a_b_tb is
    Generic(N:natural:=8;
            M:natural:=8);
--  Port ( );
end a_b_tb;

architecture Behavioral of a_b_tb is

    component system is
        Generic(N:natural:=8;
                M:natural:=8);
        Port (  CLK: in std_logic;
                RST: in std_logic;
                START: in std_logic;
                data_out:   out std_logic_vector(M-1 downto 0) 
                );
    end component;
    
    signal clock: std_logic;
    signal rst: std_logic;
    signal start: std_logic;
    signal output: std_logic_vector(M-1 downto 0);
    signal period: time := 10 ns; 
    
begin
    
    uut: system
        Generic Map (   N=>N,
                        M=>M)
        Port Map(   CLK=>clock,
                    RST=>rst,
                    START=>start,
                    data_out=>output
                );
    
    clock_proc: process
        begin
            clock<='0';
            wait for period/2;
            clock<='1';
            wait for period/2;
        end process;
    
    stim:process
        begin
            start<='1';
            rst<='0';
            wait for 10 ns;
            start<='0';
            wait;
        end process;

end Behavioral;
