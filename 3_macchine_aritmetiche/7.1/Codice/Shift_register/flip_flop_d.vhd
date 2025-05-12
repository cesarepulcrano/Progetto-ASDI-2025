----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2025 14:09:02
-- Design Name: 
-- Module Name: mux_2_1 - Behavioral
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

entity flip_flop_d is
    Port (  D   : in std_logic;
            A   : in std_logic;
            RST : in std_logic;
            Q   : out std_logic
    );
end flip_flop_d;

architecture Behavioral of flip_flop_d is

begin

    process(A) -- Sul fronte di salita del segnale di abilitazione
    begin
        if(A'event and A='1') then
            if(RST='1') then
                Q <= '0';
            else
                Q <= D;
            end if;
        end if;
    end process;

end Behavioral;
