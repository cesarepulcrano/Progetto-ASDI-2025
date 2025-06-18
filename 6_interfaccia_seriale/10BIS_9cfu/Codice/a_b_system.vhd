----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 01:01:50 PM
-- Design Name: 
-- Module Name: a_b_system - Structural
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

entity a_b_system is
    Generic (   N   :   natural :=8;
                M   :   natural := 8);
    Port (
            clk: in std_logic; 
            rst: in std_logic;
            wr: in std_logic;
            rd: in std_logic;
            overrun:     out std_logic;
            a_output:   out std_logic;
            output: out std_logic_vector (M-1 downto 0)
             );
end a_b_system;

architecture Structural of a_b_system is
    component a is
        Port ( 
                clk: in std_logic;
                rst: in std_logic;
                start: in std_logic;
                ack : in std_logic;
                req: out std_logic;
                output: out std_logic
        );
    end component;
    
    component b is
        Generic (   N   :   natural :=8;
                    M   :   natural := 8);
        Port ( 
                clk: in std_logic;
                rst: in std_logic;
                start:  in std_logic;
                ack : out std_logic;
                req: in std_logic;
                input: in std_logic;
                overrun:     out std_logic;
                output: out std_logic_vector(M-1 downto 0)
        );
    end component;
    
    signal ack: std_logic;
    signal req: std_logic;
    signal a_to_b: std_logic;
    
begin
    
    a_unit:a 
        Port Map( 
                clk=>clk,
                rst=>rst,
                start=>wr,
                ack=>ack,
                req=>req,
                output=>a_to_b
        );
    
    b_unit:b
        Port Map( 
                clk=>clk,
                rst=>rst,
                start=>rd,
                ack=>ack,
                req=>req,
                input=>a_to_b,
                overrun=>overrun,
                output=>output
        );
    a_output<=a_to_b;
end Structural;
