----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2025 18:18:05
-- Design Name: 
-- Module Name: PO - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
    Generic(N : integer := 16);
    Port (  CLK : in std_logic;
            EN  : in std_logic;
            address : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0); -- Codifica da 0 a N-1
            data_out : out std_logic_vector(7 downto 0)
    );
end ROM;

architecture Behavioral of ROM is
    type MEMORY_N_8 is array (0 to N-1) of std_logic_vector(7 downto 0); -- Matrice N x 8
    
    constant ROM_DATA : MEMORY_N_8 := ( -- ROM content
        x"1A",
        x"2B",
        x"3C",
        x"4D",
        x"5E",
        x"6F",
        x"71",
        x"82",
        x"93",
        x"A4",
        x"B5",
        x"C6",
        x"D7",
        x"E8",
        x"F9",
        x"3A"
    );
    
 begin
    process(CLK)
    begin
        if(CLK'event AND CLK = '1') then
            if(EN = '1') then
                data_out <= ROM_DATA(to_integer(unsigned(address))); -- Casting da unsigned a intero
            end if;
        end if;
    end process;
    
end architecture Behavioral;
