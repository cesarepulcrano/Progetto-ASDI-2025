----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2025 11:58:14 AM
-- Design Name: 
-- Module Name: omega_collision_tb - Behavioral
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

entity omega_collision_tb is
--  Port ( );
end omega_collision_tb;

architecture Behavioral of omega_collision_tb is
    component network is
    Port (  clk : std_logic;
            rst: std_logic;
            n0 : in STD_LOGIC_VECTOR (6 downto 0);
            n1 : in STD_LOGIC_VECTOR (6 downto 0);
            n2 : in STD_LOGIC_VECTOR (6 downto 0);
            n3 : in STD_LOGIC_VECTOR (6 downto 0);
            n4 : in STD_LOGIC_VECTOR (6 downto 0);
            n5 : in STD_LOGIC_VECTOR (6 downto 0);
            n6 : in STD_LOGIC_VECTOR (6 downto 0);
            n7 : in STD_LOGIC_VECTOR (6 downto 0);

            y0 : out STD_LOGIC_VECTOR (6 downto 0);
            y1 : out STD_LOGIC_VECTOR (6 downto 0);
            y2 : out STD_LOGIC_VECTOR (6 downto 0);
            y3 : out STD_LOGIC_VECTOR (6 downto 0);
            y4 : out STD_LOGIC_VECTOR (6 downto 0);
            y5 : out STD_LOGIC_VECTOR (6 downto 0);
            y6 : out STD_LOGIC_VECTOR (6 downto 0);
            y7 : out STD_LOGIC_VECTOR (6 downto 0)
            
     );
end component;
    signal n0 : std_logic_vector(6 downto 0);
    signal n1 : std_logic_vector(6 downto 0);
    signal n2 : std_logic_vector(6 downto 0);
    signal n3 : std_logic_vector(6 downto 0);
    signal n4 : std_logic_vector(6 downto 0);
    signal n5 : std_logic_vector(6 downto 0);
    signal n6 : std_logic_vector(6 downto 0);
    signal n7 : std_logic_vector(6 downto 0);
                                 
    signal y0 : std_logic_vector(6 downto 0);
    signal y1 : std_logic_vector(6 downto 0);
    signal y2 : std_logic_vector(6 downto 0);
    signal y3 : std_logic_vector(6 downto 0);
    signal y4 : std_logic_vector(6 downto 0);
    signal y5 : std_logic_vector(6 downto 0);
    signal y6 : std_logic_vector(6 downto 0);
    signal y7 : std_logic_vector(6 downto 0);
    signal clock: std_logic;
    signal rst: std_logic;
    signal period: time:= 10 ns;
    
begin
    
    cprocess:process
    begin
        clock<='0';
        wait for period/2;
        clock<='1';
        wait for period/2;    
    end process;
    
    uut:network 
        Port Map(
                clk=>clock,
                rst=>rst,
                
                n0 =>n0,
                n1 =>n1,
                n2 =>n2,
                n3 =>n3,
                n4 =>n4,
                n5 =>n5,
                n6 =>n6,
                n7 =>n7,
                y0 =>y0,
                y1 =>y1,
                y2 =>y2,
                y3 =>y3,
                y4 =>y4,
                y5 =>y5,
                y6 =>y6,
                y7 =>y7
                
         );
    
    stim:process
    begin
        
        n0<="1000001";
        n1<="1001001";
        n2<="1010010";
        n3<="1011011";
        n4<="1100100";
        n5<="1101101";
        n6<="1110110";
        n7<="1111111";
        wait for 30 ns;
        n0<="0000001";
        n1<="0001001";
        n2<="0010010";
        n3<="0011011";
        n4<="0100100";
        n5<="0101101";
        n6<="0110110";
        n7<="0111111";
        wait;
    end process;
end Behavioral;
