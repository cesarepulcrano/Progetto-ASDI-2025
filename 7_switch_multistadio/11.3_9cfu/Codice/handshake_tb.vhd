----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2025 06:19:21 PM
-- Design Name: 
-- Module Name: handshake_tb - Behavioral
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

entity handshake_tb is
--  Port ( );
end handshake_tb;

architecture Behavioral of handshake_tb is
    component handshake_omega_network is
        Port (
                clk                 : in std_logic;
                rst                 : in std_logic;
                invia_a             : in std_logic;
                invia_b             : in std_logic;
                dato_ricevuto_a     : out std_logic_vector(1 downto 0);
                dato_ricevuto_b     : out std_logic_vector(1 downto 0)
         );
    end component;
    
    signal clock   :std_logic;
    signal rst     :std_logic;
    signal invia_a :std_logic;
    signal invia_b :std_logic;
    signal period  :time :=10 ns;
    signal datoa :std_logic_vector(1 downto 0);
    signal datob :std_logic_vector(1 downto 0);
    
    
    
    
begin
    
    uut:handshake_omega_network
        Port Map(
                clk            =>clock,
                rst            =>rst,
                invia_a        =>invia_a,
                invia_b        =>invia_b,
                dato_ricevuto_a=>datoa,
                dato_ricevuto_b=>datob
         );
    
    cprocess:process
    begin
        clock<='0';
        wait for period/2;
        clock<='1';
        wait for period/2;
    end process;
    
    stim:process
    begin
        wait for 10 ns;
        rst<='1';
        wait for 10 ns;
        rst<='0';
        invia_b<='1';
        invia_a<='0';
        wait for 100 ns;
        invia_a<='0';
        invia_b<='0';
        wait for 10 ns;
        invia_a<='1';
        invia_b<='0';
        wait for 100 ns;
        invia_a<='0';
        invia_b<='0';
        wait;
    end process;
    
end Behavioral;
