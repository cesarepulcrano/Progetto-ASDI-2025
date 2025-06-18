----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2025 16:15:07
-- Design Name: 
-- Module Name: shift_register_behavioral - Behavioral
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

entity shift_register is
    Generic(N : integer := 8);
    Port (  clk     : in std_logic;
            rst     : in std_logic;
            en     : in std_logic;
            input   : in std_logic;
            load    : in std_logic;
            data_in: in std_logic_vector(N-1 downto 0);
            serial_out: out std_logic;
            output  : out std_logic_vector (N-1 downto 0)
    );
end shift_register;

architecture Behavioral of shift_register is

    signal output_temp : std_logic_vector (N-1 downto 0) := (others => '0');
    signal serial_out_temp :std_logic;
begin
    
    mem: process(clk)
    begin
        if(clk'event and clk = '1') then
            if(rst = '1') then
                output_temp <= (others => '0');
            elsif(load = '1') then
                output_temp<=  data_in;
                serial_out_temp<=output_temp(N-1);  
            elsif(EN = '1') then
                serial_out_temp<=output_temp(N-1);
                output_temp(N-1 downto 1) <= output_temp(N-2 downto 0);
                output_temp(0) <= input;
            end if;
        end if;
    end process;
    
    output <= output_temp; 
    serial_out<=serial_out_temp;
end Behavioral;
