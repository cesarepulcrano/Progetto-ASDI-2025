----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2025 18:18:05
-- Design Name: 
-- Module Name: PO - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM is
    Generic(N : natural :=8;
            M : natural :=8);
    Port (  CLK : in std_logic;
            RST : in std_logic;
            EN  : in std_logic;
            data_in : in std_logic_vector(M-1 downto 0);
            address : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0); -- Codifica da 0 a N-1
            data_out : out std_logic_vector(M-1 downto 0)
    );
end MEM;

architecture Behavioral of MEM is
    type MEMORY_N_M is array (0 to N-1) of std_logic_vector(M-1 downto 0); -- Matrice N x M
--    signal initial  :  std_logic_vector(to_unsigned(U,integer(ceil(log2(real(M))))));
--      signal MEM_DATA : MEMORY_N_M ;
--      MEM_DATA<=initial;
    signal MEM_DATA : MEMORY_N_M := (others => "UUUUUUUUUUUUUUUUU");
begin
    process(CLK)
    begin
        if(CLK'event AND CLK = '1') then
            if(EN = '1') then
                MEM_DATA(to_integer(unsigned(address))) <= data_in; -- Casting da unsigned a intero
            elsif(RST = '1') then
                MEM_DATA <= (others => "00000000000000000");
            end if;
        end if;
    end process;
    
    data_out <= MEM_DATA(to_integer(unsigned(address)));
    
end architecture Behavioral;
