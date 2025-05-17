----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 11:21:59 AM
-- Design Name: 
-- Module Name: uc_b - Behavioral
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

entity uc_b is
    Generic(N:natural:=8 );
    Port (  CLK:    in std_logic;
            RST:    in  std_logic;
            COUNT:  in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
            REQ:    in std_logic;
            EN_COUNT:    out std_logic;
            RST_COUNT:   out std_logic;
            READ_ROM:   out  std_logic;
            WRITE_MEM:  out std_logic;
            WRITE_REG:  out std_logic;
            ACK:    out std_logic
          );
end uc_b;

architecture Behavioral of uc_b is
    
    type stato is (WAIT_REQ,SEND_ACK ,WRITE_REG_STATE ,READ,WRITE_MEM_STATE,COUNT_STATE);
    signal stato_corrente:  stato:=WAIT_REQ;
    signal stato_prossimo:  stato;
    
begin
    
    comb:process(stato_corrente,COUNT,REQ)
        begin
            case stato_corrente is
                when WAIT_REQ =>
                    en_count<='0';
                    if(REQ='1') then
                        --ACK<='1';
                        stato_prossimo<=SEND_ACK;
                    else 
                        stato_prossimo<=WAIT_REQ;
                    end if;
                when SEND_ACK =>
                    ACK<='1';
                    if(req='0')  then
                       stato_prossimo<= WRITE_REG_STATE;
                    else
                       stato_prossimo<=SEND_ACK; 
                    end if;         
                when WRITE_REG_STATE =>
                    WRITE_REG<='1';
                    stato_prossimo<=READ;
                when READ =>
                    ACK<='0';
                    WRITE_REG<='0';
                    READ_ROM<='1';
                    stato_prossimo<=WRITE_MEM_STATE;   
                when WRITE_MEM_STATE =>
                    WRITE_MEM<='1';
                    stato_prossimo<=COUNT_STATE;      
                when COUNT_STATE =>
                    WRITE_MEM<='0';
                    READ_ROM<='0';
                    en_count<='1';
                    stato_prossimo<=WAIT_REQ;
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
