----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 01:01:50 PM
-- Design Name: 
-- Module Name: UC_a - Behavioral
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
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UC_a is
    Generic (   N   :   natural :=8;
                M   :   natural := 8);
    Port (  clk:    in std_logic;
            rst:    in std_logic;
            count:  in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
            start : in std_logic;
            ack: in std_logic;
            req: out std_logic;
            en_count:    out std_logic;
            read_rom:    out std_logic;
            --uart
            TBE :   in std_logic;
            WR :   out std_logic
             );
end UC_a;

architecture Behavioral of UC_a is
    
    type state is (idle,read,uart_ready,req_state,wait_ack,increment);
    signal stato_corrente: state:=idle;
    signal stato_prossimo: state;
    
begin
    
    comb:process(stato_corrente,start,count,ack,TBE)
    begin
         case stato_corrente is
            when idle=>
                en_count<='0';
                if(start='1') then
                    stato_prossimo<=read;
                else
                    stato_prossimo<=idle;    
                end if;
             when read =>
                read_rom<='1';
                WR<='1';
                stato_prossimo<=req_state;
             when req_state =>
                req<='1';
                if(ack='1') then    
                    stato_prossimo<=uart_ready;
                else
                    stato_prossimo<=req_state;
                end if;   
             when uart_ready =>
                req<='0';
                wr<='0';
                if(TBE='1') then
                    stato_prossimo<=wait_ack;
                else    
                    stato_prossimo<=uart_ready;
                end if;
             when wait_ack =>
                WR<='0';
                if(ack<='0') then
                    stato_prossimo<=increment;
                else
                    stato_prossimo<=wait_ack;
                end if;
             when increment =>
                en_count<='1';
                stato_prossimo<=idle;
--                if(count="1111")    then
--                    stato_prossimo<=idle;             
--                else 
--                    stato_prossimo<=idle;
--                end if;                                
         end case;     
    end process;
    
    mem:process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst='1') then
                stato_corrente<=idle;
            else 
                stato_corrente<=stato_prossimo;
            end if;
         end if;       
    end process;
    

end Behavioral;
