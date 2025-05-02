----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2025 17:03:40
-- Design Name: 
-- Module Name: shift_register_behavioral_tb - Behavioral
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

entity shift_register_behavioral_tb is
end shift_register_behavioral_tb;

architecture Behavioral of shift_register_behavioral_tb is
    
    component shift_register_behavioral is
        Generic(N : integer := 4);
        Port (  input   : in std_logic;
                RST     : in std_logic;
                LOAD    : in std_logic;
                CLK     : in std_logic; -- Abilitazione
                s       : in std_logic; -- 0 = shift a destra, 1 = shift a sinistra
                Y       : in std_logic; -- 0 = shift di 1 bit, 1 = shift di 2 bit
                output  : out std_logic_vector(N-1 downto 0)
        );
    end component;
    
    signal input : std_logic;
    signal load :   std_logic;
    signal clock:   std_logic;
    signal reset:   std_logic;
    signal s: std_logic;
    signal y: std_logic;
    signal output: std_logic_vector(4-1 downto 0);
    constant period: time := 10 ns;    
begin
    
    uut: shift_register_behavioral 
        Port Map(   input=>input,
                    RST=>reset,
                    LOAD=>load,
                    CLK=>clock,
                    s=>s,
                    Y=>y,
                    output=>output
        );
    
    clock_proc: process
    begin
        clock<='0';
        wait for period/2;
        clock<='1';
        wait for period/2;
    end process;
    --1001
    stim_proc: process
    begin
    
    wait for 10 ns;
    s<='0'; -- Shift a destra
    y<='0'; -- 1 bit

    wait for 5 ns;
    load<='1';
    input <= '1';

    wait for 5 ns;
    load<='0';
    
    wait for 10 ns;
    s<='1'; -- Shift a sinistra
    y<='0'; -- 1 bit
    
    wait for 5 ns;
    load<='1';
    input <= '1';
    
    wait for 5 ns;
    load<='0';
    
    wait for 10 ns;
    s<='0'; -- Shift a destra
    y<='1'; -- 2 bit
    
    wait for 5 ns;
    load<='1';
    input <= '1';
    
    wait for 5 ns;
    load<='0';
    
    wait for 10 ns;
    s<='1'; -- Shift a sinistra
    y<='1'; -- 2 bit
    
    wait for 5 ns;
    load<='1';
    input <= '1';
    
    wait for 5 ns;
    load<='0';

    wait;
    end process;

end Behavioral;
