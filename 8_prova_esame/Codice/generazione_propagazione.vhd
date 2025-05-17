----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 06:15:24 PM
-- Design Name: 
-- Module Name: generazione_propagazione - Dataflow
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

entity generazione_propagazione is
    Port ( 
            x : in std_logic_vector(3 downto 0);
            y : in std_logic_vector(3 downto 0);
            P : out std_logic_vector(3 downto 0);
            G : out std_logic_vector(3 downto 0)
    );
end generazione_propagazione;

architecture Dataflow of generazione_propagazione is

begin
    
    P<= x xor y;
    G<= x and y;

end Dataflow;
