----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2025 01:12:17 PM
-- Design Name: 
-- Module Name: testbench - Behavioral
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

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is
    component riconoscitore_101_fpga is
        Port (  SW_in   :   in  std_logic ;
                SW_mode :   in std_logic;
                BTN_in  :   in std_logic;
                BTN_mode    :   in std_logic;
                CLK    :   in  std_logic; -- segnale di tempificazione (clock)
                RST   :   in  std_logic;
                LED_out  :   out std_logic
        );
    end component;
    
    signal clock:std_logic;
    signal input_sw: std_logic;
    signal mode_sw: std_logic;
    signal btn_in: std_logic:='0';
    signal btn_mode: std_logic:='0';
    signal output:std_logic;
    constant CLK_period : time := 10 ns;
begin
    
    
    
    riconoscitore: riconoscitore_101_fpga
        Port Map(SW_in=>input_sw,
                SW_mode=>mode_sw,
                BTN_in=>btn_in,
                BTN_mode=>btn_mode,
                CLK=>clock,
                RST=>'0',
                LED_out=>output
        );
    
   CLK_process :process
        begin
            clock <= '0';
            wait for CLK_period/2;
        
            clock <= '1';
            wait for CLK_period/2;
       
   end process;
    
    uut: process
        begin
        input_sw<='0';
        mode_sw<='1';
        btn_mode<='1';
        wait for 10ns;
        btn_mode<='0';
        wait for 100ns;
        input_sw<='1';
        btn_in<='1';
        wait for 100ns;
        btn_in<='0';
                wait for 100ns;

        input_sw<='0';
        btn_in<='1';
        wait for 100ns;
        btn_in<='0';
                wait for 100ns;

        input_sw<='1';
        btn_in<='1';
                wait for 100ns;
        btn_in<='0';
        wait for 10ns;
        wait;
        end process;
end Behavioral;
