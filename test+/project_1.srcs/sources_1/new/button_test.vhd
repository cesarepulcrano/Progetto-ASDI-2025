----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2025 01:42:40 PM
-- Design Name: 
-- Module Name: button_test - Behavioral
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

entity button_test is
    Port (  SW_in : in std_logic;
            BTN_in :    in std_logic;
            CLK:    in std_logic;
            LED_out : out std_logic
     );
end button_test;

architecture Behavioral of button_test is
    component switch_capture
        Port (   clock   :   in std_logic;
                 button  :   in  std_logic;
                 input : in std_logic;
                 output  :   out std_logic
    );
    end component;
begin
    
    button: switch_capture
        port map(
                    clock=>CLK,
                    button=>BTN_in,
                    input=>SW_in,
                    output=>LED_out

        );


end Behavioral;
