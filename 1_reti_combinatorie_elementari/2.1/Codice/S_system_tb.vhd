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

entity S_system_tb is
--  Port ( );
end S_system_tb;

architecture Behavioral of S_system_tb is

    component S_system is
        port (
            input    :   in std_logic_vector(3 downto 0); -- Locazione ROM
            output   :   out std_logic_vector(3 downto 0) -- AND bitwise
        );
    end component;
    
    signal input_test    :   std_logic_vector(3 downto 0) := (others => 'U');
    signal output_test   :   std_logic_vector(3 downto 0) := (others => 'U');
    
begin
    
    uut : entity work.S_system(Structural) -- unity under test
        Port map(
            input => input_test,
            output => output_test
        );
        
    stim_proc : process
    begin
    
    wait for 10 ns;
    
    for i in 0 to 15 loop
        input_test <= std_logic_vector(to_unsigned(i, 4)); -- Conversione da decimale a binario
        wait for 50 ns;
    end loop;
    
    assert output_test = "0000"
    report "error"
    severity failure;
    
    wait;
    end process;

end ;
