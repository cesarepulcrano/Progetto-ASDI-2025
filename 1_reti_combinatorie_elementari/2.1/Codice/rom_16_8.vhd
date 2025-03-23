----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2025 18:26:02
-- Design Name: 
-- Module Name: rom_16_8 - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

 entity rom_16_8 is
    port(
        address : in  std_logic_vector(3 downto 0); -- 2^4 locazioni
        dout    : out std_logic_vector(7 downto 0)  -- Locazioni
    );
 end entity rom_16_8;
 
 architecture RTL of rom_16_8 is
    type MEMORY_16_8 is array (0 to 15) of std_logic_vector(7 downto 0); -- Matrice 16x8
    
    constant ROM : MEMORY_16_8 := ( -- ROM content
        x"1A",
        x"2B",
        x"3C",
        x"4D",
        x"5E",
        x"5F",
        x"61",
        x"72",
        x"83",
        x"94",
        x"A5",
        x"B6",
        x"C7",
        x"D8",
        x"E9",
        x"FA"
    );
    
 begin
    process(address)
    begin
        dout <= ROM(to_integer(unsigned(address))); -- Casting da unsigned a intero
    end process;
    
 end architecture RTL;
