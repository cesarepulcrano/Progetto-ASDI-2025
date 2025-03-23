----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2025 18:45:28
-- Design Name: 
-- Module Name: S_system - Behavioral
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

entity S_system is
    port (
        input    :   in std_logic_vector(3 downto 0); -- Locazione ROM
        output   :   out std_logic_vector(3 downto 0) -- AND bitwise
    );
end S_system;

architecture Structural of S_system is
    signal rom_to_M : std_logic_vector(7 downto 0) := (others => 'U'); -- Link tra ROM e M
    
    component rom_16_8 is
        port(
            address : in  std_logic_vector(3 downto 0); -- 2^4 locazioni
            dout    : out std_logic_vector(7 downto 0)  -- Locazioni
        );
    end component;
    
    component M_machine is
        port (
            input   :   in std_logic_vector(7 downto 0); -- Valore contenuto nella ROM
            output  :   out std_logic_vector(3 downto 0) -- Output trasformato
        );
    end component;
    
begin

    rom : rom_16_8
        Port map(
            address => input,
            dout => rom_to_M
        );
        
    M : M_machine
        Port map(
            input => rom_to_M,
            output => output
        );

end Structural;