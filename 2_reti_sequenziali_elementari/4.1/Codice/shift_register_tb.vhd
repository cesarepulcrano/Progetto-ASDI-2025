----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2025 11:07:45 AM
-- Design Name: 
-- Module Name: shift_register_tb - Behavioral
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

entity shift_register_tb is
--  Port ( );
end shift_register_tb;

architecture Behavioral of shift_register_tb is
    
    component shift_register is
        Generic(N : integer := 4);
        Port (  CLK     : in std_logic; -- Abilitazione
                RST     : in std_logic;
                input   : in std_logic;
                LOAD    : in std_logic;
                load_data: in std_logic_vector(N-1 downto 0);
                EN : in std_logic;
                s       : in std_logic; -- 0 = shift a destra, 1 = shift a sinistra
                Y       : in std_logic; -- 0 = shift di 1 bit, 1 = shift di 2 bit
                output  : out std_logic_vector (N-1 downto 0)
    );
    end component;
    
    signal input : std_logic;
    signal load :   std_logic;
    signal clock:   std_logic;
    signal reset:   std_logic;
    signal s: std_logic;
    signal y: std_logic;
    signal output: std_logic_vector(4-1 downto 0):=(others=>'0');
    signal data: std_logic_vector(4-1 downto 0):=(others=>'0');
    signal enable : std_logic:='0';
    constant period: time := 10 ns;    
begin
    
    uut: shift_register 
        Port Map(   input=>input,
                    RST=>reset,
                    LOAD=>load,
                    load_data=>data,
                    CLK=>clock,
                    EN =>enable,
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
    reset<='0';
    enable<='1';
    load<='1';
    data<="1111";
    
    wait for 10 ns;
    enable<='0';
    reset<='0';
    load<='0';
    
    s<='1';
    y<='1';
    input <= '0';


    wait for 10 ns;
--    input<='0';
--    wait for 10 ns;
--    input<='0';
--    wait for 10 ns;
--    input<='0';
--    wait for 10 ns;
--    input<='0';
--    wait for 10 ns; 
--    load<='0';
    --start
    
    wait for 5 ns;
    enable<='1';
    input <= '0';

    wait for 5 ns;
    enable<='1';
    
    wait for 5 ns;
    enable<='1';
    input <= '0';

    wait for 5 ns;
    enable<='1';
    
    wait for 5 ns;
    enable<='1';
    input <= '0';

    wait for 5 ns;
    enable<='1';
    
    wait for 5 ns;
    enable<='1';
    input <= '0';

    wait for 5 ns;
    enable<='1';
    wait;
    end process;

end Behavioral;
