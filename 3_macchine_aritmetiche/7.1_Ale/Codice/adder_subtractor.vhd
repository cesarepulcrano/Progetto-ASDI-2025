----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 12:33:38 PM
-- Design Name: 
-- Module Name: adder_subtractor - Structural
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

entity adder_subtractor is
    Generic(N : natural :=8);
    Port (  a:in std_logic_vector(N-1 downto 0);
            b:in std_logic_vector(N-1 downto 0);
            c_in: in std_logic;
            s: out std_logic_vector(N-1 downto 0);
            c_out : out std_logic
          );
end adder_subtractor;

architecture Structural of adder_subtractor is
    component ripple_carry_adder is
        Generic(N : natural :=8);
        Port (  a:in std_logic_vector(N-1 downto 0);
                b:in std_logic_vector(N-1 downto 0);
                c_in: in std_logic;
                s: out std_logic_vector(N-1 downto 0);
                c_out : out std_logic
              );
    end component;
    
    signal complementob: std_logic_vector(N-1 downto 0);
    
begin
    
--    complemento_b:for i in N-1 downto 0 generate
--        complementob(i)<=b(i) XOR c_in;
--    end generate;

    -- complementob <= b XOR (N-1 downto 0 => c_in);
    
    process(b, c_in)
    begin
        for i in N-1 downto 0 loop
            complementob(i) <= b(i) XOR c_in;
        end loop;
    end process;

    rca:ripple_carry_adder
        Generic Map(N=>N)
        Port Map(   a=>a,
                    b=>complementob,
                    c_in=>c_in,
                    s=>s,
                    c_out=>c_out
              );
              
end Structural;