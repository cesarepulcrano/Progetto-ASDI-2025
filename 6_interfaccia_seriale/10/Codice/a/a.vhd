----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 01:01:50 PM
-- Design Name: 
-- Module Name: a - Structural
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity a is
    Generic (   N   :   natural :=8;
                M   :   natural := 8);
    Port ( 
            clk: in std_logic;
            rst: in std_logic;
            start: in std_logic;
            ack : in std_logic;
            req: out std_logic;
            output: out std_logic
    );
end a;

architecture Structural of a is
    
    component UC_a is
        Generic (   N   :   natural :=8;
                    M   :   natural := 8);
        Port (  clk:    in std_logic;
                rst:    in std_logic;
                count:  in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
                start : in std_logic;
                ack: in std_logic;
                req: out std_logic;
                en_count:    out std_logic;
                read_rom:    out std_logic;
                --uart
                TBE :   in std_logic;
                WR :   out std_logic
                 );
    end component;
    
    component UO_a is
    Generic (   N   :   natural :=8;
                M   :   natural := 8);
    Port (  clk:    in std_logic;
            rst:    in std_logic;
            en_count:    in std_logic;
            read_rom:    in std_logic;
            count:  out std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
            --uart
            TBE :   out std_logic;
            WR :   in std_logic;
            output: out std_logic
             );
    end component;

    
    signal count:std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
    signal en_count: std_logic;
    signal read_rom: std_logic;
    signal TBE: std_logic;
    signal WR: std_logic;
    
begin
    
    uc:UC_a
        Port Map(  
                clk=>clk,
                rst=>rst,
                count=>count,
                start=>start,
                ack=>ack,
                req=>req,
                en_count=>en_count,
                read_rom=>read_rom,
                --uart
                TBE=>TBE,
                WR=>WR
                 );
    
    uo:UO_a
        Port Map(  
                clk=>clk,
                rst=>rst,
                count=>count,
                en_count=>en_count,
                read_rom=>read_rom,
                --uart
                TBE=>TBE,
                WR=>WR,
                output=>output
                 );
end Structural;
