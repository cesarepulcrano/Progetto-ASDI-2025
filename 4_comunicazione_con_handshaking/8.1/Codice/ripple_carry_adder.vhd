----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 12:33:38 PM
-- Design Name: 
-- Module Name: ripple_carry_adder - Structural
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

entity ripple_carry_adder is
    Generic(N : natural :=8);
    Port (  a:in std_logic_vector(N-1 downto 0);
            b:in std_logic_vector(N-1 downto 0);
            c_in: in std_logic;
            s: out std_logic_vector(N-1 downto 0);
            c_out : out std_logic
          );
end ripple_carry_adder;

architecture Structural of ripple_carry_adder is
    component full_adder is
        Port (  a:in std_logic;
                b:in std_logic;
                c_in:in std_logic;
                s:out std_logic;
                c_out:out std_logic
                );
    end component;
    
    signal carry: std_logic_vector(N-2 downto 0):=(others=>'0');
    
begin
    
    fa_0: full_adder
        Port Map(   a=>a(0),
                    b=>b(0),
                    c_in=>c_in,
                    s=>s(0),
                    c_out=>carry(0)
                    );

    fa_chain: for i in N-2 downto 1 generate
       fa:full_adder 
            Port Map(   a=>a(i),
                        b=>b(i),
                        c_in=>carry(i-1),
                        s=>s(i),
                        c_out=>carry(i)
                    );
    end generate;
    
    fa_N_1: full_adder
        Port Map(   a=>a(N-1),
                    b=>b(N-1),
                    c_in=>carry(N-2),
                    s=>s(N-1),
                    c_out=>c_out
                    );
end Structural;
