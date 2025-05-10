----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2025 12:08:53 PM
-- Design Name: 
-- Module Name: mux_16_1_tb - mux_16_1
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
use work.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_16_1_tb is
end mux_16_1_tb;

architecture behavioral of mux_16_1_tb is
    
    component mux_16_1
        
        port(   x   : in std_logic_vector (15 downto 0);
                s0  : in    STD_LOGIC;
                s1  : in    STD_LOGIC;
                s2  : in    STD_LOGIC;
                s3   : in    STD_LOGIC;
                y0   : out   STD_LOGIC
        
        );
    end component;
    
    signal input    :   std_logic_vector (15 downto 0 )  := (others => 'U');
    signal control  :   std_logic_vector (3 downto 0)   := (others => 'U');
    signal output   :   std_logic :='U';   
    
begin
    
    uut: entity work.mux_16_1(Structural)
        port map(   x => input,
                    s0 => control(0),
                    s1 => control(1),
                    s2 => control(2),
                    s3 => control(3),
                    y0 => output
        );



    stim_proc: process
    begin
    
    wait for 100 ns;
    
    input <= "1000000010000000";
    
    wait for 50 ns;
    control <= "0000";

    wait for 50 ns;
    control <="1111";
    --control <="1111"; --13 in binario reverse

    wait for 50 ns;
    control <= "0111";
    
    wait for 50 ns;
    
    assert output = '0'
    report "error"
    severity failure;
    
    wait;
    end process;
end ;
