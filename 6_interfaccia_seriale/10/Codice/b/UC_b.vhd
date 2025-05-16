----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 01:01:50 PM
-- Design Name: 
-- Module Name: UC_b - Behavioral
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

entity UC_b is
    Generic (   N   :   natural :=8;
                M   :   natural := 8);
    Port (  clk:    in std_logic;
            rst:    in std_logic;
            count:  in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
            --start : in std_logic;
            ack: out std_logic;
            req: in std_logic;
            en_count:    out std_logic;
            write_mem:    out std_logic;
            --uart
            RDA:    in std_logic;
            RD:     out  std_logic
             );
end UC_b;

architecture Behavioral of UC_b is
    
    type state is (wait_req,en_uart,write_mem_state,increment,uart_ready);
    signal stato_corrente: state:=wait_req;
    signal stato_prossimo: state;
    
begin
    
    comb:process(stato_corrente,count,req,RDA)
    begin
         case stato_corrente is
            when wait_req =>
                en_count<='0';
                rd<='0';
                if(req='1') then
                    stato_prossimo<=en_uart;
                else 
                    stato_prossimo<=wait_req;
                end if;
            when en_uart =>
                ack<='1';
                RD<='1';
                stato_prossimo<=uart_ready;
            when uart_ready =>  
                rd<='0';    
                if(RDA='1') then
                    stato_prossimo<=write_mem_state;
                else
                    stato_prossimo<=uart_ready;
                end if; 
            when write_mem_state =>
                ack<='0';
                RD<='0';
                write_mem<='1';
                stato_prossimo<=increment;                 
            when increment =>
               write_mem<='0';
               en_count<='1';
               stato_prossimo<=wait_req;
--               if(count="1111")    then
--                   stato_prossimo<=wait_req;             
--               else 
--                   stato_prossimo<=wait_req;
--               end if;                                
         end case;     
    end process;
    
    mem:process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst='1') then
                stato_corrente<=wait_req;
            else 
                stato_corrente<=stato_prossimo;
            end if;
         end if;       
    end process;
    

end Behavioral;
