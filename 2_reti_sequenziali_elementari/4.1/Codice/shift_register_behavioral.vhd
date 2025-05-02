----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2025 16:15:07
-- Design Name: 
-- Module Name: shift_register_behavioral - Behavioral
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

entity shift_register_behavioral is
    Generic(N : integer := 8);
    Port (  input   : in std_logic;
            RST     : in std_logic;
            LOAD    : in std_logic;
            CLK     : in std_logic; -- Abilitazione
            s       : in std_logic; -- 0 = shift a destra, 1 = shift a sinistra
            Y       : in std_logic; -- 0 = shift di 1 bit, 1 = shift di 2 bit
            output  : out std_logic_vector (N-1 downto 0)
    );
end shift_register_behavioral;

architecture Behavioral of shift_register_behavioral is

    signal output_temp : std_logic_vector (N-1 downto 0) := (others => '0');

begin
    
    mem: process(CLK)
    begin
        if(CLK'event and CLK = '1') then
            if(RST = '1') then
                output_temp <= (others => '0');
            elsif(LOAD = '1') then
                case s is
                    when '0' => -- Shift a destra
                        if(Y = '0') then -- Shift di 1 bit
                            output_temp(N-2 downto 0) <= output_temp(N-1 downto 1);
                            output_temp(N-1) <= input;
                        elsif(Y = '1') then -- Shift di 2 bit
                            output_temp(N-3 downto 0) <= output_temp(N-1 downto 2);
                            output_temp(N-2) <= input;
                            output_temp(N-1) <= '0';
                        end if;
                    when '1' => -- Shift a sinistra
                        if(Y = '0') then -- Shift di 1 bit
                            output_temp(N-1 downto 1) <= output_temp(N-2 downto 0);
                            output_temp(0) <= input;
                        elsif(Y = '1') then -- Shift di 2 bit
                            output_temp(N-1 downto 2) <= output_temp(N-3 downto 0);
                            output_temp(1) <= input;
                            output_temp(0) <= '0';
                        end if;
                    when others =>
                        output_temp <= (others => '0');
                end case;
            end if;
        end if;
    end process;
    
    output <= output_temp; 

end Behavioral;
