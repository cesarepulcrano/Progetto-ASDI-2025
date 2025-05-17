----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 05:30:08 PM
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uc_a is
    Port ( 
            clk: in std_logic;
            rst: in std_logic;
            start: in std_logic;
            en_count: out std_logic;
            read_rom: out std_logic;
            req: out std_logic;
            ack: in std_logic;
            count: in std_logic_vector(2 downto 0)
    );
end uc_a;

architecture Behavioral of uc_a is
    
    type stato is (idle,read_rom_state,req_state,wait_ack,increment);
    signal stato_corrente: stato:=idle;
    signal stato_prossimo: stato;
    
begin
    
    
    comb:process(stato_corrente,start,count,ack)
    begin
        case stato_corrente is
        when idle=>
            en_count<='0';
            if(start='1') then
                stato_prossimo<=read_rom_state;
            else
                stato_prossimo<=idle;
            end if;
        when read_rom_state=>
            en_count<='0';
            read_rom<='1';
            stato_prossimo<=req_state;
        when req_state =>
            req<='1';
            if(ack='1') then
                stato_prossimo<=wait_ack;
            else
                stato_prossimo<=req_state;
            end if;
        when wait_ack =>
            req<='0';
            if(ack='0') then
                stato_prossimo<=increment;
            else
                stato_prossimo<=wait_ack;
            end if;
        when increment =>
            read_rom<='0';
            en_count<='1';
            if(count="111") then
                stato_prossimo<=idle;
            else 
                stato_prossimo<=read_rom_state;
            end if;                 
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
