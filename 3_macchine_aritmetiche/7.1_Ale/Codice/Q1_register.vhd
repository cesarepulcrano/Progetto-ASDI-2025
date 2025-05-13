----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2025 00:28:16
-- Design Name: 
-- Module Name: Q1_register - Behavioral
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

entity Q1_register is
    Generic(N: natural:=8);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           load : in STD_LOGIC;
           SHIFT : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR(N-1 downto 0);
           output_Q : out STD_LOGIC_VECTOR(N-1 downto 0)
           );
end Q1_register;

architecture Behavioral of Q1_register is
    -- Dichiarazione del segnale X_ext (N+1 bit)
    signal X_ext : std_logic_vector(N downto 0); -- N è il numero di bit del registro Q
begin


process (CLK)
begin
    if rising_edge(CLK) then
        if RST = '1' then
            -- Reset del registro X_ext, impostato inizialmente a 0
            X_ext <= (others => '0');
        elsif SHIFT = '1' then
            -- Esegui lo shift e aggiorna Q(-1) (X_ext(0)) con l'attuale Q0
            X_ext <= output_Q & output_Q(0); -- Aggiungi il bit meno significativo (Q0) alla parte più bassa di X_ext
        end if;
    end if;
end process;


end Behavioral;
