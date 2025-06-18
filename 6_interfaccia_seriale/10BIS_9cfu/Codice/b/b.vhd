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

entity b is
    Generic (   N   :   natural :=8;
                M   :   natural := 8);
    Port ( 
            clk: in std_logic;
            rst: in std_logic;
            start : in std_logic;
            ack : out std_logic;
            req: in std_logic;
            input: in std_logic;
            overrun:     out std_logic;
            output: out std_logic_vector(M-1 downto 0)
    );
end b;

architecture Structural of b is
    
    component UC_b is
        Generic (   N   :   natural :=8;
                    M   :   natural := 8);
        Port (  clk:    in std_logic;
                rst:    in std_logic;
                count:  in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
                start : in std_logic;
                ack: out std_logic;
                req: in std_logic;
                en_count:    out std_logic;
                write_mem:    out std_logic;
                --uart
                RDA:    in  std_logic;
                RD:     out  std_logic
                 );
    end component;
    component UO_b is
        Generic (   N   :   natural :=8;
                    M   :   natural := 8);
        Port (  clk:    in std_logic;
                rst:    in std_logic;
                en_count:    in std_logic;
                write_mem:    in std_logic;
                count:  out std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
                --uart
                input:  in  std_logic;
                RDA:    out  std_logic;
                RD:     in  std_logic;
                OE:     in  std_logic;
                output: out std_logic_vector(M-1 downto 0)
                 );
    end component;

    
    signal count:std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
    signal en_count: std_logic;
    signal write_mem: std_logic;
    signal RDA: std_logic:='0';
    signal RD: std_logic;
    signal oe_bus: std_logic;
    
begin
    
    uc:UC_b
        Port Map(  
                clk=>clk,
                rst=>rst,
                count=>count,
                start=>start,
                ack=>ack,
                req=>req,
                en_count=>en_count,
                write_mem=>write_mem,
                --uart
                RDA=>RDA,
                RD=>RD
                 );
    
    uo:UO_b
        Port Map(  
                clk=>clk,
                rst=>rst,
                count=>count,
                input=>input,
                en_count=>en_count,
                write_mem=>write_mem,
                --uart
                RDA=>RDA,
                RD=>RD,
                OE=>oe_bus,
                output=>output
                 );
                 overrun<=oe_bus;
end Structural;
