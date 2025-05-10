----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2025 11:52:56 AM
-- Design Name: 
-- Module Name: fgpa_tb - Behavioral
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

entity fgpa_tb is
--  Port ( );
end fgpa_tb;

architecture Behavioral of fgpa_tb is
    component  PO_PC_fpga is
        Port (  CLK100MHZ   : in std_logic;
                BTNL        : in std_logic;
                BTNR        : in std_logic;
                LED         : out std_logic_vector(3 downto 0)
            );
    end component;
    constant CLK_period : time := 10 ns;
    signal clock:std_logic;
    signal reset:std_logic;
    signal start:std_logic;
    signal led:std_logic_vector(3 downto 0);
begin
    uut:PO_PC_fpga 
        Port Map(  CLK100MHZ=>clock,
                BTNL=>reset,
                BTNR=>start,
                LED=>led
            );

   CLK_process :process
        begin
            clock <= '0';
            wait for CLK_period/2;
        
            clock <= '1';
            wait for CLK_period/2;
       
   end process;
   
   stim:process
    begin
        wait for 10 ns;
        start<='1';
        wait for 10000000 ns;
    end process;
end Behavioral;
