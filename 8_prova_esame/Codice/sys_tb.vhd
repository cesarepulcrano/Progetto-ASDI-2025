----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 07:20:59 PM
-- Design Name: 
-- Module Name: sys_tb - Behavioral
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

entity sys_tb is
--  Port ( );
end sys_tb;

architecture Behavioral of sys_tb is
    
    component system is
        Port (  
                clk: in std_logic;
                rst: in std_logic;
                start: in std_logic;
                output: out std_logic_vector(3 downto 0)
         );
    end component;
    
    signal clock :std_logic;
    signal rst   :std_logic;
    signal start :std_logic;
    signal output:std_logic_vector(3 downto 0);
    signal period: time:= 10 ns;
begin
    
    uut: system 
        Port Map(  
                clk   =>clock,
                rst   =>rst,
                start =>start,
                output=>output
         );

    
    cl:process
    begin
        clock<='0';
        wait for period/2;
        clock<='1';
        wait for period/2;
    end process;
    
    stim:process
    begin
        wait for period;
        start<='1';
        wait for period;
        start<='0';
        wait for 60*period;
        rst<='1';
        wait;
    end process;
end Behavioral;
