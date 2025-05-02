----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2025 08:33:59 PM
-- Design Name: 
-- Module Name: cronometro_tb - Behavioral
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

entity cronometro_tb is
--  Port ( );
end cronometro_tb;

architecture Behavioral of cronometro_tb is
    
    component cronometro_b is
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
end component;
        signal clock: std_logic;
        signal sec: std_logic_vector(5 downto 0):=(others=>'0');
        signal min: std_logic_vector(5 downto 0):=(others=>'0');
        signal hour: std_logic_vector(4 downto 0):=(others=>'0');
        signal r: std_logic;
        
        
        signal sec_in: std_logic_vector(5 downto 0):=(others=>'0');
        signal min_in: std_logic_vector(5 downto 0):=(others=>'0');
        signal hour_in: std_logic_vector(4 downto 0):=(others=>'0');
        signal set_l : std_logic;
        
        signal cout: std_logic;
        constant CLK_period : time := 10 ns;
begin
    
    uut:cronometro_b
        port map(   CLK=>clock,
                    RST=>r,
                    set=>set_l,
                    
                    load_second=>sec_in,
                    load_minute=>min_in,
                    load_hour=>hour_in,
                    
                    cont_second=>sec,
                    cont_minute=>min,
                    cont_hour=>hour,
                    
                    c_out =>cout
        );    
    CLK_process :process
        begin
            clock <= '0';
            wait for CLK_period/2;
        
            clock <= '1';
            wait for CLK_period/2;
       
   end process;
    
    stim_proc: process
        begin
        
        set_l<='1';
        sec_in<="011101";
        min_in<="111010";
        hour_in<="10111";
        wait for 90 ns;
        set_l<='0';
        wait for 200000 ms;
  
        end process;


end Behavioral;
