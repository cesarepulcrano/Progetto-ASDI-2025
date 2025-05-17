----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 04:57:20 PM
-- Design Name: 
-- Module Name: omega_tb - Behavioral
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

entity omega_tb is
--  Port ( );
end omega_tb;

architecture Behavioral of omega_tb is
    component omega_network_prio_fissa is
        Generic(N: natural:=4);
        Port ( 
                    message0 : in  std_logic_vector(5 downto 0);
                    message1 : in  std_logic_vector(5 downto 0);
                    message2 : in  std_logic_vector(5 downto 0);
                    message3 : in  std_logic_vector(5 downto 0);
                    r0 : in STD_LOGIC;
                    r1 : in STD_LOGIC;
                    r2 : in STD_LOGIC;
                    r3 : in STD_LOGIC;
                    y0 : out STD_LOGIC_VECTOR (1 downto 0);
                    y1 : out STD_LOGIC_VECTOR (1 downto 0);
                    y2 : out STD_LOGIC_VECTOR (1 downto 0);
                    y3 : out STD_LOGIC_VECTOR (1 downto 0) 
        
        );
    end component;
    
    signal message0 : std_logic_vector(5 downto 0);
    signal message1 : std_logic_vector(5 downto 0);
    signal message2 : std_logic_vector(5 downto 0);
    signal message3 : std_logic_vector(5 downto 0);
    signal r0 : STD_LOGIC;
    signal r1 : STD_LOGIC;
    signal r2 : STD_LOGIC;
    signal r3 : STD_LOGIC;
    signal y0 :  STD_LOGIC_VECTOR (1 downto 0);
    signal y1 :  STD_LOGIC_VECTOR (1 downto 0);
    signal y2 :  STD_LOGIC_VECTOR (1 downto 0);
    signal y3 :  STD_LOGIC_VECTOR (1 downto 0) ;
    
begin
    uut:omega_network_prio_fissa 
        
        Port Map( 
                    message0 =>message0 ,
                    message1 =>message1 ,
                    message2 =>message2 ,
                    message3 =>message3 ,
                    r0       =>r0       ,
                    r1       =>r1       ,
                    r2       =>r2       ,
                    r3       =>r3       ,
                    y0       =>y0       ,
                    y1       =>y1       ,
                    y2       =>y2       ,
                    y3       =>y3       
        
        );
    
    
    stim:process
    begin
        wait for 10 ns;
        message0<="001001";
        message1<="010001";
        message2<="100000";
        message3<="110011";
        r0<='0';
        r1<='1';
        r2<='1';
        r3<='1';
        wait for 10 ns;
        r0<='0';
        r1<='0';
        r2<='0';
        r3<='1';
        wait;
    end process;
end Behavioral;
