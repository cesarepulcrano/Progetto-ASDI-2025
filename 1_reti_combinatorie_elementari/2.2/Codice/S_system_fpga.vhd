----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2025 19:07:37
-- Design Name: 
-- Module Name: S_system_fpga - Behavioral
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

entity S_system_fpga is
    port (
        SW    :   in std_logic_vector(3 downto 0); -- Locazione ROM
        LED   :   out std_logic_vector(3 downto 0) -- AND bitwise
    );
end S_system_fpga;

architecture Structural of S_system_fpga is

    component S_system is
        port (
            input    :   in std_logic_vector(3 downto 0); -- Locazione ROM
            output   :   out std_logic_vector(3 downto 0) -- AND bitwise
        );
    end component;

begin

    S : S_system
        Port map(
            input => SW,
            output => LED
        );

end Structural;
