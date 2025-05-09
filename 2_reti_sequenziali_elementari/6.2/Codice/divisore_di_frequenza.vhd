----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2025 08:27:34 PM
-- Design Name: 
-- Module Name: divisore_di_frequenza - Behavioral
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

entity divisore_di_frequenza is
    generic(
        CLKIN_freq  : integer := 100000000;  -- clock board 100MHz
        CLKOUT_freq : integer := 1000           -- frequenza desiderata 1Hz
    );
    Port (
        clock_in  : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        clock_out : out STD_LOGIC
    );
end divisore_di_frequenza;


architecture Behavioral of divisore_di_frequenza is

    signal clockfx : std_logic := '0';

    constant count_max_value : integer := CLKIN_freq/(CLKOUT_freq)-1;

begin
    clock_out <= clockfx;

    count_for_division: process(clock_in)

        variable counter : integer range 0 to count_max_value := 0;
    begin

        if rising_edge(clock_in) then
            if( reset = '1') then
                counter := 0;
                clockfx <= '0';
            else
                if counter = count_max_value then
                    clockfx <= '1';
                    counter := 0;
                else
                    clockfx <= '0';
                    counter := counter + 1;
                end if;
            end if;
        end if;
    end process;
end Behavioral; 
