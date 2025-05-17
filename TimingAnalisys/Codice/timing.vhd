----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 08:42:16 PM
-- Design Name: 
-- Module Name: timing - Structural
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

entity timing is
    Port ( 
            clk: in std_logic;
            rst: in std_logic;
            load: in std_logic;
            input    :   in std_logic_vector(3 downto 0);
            output   :   out std_logic_vector(3 downto 0)
        );
end timing;

architecture Structural of timing is
    component S_system is
        port (
            input    :   in std_logic_vector(3 downto 0); -- Locazione ROM
            output   :   out std_logic_vector(3 downto 0) -- AND bitwise
        );
    end component;
    
    component test_register is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               load : in STD_LOGIC;
               input : in STD_LOGIC_VECTOR (3 downto 0);
               output : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal reg_to_s : std_logic_vector(3 downto 0);
    signal s_to_reg : std_logic_vector(3 downto 0);
    
begin
    
    r0:test_register 
        Port Map( clk    =>clk,
               rst    =>rst,
               load   =>load,
               input  =>input,
               output =>reg_to_s
               );
    
    s:S_system 
        Port Map(
            input    =>reg_to_s,
            output   =>s_to_reg
        );
    
    r1:test_register 
        Port Map( 
                clk    =>clk,
               rst    =>rst,
               load   =>load,
               input  =>s_to_reg,
               output =>output
               );    
end Structural;
