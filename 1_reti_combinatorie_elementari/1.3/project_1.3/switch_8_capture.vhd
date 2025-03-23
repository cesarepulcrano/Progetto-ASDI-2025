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

entity switch_8_capture is
    Port (  -- RESET            :   in std_logic; -- Reset button
            CLOCK            :   in std_logic; -- Clock signal
            BTN              :   in std_logic; -- Button input
            SWITCH_INPUT     :   in std_logic_vector(7 downto 0); -- 8 input
            -- SWITCH_SEL_IN    :   in std_logic_vector(3 downto 0); -- 4 selezioni input
            -- SWITCH_SEL_OUT   :   in std_logic_vector(1 downto 0); -- 2 selezioni output
            OUTPUT           :   out std_logic_vector(7 downto 0) -- Input + selezioni
    );
end switch_8_capture;

architecture Behavioral of switch_8_capture is
begin
    process(CLOCK, BTN, SWITCH_INPUT) -- , SWITCH_SEL_IN, SWITCH_SEL_OUT)  
        begin   
            if (rising_edge(CLOCK)) then
                if(BTN='0') then -- Click del bottone
                    OUTPUT(7 downto 0) <= SWITCH_INPUT; -- Input
                    -- OUTPUT(11 downto 8) <= SWITCH_SEL_IN; -- Selezione mux
                    -- OUTPUT(13 downto 12) <= SWITCH_SEL_OUT; -- Selezione demux
                end if;
            end if;
    end process;
end Behavioral;