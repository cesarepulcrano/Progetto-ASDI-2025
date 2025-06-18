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
    Generic(N: natural :=4);    
    Port (
                clk : in STD_LOGIC;
                rst : in STD_LOGIC;
                start: in std_logic;
                save: in std_logic;
                second:    out std_logic_vector(5 downto 0);
                minute:    out std_logic_vector(5 downto 0);
                hour  :    out std_logic_vector(4 downto 0);
                intertempo_second: out std_logic_vector(5 downto 0);
                intertempo_minute: out std_logic_vector(5 downto 0);
                intertempo_hour: out std_logic_vector(4 downto 0)
     );
    end component;

    signal output_second : std_logic_vector(5 downto 0);
    signal output_minute : std_logic_vector(5 downto 0);
    signal output_hour : std_logic_vector(4 downto 0);
    signal intertempo_second_sig: std_logic_vector(5 downto 0);
    signal intertempo_minute_sig: std_logic_vector(5 downto 0);
    signal intertempo_hour_sig: std_logic_vector(4 downto 0);
    signal clock:  std_logic;
    signal period: time := 10 ns;
    signal save: std_logic;
    signal start: std_logic;
begin

    uut:cronometro_intertempi
    Generic Map(N=>4)
    Port Map(  CLK=>clock,
            RST=>'0',
            start=>start,
            save=>save,
            second=>   output_second,
            minute=>   output_minute,
            hour  =>   output_hour,
            intertempo_second =>intertempo_second_sig,
            intertempo_minute =>intertempo_minute_sig,
            intertempo_hour   =>intertempo_hour_sig
            
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
        start<='1';
        wait for 10 ns;
        save<='1';
        wait for 100 ns;
        save<='0';
        start<='0';
        
               
        wait;
    end process;    
end Behavioral;
