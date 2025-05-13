----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2025 05:40:52 PM
-- Design Name: 
-- Module Name: tb - Behavioral
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

entity tb is
    Generic (N: natural := 8);
--  Port ( );
end tb;

architecture Behavioral of tb is
    component adder_subtractor is
        Generic(N : natural :=8);
        Port (  a:in std_logic_vector(N-1 downto 0);
                b:in std_logic_vector(N-1 downto 0);
                c_in: in std_logic;
                s: out std_logic_vector(N-1 downto 0);
                c_out : out std_logic
              );
    end component ;
    signal a: std_logic_vector(N-1 downto 0);
    signal b: std_logic_vector(N-1 downto 0);
    signal s: std_logic_vector(N-1 downto 0);
    signal c_in: std_logic;
    signal c_out: std_logic;
begin
    
    uut: adder_subtractor 
            Generic Map(N=>8)   
            Port Map(  a=>a,
                b=>b,
                c_in=>c_in,
                s=>s,
                c_out=>c_out
              );
              
              
              
              stim: process
              begin
                a<="00000000";
                b<="00000001";
                c_in<='1';
                wait;
                end process;

end Behavioral;
