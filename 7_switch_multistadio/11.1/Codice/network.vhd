----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 01:13:15 PM
-- Design Name: 
-- Module Name: network - Structural
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

entity network is
    Generic (N:natural:=4);
    Port (
            n0 : in STD_LOGIC_VECTOR (1 downto 0);
            n1 : in STD_LOGIC_VECTOR (1 downto 0);
            n2 : in STD_LOGIC_VECTOR (1 downto 0);
            n3 : in STD_LOGIC_VECTOR (1 downto 0);
            source : in STD_LOGIC_VECTOR(integer(ceil(log2(real(N))))-1 downto 0);
            dest : in STD_LOGIC_VECTOR(integer(ceil(log2(real(N))))-1 downto 0);
            y0 : out STD_LOGIC_VECTOR (1 downto 0);
            y1 : out STD_LOGIC_VECTOR (1 downto 0);
            y2 : out STD_LOGIC_VECTOR (1 downto 0);
            y3 : out STD_LOGIC_VECTOR (1 downto 0)
     );
end network;

architecture Structural of network is
    
    component switch is
        Port ( 
                x0 : in STD_LOGIC_VECTOR (1 downto 0);
                x1 : in STD_LOGIC_VECTOR (1 downto 0);
                s_in : in STD_LOGIC;
                s_out : in STD_LOGIC;
                y0 : out STD_LOGIC_VECTOR (1 downto 0);
                y1 : out STD_LOGIC_VECTOR (1 downto 0)
               );
    end component;
    
    
    signal s0_out0: std_logic_vector(1 downto 0);
    signal s0_out1: std_logic_vector(1 downto 0);
    signal s1_out0: std_logic_vector(1 downto 0);
    signal s1_out1: std_logic_vector(1 downto 0);

    
begin
    
    -- 0 1 2 3
    -- 0 2 1 3
--    s   d
--    1   3
--    00  11
    s0:switch 
        Port Map( 
                x0=>n0,
                x1=>n1,
                s_in=>source(0),
                s_out=>dest(0),
                y0=>s0_out0 ,
                y1=>s0_out1
               );
    
    s1:switch 
        Port Map( 
                x0=>n2,
                x1=>n3,
                s_in=>source(0),
                s_out=>dest(0),
                y0=>s1_out0, 
                y1=>s1_out1
               );
    
    s2:switch 
        Port Map( 
                x0=>s0_out0,
                x1=>s1_out0,
                s_in=>source(1),
                s_out=>dest(1),
                y0=>y0,
                y1=>y1
               );           
    
    s3:switch 
        Port Map( 
                x0=>s0_out1,
                x1=>s1_out1,
                s_in=>source(1),
                s_out=>dest(1),
                y0=>y2,
                y1=>y3
               );
    
    

end Structural;
