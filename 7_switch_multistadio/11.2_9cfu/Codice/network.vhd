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
    Port (  
            clk : std_logic;
            rst: std_logic;
            n0 : in STD_LOGIC_VECTOR (6 downto 0);
            n1 : in STD_LOGIC_VECTOR (6 downto 0);
            n2 : in STD_LOGIC_VECTOR (6 downto 0);
            n3 : in STD_LOGIC_VECTOR (6 downto 0);
            n4 : in STD_LOGIC_VECTOR (6 downto 0);
            n5 : in STD_LOGIC_VECTOR (6 downto 0);
            n6 : in STD_LOGIC_VECTOR (6 downto 0);
            n7 : in STD_LOGIC_VECTOR (6 downto 0);
--            source : in STD_LOGIC_VECTOR(2 downto 0);
--            dest : in STD_LOGIC_VECTOR(2 downto 0);
            y0 : out STD_LOGIC_VECTOR (6 downto 0);
            y1 : out STD_LOGIC_VECTOR (6 downto 0);
            y2 : out STD_LOGIC_VECTOR (6 downto 0);
            y3 : out STD_LOGIC_VECTOR (6 downto 0);
            y4 : out STD_LOGIC_VECTOR (6 downto 0);
            y5 : out STD_LOGIC_VECTOR (6 downto 0);
            y6 : out STD_LOGIC_VECTOR (6 downto 0);
            y7 : out STD_LOGIC_VECTOR (6 downto 0)
            
     );
end network;

architecture Structural of network is
    
    component switch is
        Generic(Stage: natural :=0);
        Port (  clk : std_logic;
                rst: std_logic;
                x0 : in STD_LOGIC_VECTOR (6 downto 0);
                x1 : in STD_LOGIC_VECTOR (6 downto 0);
                y0 : out STD_LOGIC_VECTOR (6 downto 0);
                y1 : out STD_LOGIC_VECTOR (6 downto 0)
               );
    end component;
    
    type switch_out is array (0 to 1) of std_logic_vector(6 downto 0);
    type stage_out is array (0 to 3) of switch_out;
    signal stage0_out:stage_out;
    signal stage1_out:stage_out; 

begin
    
    
     
    stage0: block
    begin

    s0:switch
        Generic Map(Stage=>0)     
        Port Map(
                clk=>clk,
                rst=>rst,     
                x0=>n0,
                x1=>n4,
                y0=>stage0_out(0)(0) ,
                y1=>stage0_out(0)(1)
               );
    
    s1:switch
        Generic Map(Stage=>0) 
        Port Map( clk=>clk,
                rst=>rst,
                x0=>n1,
                x1=>n5,
                y0=>stage0_out(1)(0), 
                y1=>stage0_out(1)(1)
               );
               
    s2:switch
    Generic Map(Stage=>0) 
        Port Map( clk=>clk,
                rst=>rst,
                x0=>n2,
                x1=>n6,
                y0=>stage0_out(2)(0), 
                y1=>stage0_out(2)(1)
               );           
    
    s3:switch 
    Generic Map(Stage=>0)
        Port Map( clk=>clk,
                rst=>rst,
                x0=>n3,
                x1=>n7,
                y0=>stage0_out(3)(0), 
                y1=>stage0_out(3)(1)
               );
    --stage 1
    end block stage0;
    
    stage1: block
    begin
  
    s0:switch 
    Generic Map(Stage=>1)
        Port Map( clk=>clk,
                rst=>rst,
                x0=>stage0_out(0)(0),
                x1=>stage0_out(2)(0),
                y0=>stage1_out(0)(0),
                y1=>stage1_out(0)(1)
               );           
    
    s1:switch 
    Generic Map(Stage=>1)
        Port Map( clk=>clk,
                rst=>rst,
                x0=>stage0_out(0)(1),
                x1=>stage0_out(2)(1),
                y0=>stage1_out(1)(0),
                y1=>stage1_out(1)(1)
               );
    
    s2:switch 
    Generic Map(Stage=>1)
        Port Map( clk=>clk,
                rst=>rst,
                x0=>stage0_out(1)(0),
                x1=>stage0_out(3)(0),
                y0=>stage1_out(2)(0),
                y1=>stage1_out(2)(1)
               );
    
    s3:switch 
    Generic Map(Stage=>1)
        Port Map( clk=>clk,
                rst=>rst,
                x0=>stage0_out(1)(1),
                x1=>stage0_out(3)(1),
                y0=>stage1_out(3)(0),
                y1=>stage1_out(3)(1)
               );
    end block stage1;
    stage2: block
    begin

    s0:switch 
    Generic Map(Stage=>2)
        Port Map( 
        clk=>clk,
                rst=>rst,
                x0=>stage1_out(0)(0),
                x1=>stage1_out(2)(0),
                y0=>y0 ,
                y1=>y1
               );
    
    s1:switch 
    Generic Map(Stage=>2)
        Port Map( clk=>clk,
                rst=>rst,
                x0=>stage1_out(0)(1),
                x1=>stage1_out(2)(1),
                y0=>y2, 
                y1=>y3
               );
               
    s2:switch 
    Generic Map(Stage=>2)
        Port Map( clk=>clk,
                rst=>rst,
                x0=>stage1_out(1)(0),
                x1=>stage1_out(3)(0),
                y0=>y4, 
                y1=>y5
               );           
    
    s3:switch 
    Generic Map(Stage=>2)
        Port Map( clk=>clk,
                rst=>rst,
                x0=>stage1_out(1)(1),
                x1=>stage1_out(3)(1),
                y0=>y6, 
                y1=>y7
               );
    --stage 1
    end block stage2;
    
end Structural;
