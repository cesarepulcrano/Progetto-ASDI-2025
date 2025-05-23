----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.05.2025 19:58:05
-- Design Name: 
-- Module Name: PO_PC_system_tb - Behavioral
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

entity PO_PC_system_tb is
end PO_PC_system_tb;

architecture Behavioral of PO_PC_system_tb is

    component PO_PC_system is
        Generic (N : integer);
        Port (  CLK : in std_logic;
                RST : in std_logic;
                START : in std_logic;
                COUNT_out : out std_logic_vector(3 downto 0);
                data_out : out std_logic_vector(3 downto 0)
        );
    end component;
    
    signal clock : std_logic;
    constant CLK_period : time := 10 ns;
    signal reset : std_logic;
    signal start : std_logic;
    signal data : std_logic_vector(3 downto 0);
    signal output_count : std_logic_vector(3 downto 0);

begin

    uut: PO_PC_system
        Generic Map (N=>16)
        Port Map (  CLK=>clock,
                    RST=>reset,
                    START=>start,
                    COUNT_out=>output_count,
                    data_out=>data
        );
        
    clk : process
    begin
        clock <= '0';
        wait for CLK_period/2;
        clock <= '1';
        wait for CLK_period/2;
    end process;
    
    test : process
    begin
        start <= '1';
        wait for 10*3*16 ns;
        
        reset<='1';
        start<='0';
        wait for CLK_PERIOD;
        reset<='0';
        wait for CLK_PERIOD;
        start<='1';
        wait for 10000000 ns;
        wait;
    end process;

end Behavioral;
