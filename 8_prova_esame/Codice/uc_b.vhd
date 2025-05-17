----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 05:30:08 PM
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uc_b is
    Port ( 
            clk: in std_logic;
            rst: in std_logic;
            req: in std_logic;
            ack: out std_logic;
            write_reg_in : out std_logic;
            write_reg_out : out std_logic
    );
end uc_b;

architecture Behavioral of uc_b is
    
    type stato is (wait_req,send_ack,read,somma);
    signal stato_corrente: stato:=wait_req;
    signal stato_prossimo: stato;
    
begin
    
    
    comb:process(stato_corrente,req)
    begin
        case stato_corrente is
            when wait_req =>
                write_reg_in<='0';
                write_reg_out<='0';
                if(req='1') then
                    stato_prossimo<=send_ack;
                else
                    stato_prossimo<=wait_req;
                end if;
             when send_ack =>
                ack<='1';
                if(req='0') then
                    stato_prossimo<=read;
                else
                    stato_prossimo<=send_ack;
                end if;
             when read=>
                ack<='0';
                write_reg_in<='1';
                stato_prossimo<=somma;
             when somma => 
                write_reg_out<='1';
                stato_prossimo<=wait_req;              
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
