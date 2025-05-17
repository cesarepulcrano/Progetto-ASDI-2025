----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2025 19:53:33
-- Design Name: 
-- Module Name: S_system_tb - Behavioral
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
use work.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity timing_tb is
--  Port ( );
end timing_tb;

architecture Behavioral of timing_tb is

    component timing is
        Port ( 
                clk: in std_logic;
                rst: in std_logic;
                load: in std_logic;
                input    :   in std_logic_vector(3 downto 0);
                output   :   out std_logic_vector(3 downto 0)
            );
    end component;
    
    signal input_test    :   std_logic_vector(3 downto 0) := (others => 'U');
    signal output_test   :   std_logic_vector(3 downto 0) := (others => 'U');
    signal load_test    :   std_logic;
    signal clock : std_logic;
    signal period: time := 10 ns;
begin
    
    uut : timing -- unit under test
        Port map(
                clk     =>clock,
                rst     =>rst,
                load    =>load_test,
                input   =>input_test,
                output  =>output_test
        );
    
    cloc:process
    begin
        clock<='0';
        wait for period/2;
        clock<='1';
        wait for period/2;
    end process;
        
    stim_proc : process
    begin
    
    wait for 10 ns;
    load<='1';
    for i in 0 to 15 loop
        input_test <= std_logic_vector(to_unsigned(i, 4)); -- Conversione da decimale a binario
        wait for 50 ns;
        load<='0';
    end loop;
    
    assert output_test = "0000"
    report "error"
    severity failure;
    
    wait;
    end process;

end Behavioral;
