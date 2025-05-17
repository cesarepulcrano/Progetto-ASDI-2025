----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 06:15:24 PM
-- Design Name: 
-- Module Name: carry_look_ahead - Dataflow
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

entity carry_look_ahead is
    Port (
            P: in std_logic_vector(3 downto 0);
            G: in std_logic_vector(3 downto 0);
            c_in: in std_logic;
            carry: out std_logic_vector(3 downto 0);
            c_out: out std_logic;
            P_out: out std_logic_vector(3 downto 0)
     );
end carry_look_ahead;
        
architecture Dataflow of carry_look_ahead is

begin
    
    carry(0)<=c_in;
    carry(1)<=G(0) xor (P(0) and c_in);
    carry(2)<=G(1) xor (P(1) and G(0)) xor (P(1) and P(0) and c_in);
    carry(3)<=G(2) xor (P(2) and G(1)) xor(P(2) and P(1) and G(0)) xor (P(2) and P(1) and P(0) and c_in);
    c_out<=G(3) xor (P(3) and G(2)) xor (P(3) and P(2) and G(1)) xor (P(3) and P(2) and P(1) and G(0)) xor (P(3) and P(2) and P(1) and P(0) and c_in);
    P_out<=P;
end Dataflow;
