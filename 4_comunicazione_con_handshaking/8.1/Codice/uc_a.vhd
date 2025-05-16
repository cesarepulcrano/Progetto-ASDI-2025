----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 11:21:00 AM
-- Design Name: 
-- Module Name: uc_a - Behavioral
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
use IEEE.math_real.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uc_a is
    Generic(N:natural:=8);
    Port (  CLK:    in  std_logic;
            RST:    in  std_logic;
            START:  in  std_logic;
            COUNT:  in  std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
            ACK :   in  std_logic;
            REQ :   out std_logic;
            EN_COUNT:    out  std_logic;
            RST_COUNT:   out  std_logic;
            READ_ROM:   out std_logic
             );
end uc_a;

architecture Behavioral of uc_a is
    
    type stato is (IDLE,READ,REQ_STATE,WAIT_ACK,COUNT_STATE);
    signal stato_corrente:  stato:=IDLE;
    signal stato_prossimo:  stato;

begin
    
    comb:process(stato_corrente,START,ACK,COUNT)
        begin
            case stato_corrente is
                when IDLE =>
                    en_count<='0';
                    if(START='1') then
                        stato_prossimo<=READ;
                    else
                        stato_prossimo<=IDLE;
                    end if;
                when READ =>
                    en_count<='0';
                    READ_ROM<='1';
                    stato_prossimo<=REQ_STATE;
                when REQ_STATE =>
                    REQ<='1';
                    if(ACK='1') then
                        stato_prossimo<=WAIT_ACK;
                    else
                        stato_prossimo<=REQ_STATE;
                    end if;                        
                when WAIT_ACK =>
                    REQ<='0';
                    if(ACK='0') then
                        stato_prossimo<=COUNT_STATE;
                    else
                        stato_prossimo<=WAIT_ACK;
                    end if;
                when COUNT_STATE =>
                    READ_ROM<='0';
                    en_count<='1';
                    if(count="1111") then
                        stato_prossimo<=IDLE;
                    else
                        stato_prossimo<=READ;
                    end if;
                end case;                         
        end process;
    
    mem:process(CLK)
        begin
            if(rising_edge(CLK)) then
                if(RST='1') then
                    RST_COUNT<='0';
                else
                    stato_corrente<=stato_prossimo;
                end if;
            end if;                
        end process;

end Behavioral;
