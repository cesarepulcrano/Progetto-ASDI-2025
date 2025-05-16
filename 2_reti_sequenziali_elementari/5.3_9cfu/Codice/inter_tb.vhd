----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 06:38:30 PM
-- Design Name: 
-- Module Name: inter_tb - Behavioral
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

entity inter_tb is
--  Port ( );
end inter_tb;

architecture Behavioral of inter_tb is
    component cronometro_intertempi is
    Generic(N: natural:=4);
    Port (  CLK: in std_logic;
            RST: in std_logic;
            set: in std_logic;
            load_second:in std_logic_vector(5 downto 0);
            load_minute: in std_logic_vector(5 downto 0);
            load_hour:  in std_logic_vector(4 downto 0);
            cont_second:    out std_logic_vector(5 downto 0);
            cont_minute:    out std_logic_vector(5 downto 0);
            cont_hour  :    out std_logic_vector(4 downto 0);
            
            stop:   in std_logic;
            c_out       :   out std_logic
        );
end component;

    signal output : std_logic_vector(17 downto 0);
    signal clock:  std_logic;
    signal period: time := 10 ns;
    signal stop: std_logic;
begin

    uut:cronometro_intertempi
    Generic Map(N=>4)
    Port Map(  CLK=>clock,
            RST=>'0',
            set=>'0',
            load_second=>(others=>'0'),
            load_minute=>(others=>'0'),
            load_hour=>(others=>'0'),
            cont_second=>output(5 downto 0),
            cont_minute=>   output(11 downto 6),
            cont_hour  =>   output(16 downto 12),
            
            stop=>clock
        );
        
    cl:process
    begin
        clock<='0';
        wait for period/2;
        clock<='1';
        wait for period/2;
    end process;     
    
    stim:process
    begin
        wait for 10 ns;
        stop<='1';
--        wait for 70 ns;
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
        
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
        
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
        
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
--        stop<='1';
--        wait for period;
--        stop<='0';
--        wait for period;
        
        
               
        wait;
    end process;    
end Behavioral;
