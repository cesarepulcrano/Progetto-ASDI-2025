----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2025 03:19:02 AM
-- Design Name: 
-- Module Name: cronometro_intertempi_uc - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cronometro_intertempi_uc is
    Generic(N: natural:=4);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start: in std_logic;
           en_count : out STD_LOGIC;
           save: in std_logic;
           write_mem : out STD_LOGIC;
           count : in STD_LOGIC_VECTOR (integer(ceil(log2(real(N))))-1 downto 0));
end cronometro_intertempi_uc;

architecture Behavioral of cronometro_intertempi_uc is
    type state is (idle,wait_write,write,increment);
    signal stato_corrente:state :=idle;
    signal stato_prossimo:state;
begin
    
    comb:process(stato_corrente,start,save)
    begin
        case stato_corrente is
            when idle =>
                en_count<='0';
                if(start='0') then
                    stato_prossimo<=idle;
                else
                    stato_prossimo<=wait_write;
                end if;
            when wait_write =>
                en_count<='0';
                if(save='1') then
                    stato_prossimo<=write;
                else
                    stato_prossimo<=wait_write;
                end if;
            when write =>
                write_mem<='1';
                stato_prossimo<=increment;
            when increment=>
                write_mem<='0';
                en_count<='1';
                if(count="0000") then
                    stato_prossimo<=idle;
                else 
                    stato_prossimo<=wait_write;
                end if; 
        end case;                                       
    end process;
    
    mem: process(clk)
    begin
        if clk'event and clk = '1' then
           if rst = '1' then
                    stato_corrente<=idle;
           else
                  stato_corrente<=stato_prossimo;
           end if;
         end if;
    end process;

end Behavioral;
