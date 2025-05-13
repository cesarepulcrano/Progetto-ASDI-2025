----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2025 06:44:13 PM
-- Design Name: 
-- Module Name: cronometro_b - Structural
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
-- 23 59 59 00 00 00

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cronometro is
    Port (  CLK: in std_logic;
            RST: in std_logic;
            set: in std_logic;
            
            load_second:in std_logic_vector(5 downto 0);
            load_minute: in std_logic_vector(5 downto 0);
            load_hour:  in std_logic_vector(4 downto 0);
            
            cont_second:    out std_logic_vector(5 downto 0);
            cont_minute:    out std_logic_vector(5 downto 0);
            cont_hour  :    out std_logic_vector(4 downto 0);
            
            c_out       :   out std_logic
    );
end cronometro;


architecture Structural of cronometro is
    
     component divisore_di_frequenza is
        generic(
        CLKIN_freq  : integer := 100000000;  -- clock board 100MHz
        CLKOUT_freq : integer := 1           -- frequenza desiderata 1Hz
        );
        Port (
            clock_in  : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            clock_out : out STD_LOGIC
        );
    end component;
    
    component contatore_mod_N is
    Generic (N: integer :=60);
        Port (      clock   :   in  std_logic;
                    reset   :   in  std_logic;
                    set     :   in  std_logic;
                    load    :   in  std_logic_vector(integer(ceil(log2(real(N))))-1 downto  0);
                    cont    :   out  std_logic_vector(integer(ceil(log2(real(N))))-1    downto  0);
                    co      :   out std_logic
        ); 
    end component;
    
    component and_gate is
        Port ( a: in std_logic; b: in std_logic; y: out std_logic);
    end component;
    
    signal clk_wave:    std_logic;
    signal second_to_and: std_logic;
    signal minute_to_and: std_logic;
    signal and_to_and:  std_logic;
    
    signal minute_en: std_logic;
    signal hour_en: std_logic;

    
begin
    
    divisore: divisore_di_frequenza 
        generic map(
        CLKIN_freq=>100000000,  -- clock board 100MHz
        CLKOUT_freq=>1           -- frequenza desiderata 1Hz
        )
        Port map(
            clock_in=>CLK,
            reset=>RST,
            clock_out=>clk_wave
        );
    
    secondi: contatore_mod_N 
        Generic Map(N=>60)
        
        Port Map(   clock=>CLK,
                    reset=>RST,
                    set=>set,
                    load=>load_second,
                    cont=>cont_second,
                    co=>second_to_and
        );
    
    second_to_minute: and_gate
        Port Map( a=>CLK,
                  b=>second_to_and,
                  y=>minute_en
        );
    
    minuti: contatore_mod_N 
        Generic Map(N=>60)
        
        Port Map(   clock=>minute_en,
                    reset=>RST,
                    set=>set,
                    load=>load_minute,
                    cont=>cont_minute,
                    co=>minute_to_and
        ); 
    
    and1: and_gate
        Port Map( a=>CLK,
                  b=>minute_to_and,
                  y=>and_to_and
        );
        
    and2: and_gate
        Port Map( a=>and_to_and,
                  b=>second_to_and,
                  y=>hour_en
        );
     --hour_en  <= second_to_and AND minute_to_and AND CLK;              
    ore: contatore_mod_N 
        Generic Map(N=>24)
        Port Map(   clock=>hour_en,
                    reset=>RST,
                    set=>set,
                    load=>load_hour,
                    cont=>cont_hour,
                    co=>c_out
        );
        
end Structural;