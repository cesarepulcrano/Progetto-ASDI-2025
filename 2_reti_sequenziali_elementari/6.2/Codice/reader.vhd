----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2025 11:24:08 AM
-- Design Name: 
-- Module Name: reader - Behavioral
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

entity reader is
    Port (  CLK:    in  std_logic;
            RST:    in  std_logic;
            READ:   in  std_logic;
            data_in:in  std_logic_vector(3 downto 0);
            ENABLE: out  std_logic;
            output: out std_logic_vector(3 downto 0)
          );
end reader;

architecture Behavioral of reader is
    type state is (IDLE,READ_STATE);
    signal stato_corrente: state := IDLE;
    signal stato_prossimo: state;
    signal dato_attuale:   std_logic_vector(3 downto 0):=(others=>'0'); 
begin
    
    comb:process(stato_prossimo,READ)
        begin
            case stato_corrente is
                when IDLE =>
                    ENABLE<='0';
                    if(READ='1') then
                        stato_prossimo<=READ_STATE;
                    else
                        stato_prossimo<=IDLE;
                    end if; 
                when READ_STATE =>
                    ENABLE<='1';
                    if(data_in /= dato_attuale) then
                        dato_attuale<=data_in;
                        stato_prossimo<=IDLE;
                    else
                        stato_prossimo<=READ_STATE;
                    end if;
                    
             end case;           
        end process;
    
    output<=dato_attuale;
    
    mem:process(CLK)
        begin
            if(rising_edge(CLK)) then
                if(RST = '1') then
                    stato_corrente <= IDLE;
                else
                    stato_corrente <= stato_prossimo;
                end if;
            end if;
        end process;

end Behavioral;
