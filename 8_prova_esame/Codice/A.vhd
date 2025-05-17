----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 05:30:08 PM
-- Design Name: 
-- Module Name: A - Structural
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

entity A is
    Port ( 
            clk: in std_logic;
            rst: in std_logic;
            start: in std_logic;
            req:  out std_logic;
            ack: in std_logic;
            data_out: out std_logic_vector(3 downto 0)
    );
end A;

architecture Structural of A is
    component uo_a is
        Port (
                clk: in std_logic;
                rst: in std_logic;
                en_count: in std_logic;
                read_rom: in std_logic;
                count: out std_logic_vector(2 downto 0);
                data_out: out std_logic_vector(3 downto 0)
        
         );
    end component;
    
    component uc_a is
        Port ( 
                clk: in std_logic;
                rst: in std_logic;
                start: in std_logic;
                en_count: out std_logic;
                read_rom: out std_logic;
                req: out std_logic;
                ack: in std_logic;
                count: in std_logic_vector(2 downto 0)
        );
    end component;
    
    signal read_rom: std_logic;
    signal en_count: std_logic;
    signal count:   std_logic_vector(2 downto 0);
    
begin
    
    uo:uo_a 
        Port Map(
                clk     =>clk,
                rst     =>rst,
                en_count=>en_count,
                read_rom=>read_rom,
                count   =>count,
                data_out=>data_out
        
         );
    
    uc:uc_a 
        Port Map( 
                clk     =>clk,
                rst     =>rst,
                start   =>start,
                en_count=>en_count,
                read_rom=>read_rom,
                req     =>req,
                ack     =>ack,
                count   =>count
        );
end Structural;
