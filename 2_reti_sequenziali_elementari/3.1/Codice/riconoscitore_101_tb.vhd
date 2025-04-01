----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/01/2025 01:08:04 PM
-- Design Name: 
-- Module Name: riconoscitore_101_tb - Behavioral
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

entity riconoscitore_101_tb is

end riconoscitore_101_tb;

architecture Behavioral of riconoscitore_101_tb is
    signal input_tb:  std_logic:='U';
    signal a_tb:  std_logic:='U';
    signal reset_tb :  std_logic:='0';
    signal m_tb :    std_logic:='U';
    signal output_tb:    std_logic:='U';
    constant a_period : time :=10ns;
    component riconoscitore_101
        Port (  input   :   in  std_logic;
                a       :   in  std_logic; -- segnale ti tempificazione(clock)
                reset   :   in  std_logic;
                m       :   in  std_logic; --0 modalità non sovrapposta, 1 modalità parzialmente sovrapposta
                output  :   out std_logic
         );
    end component;
begin

    uut: riconoscitore_101
        port map(
            input=>input_tb,
            a=>a_tb,
            reset=>reset_tb,
            m=>m_tb,
            output=>output_tb
        );
    
    
    clock_process   :process
    begin
        a_tb<='0';
        wait for a_period/2;
        a_tb<='1';
        wait for a_period/2;
    end process;
    
    stim_proc: process
    begin
    m_tb<='0';

    
    input_tb<='0';
        wait for 10 ns;

    input_tb<='0';
        wait for 10 ns;

    input_tb<='0';
    wait for 10 ns;
    

    
    input_tb<='1';
    wait for 10 ns;

    input_tb<='0';
    wait for 10 ns;

    input_tb<='1';
    
    
    wait for 10 ns;
    
    input_tb<='1'; 
      wait for 10 ns;

    
    input_tb<='1';
        wait for 10 ns;

    input_tb<='1';
    
    wait for 10 ns;
    input_tb<='1';
        wait for 10 ns;
    
    m_tb<='1';
    
    input_tb<='1';
        wait for 10 ns;

    input_tb<='1';
    
    wait for 10 ns;
    
    input_tb<='0';
    wait for 10 ns;
    input_tb<='1';
        
    
    
    
    
    wait for 10 ns;
    assert output_tb ='0'
    report "error"
    severity failure;
    wait;
    end process;
end Behavioral;
