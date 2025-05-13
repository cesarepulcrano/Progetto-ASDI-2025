----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2025 07:20:59 PM
-- Design Name: 
-- Module Name: booth_multiplier - Structural
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
use IEEE.math_real.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity booth_multiplier is
    Generic(N: natural :=8);
    Port (  CLK:    in  std_logic;
            RST:    in  std_logic;
            ENABLE: in  std_logic;
            X:      in  std_logic_vector(N-1 downto 0);
            Y:      in  std_logic_vector(N-1 downto 0);
            output: out std_logic_vector(2*N-1 downto 0) 
     );
end booth_multiplier;

architecture Structural of booth_multiplier is
    
    component control_unit is
        Generic(N: natural:=8);
        Port (  CLK: in std_logic;
                RST: in std_logic;
                ENABLE: in  std_logic;
                Q0: in std_logic;
                Q1: in std_logic;
                count:  in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
                
                SHIFT:out std_logic;
                LOAD_A: out std_logic;
                LOAD_Q: out std_logic;
                LOAD_M: out std_logic;
                SUBTRACT: out std_logic;
                init: out std_logic;
                en_count:   out std_logic
                
         );
    end component;
    
    component operational_unit is
        GENERIC(N: natural :=8);
        Port (  CLK: in std_logic;
                RST: in std_logic;
                X:  in  std_logic_vector(  N-1 downto 0);
                Y:  in  std_logic_vector(  N-1 downto 0);
                init: in std_logic;
                SHIFT:  in std_logic;
                LOAD_A: in std_logic;
                LOAD_Q: in std_logic;
                LOAD_M: in std_logic;
                SUBTRACT: in std_logic;
                en_count: in std_logic;
                Q0: out std_logic;
                Q1: out std_logic;
                count:  out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
                output:  out  std_logic_vector(  2*N-1 downto 0)
            
     );
    end component;
    
    signal Q0: std_logic;
    signal Q1: std_logic;
    signal count:  std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
    signal SHIFT: std_logic;
    signal LOAD_A:  std_logic;
    signal LOAD_Q:  std_logic;
    signal LOAD_M:  std_logic;
    signal SUBTRACT:  std_logic;
    signal en_count:    std_logic ;
    signal init_signal: std_logic;
    
begin

    cu: control_unit
        Generic Map(N=>N) 
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    ENABLE=>ENABLE, 
                    
                    Q0=>Q0,
                    Q1=>Q1,
                    count=>count,  
                    SHIFT=>SHIFT,
                    LOAD_A =>LOAD_A,
                    LOAD_Q =>LOAD_Q,
                    LOAD_M=>LOAD_M,
                    SUBTRACT=>SUBTRACT,
                    init=>init_signal,
                    en_count=>en_count
         );
         
    ou: operational_unit
        Generic Map(N=>N)
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    X=>X,
                    Y=>Y,
                    init=>init_signal,
                    SHIFT=>SHIFT, 
                    LOAD_A=>LOAD_A,
                    LOAD_Q=>LOAD_Q,
                    LOAD_M=>LOAD_M,
                    SUBTRACT=>SUBTRACT,
                    en_count=>en_count,
                    Q0=>Q0,
                    Q1=>Q1,
                    count=>count, 
                    output=>output   
         );
     
end Structural;