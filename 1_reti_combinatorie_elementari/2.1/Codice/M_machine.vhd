----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2025 18:33:17
-- Design Name: 
-- Module Name: M_machine - Behavioral
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

entity M_machine is
    port (
        input   :   in std_logic_vector(7 downto 0); -- Valore contenuto nella ROM
        output  :   out std_logic_vector(3 downto 0) -- Output trasformato
    );
end M_machine;

-- AND bitwise
architecture Dataflow of M_machine is

begin
    output(0) <= input(0) AND input(4);
    output(1) <= input(1) AND input(5);
    output(2) <= input(2) AND input(6);
    output(3) <= input(3) AND input(7);

end Dataflow;
