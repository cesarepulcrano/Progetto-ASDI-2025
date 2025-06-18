----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/15/2025 04:23:48 PM
-- Design Name: 
-- Module Name: divisore_fpga_tb - Behavioral
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

entity divisore_fpga_tb is
--  Port ( );
end divisore_fpga_tb;

architecture Behavioral of divisore_fpga_tb is
    component divisore_fpga is
        Port (  CLK100MHZ   :   in std_logic;
                BTNL        :   in std_logic;
                BTNR        :   in std_logic;
                AN          :   out std_logic_vector(7 downto 0);
                CA          :   out std_logic_vector(7 downto 0);
                SW          :   in std_logic_vector(7 downto 0);
                LED         :   out std_logic_vector(15 downto 0)
                
                --risultato   :   std_logic_vector(3 downto 0);
                --resto       :   std_logic_vector(3 downto 0)
                 );
    end component;
    
    signal D : std_logic_vector(3 downto 0);
    signal V : std_logic_vector(3 downto 0);
    signal clock: std_logic;
    signal period : time :=10 ns;
    signal rst : std_logic;    
    signal start : std_logic;
    signal output: std_logic_vector(15 downto 0);  
    signal dv: std_logic_vector(7 downto 0);  
    signal ans: std_logic_vector(7 downto 0);  
    signal cas: std_logic_vector(7 downto 0);  
begin
    clock_proc: process
    begin
        clock<='0';
        wait for period/2;
        clock<='1';
        wait for period/2;
    end process;
    dv<=D&V;
    uut:divisore_fpga 
        Port Map(  CLK100MHZ   =>clock,
                BTNL        =>rst,
                BTNR        =>start,
                AN          =>ans,
                CA          =>cas,
                SW          =>dv,
                LED         =>output
                
                --risultato   :   std_logic_vector(3 downto 0);
                --resto       :   std_logic_vector(3 downto 0)
                 );
    
    stim:process 
    begin
        wait for 10 ns;
        D<="0001";
        V<="0001";
        start<='1';
        wait for 10 ns;
        start<='0';
        wait;
    end process;             
end Behavioral;
