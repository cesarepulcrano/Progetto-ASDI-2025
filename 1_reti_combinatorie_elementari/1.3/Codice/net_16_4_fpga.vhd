----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.03.2025 12:37:00
-- Design Name: 
-- Module Name: net_16_4_fpga - Structural
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

entity net_16_4_fpga is
    Port (  -- RESET            :   in std_logic; -- Reset button
            CLOCK            :   in std_logic; -- Clock signal
            BTNL             :   in std_logic; -- Button input 1
            BTNR             :   in std_logic; -- Button input 2
            SWITCH_INPUT     :   in std_logic_vector(7 downto 0); -- 16 input
            SWITCH_SEL_IN    :   in std_logic_vector(3 downto 0); -- 4 selezioni input
            SWITCH_SEL_OUT   :   in std_logic_vector(1 downto 0); -- 2 selezioni output
            LED              :   out std_logic_vector(3 downto 0) -- 4 LED
    );
end net_16_4_fpga;

architecture Structural of net_16_4_fpga is
    signal  switch_to_net_0 :   std_logic_vector(7 downto 0);
    signal  switch_to_net_1 :   std_logic_vector(7 downto 0);
    signal switch_to_net :std_logic_vector(15 downto 0);
    
    component switch_8_capture
        Port (  -- RESET            :   in std_logic; -- Reset button
                CLOCK            :   in std_logic; -- Clock signal
                BTN              :   in std_logic; -- Button input
                SWITCH_INPUT     :   in std_logic_vector(7 downto 0); -- 8 input
                -- SWITCH_SEL_IN    :   in std_logic_vector(3 downto 0); -- 4 selezioni input
                -- SWITCH_SEL_OUT   :   in std_logic_vector(1 downto 0); -- 2 selezioni output
                OUTPUT           :   out std_logic_vector(7 downto 0) -- Input
        );
    end component;
    
    component net_16_4 is
        Port (  input    :   in std_logic_vector(15 downto 0);
                input_control   :   in std_logic_vector (3 downto 0);
                output_control  :   in std_logic_vector (1 downto 0);
                output  :   out std_logic_vector (3 downto 0)
        );
    end component;

begin
    switch_0 : switch_8_capture
        Port map(   -- RESET            :   in std_logic; -- Reset button
                    CLOCK => CLOCK,
                    BTN => BTNL, -- Button input 1
                    SWITCH_INPUT => SWITCH_INPUT, -- 8 input
                    OUTPUT => switch_to_net(15 downto 8) -- Input
        );
        
    switch_1 : switch_8_capture
        Port map(   -- RESET            :   in std_logic; -- Reset button
                    CLOCK => CLOCK,
                    BTN => BTNR, -- Button input 2
                    SWITCH_INPUT => SWITCH_INPUT, -- 8 input
                    OUTPUT => switch_to_net(7 downto 0) -- Input  
        );
        
    net : net_16_4
        Port map(   input => switch_to_net, -- Concatenazione
                    input_control => SWITCH_SEL_IN,
                    output_control => SWITCH_SEL_OUT,
                    output => LED
        );

end Structural;
