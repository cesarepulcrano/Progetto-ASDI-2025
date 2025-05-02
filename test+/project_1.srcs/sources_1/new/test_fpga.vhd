----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2025 12:57:06 PM
-- Design Name: 
-- Module Name: test_fpga - Behavioral
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

entity test_fpga is
    Port (  inpt   :   in  std_logic ;
            md :   in std_logic;
            CLK    :   in  std_logic; -- segnale di tempificazione (clock)
            RST   :   in  std_logic;
            LED_out  :   out std_logic
     );
end test_fpga;

architecture Behavioral of test_fpga is
    signal input:  std_logic;
    signal mode:  std_logic;
    
    component riconoscitore_101
        port(   
                input   :   in  std_logic;
                a       :   in  std_logic; -- segnale ti tempificazione(clock)
                reset   :   in  std_logic;
                m       :   in  std_logic; --0 modalità non sovrapposta, 1 modalità parzialmente sovrapposta
                output  :   out std_logic
        );
    end component;
begin
    
    fpga: riconoscitore_101
        port map(
                input=>inpt,
                a=>CLK,
                reset=>RST,
                m=>md,
                output=>LED_out
        );
    
    
    stim_proc: process(CLK)
        variable i : std_logic;

        begin
        --md<='0';
        i:='1';
        mode<='0';
        md<=mode;
        inpt<=i;
        inpt<='0';
        inpt<='1';
        
    end process;

end Behavioral;
