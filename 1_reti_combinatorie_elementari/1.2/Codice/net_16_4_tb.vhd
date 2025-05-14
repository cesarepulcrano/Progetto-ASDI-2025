----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2025 01:19:11 PM
-- Design Name: 
-- Module Name: net_16_4_tb - Behavioral
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
use work.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity net_16_4_tb is
end net_16_4_tb;

architecture Behavioral of net_16_4_tb is
    
    component net_16_4
        Port (  input           :   in  std_logic_vector    (15 downto  0);
                input_control   :   in  std_logic_vector    (3  downto  0);
                output_control  :   in  std_logic_vector    (1  downto  0);
                output          :   out std_logic_vector    (3  downto  0)
        );
    end component;
    
    
    signal  input_test              :   std_logic_vector    (15 downto  0)  :=(others=>'0');--"0000000000000000";
    signal  input_control_test      :   std_logic_vector    (3  downto  0)  :=(others=>'0');--"0000";
    signal  output_control_test     :   std_logic_vector    (1  downto  0)  :=(others=>'0');--"00";
    signal  output_test             :   std_logic_vector    (3  downto  0)  :=(others=>'0');
    
begin
    
    uut:  entity  work.net_16_4(Structural)
        Port map(   input=>input_test,
                    input_control=>input_control_test,
                    output_control=>output_control_test,
                    output=>output_test
        );
    
    stim_proc: process
    begin
    
    --wait for 10 ns;
    
    input_test<="1000000000000000";
    --wait for 10 ns;
    input_control_test<="1111";
    output_control_test<="01";
    wait for 10 ns;
    input_control_test<="0111";
    output_control_test<="10";
    wait for 10 ns;
    input_test<="1001001000010000";
    input_control_test<="0100";
    output_control_test<="11";
    wait for 10 ns;
    input_control_test<="1110";
    output_control_test<="00";
    wait for 10 ns;
    assert output_test="0000";
    report  "errore"
    severity failure;
    end process;
end Behavioral;
