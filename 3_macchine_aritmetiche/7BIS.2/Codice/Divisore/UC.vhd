----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 02:15:41 AM
-- Design Name: 
-- Module Name: UC - Behavioral
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

entity UC is
    Generic (   N           :   natural :=4); 
    Port    (   clk         :   in      std_logic;
                rst         :   in      std_logic;
                start       :   in      std_logic;
                init        :   out     std_logic;
                en_count    :   out     std_logic;                           
                load_m      :   out     std_logic;                           
                load_q      :   out     std_logic;                           
                load_a      :   out     std_logic;                           
                subtract    :   out     std_logic;                           
                shift       :   out     std_logic;                           
                count       :   in      std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
                s           :   in      std_logic

                );
end UC;

architecture Behavioral of UC is
    type state is (idle,shift_state,load_a_state,sum_sub,increment,correzione,init_state);
    signal stato_corrente:  state:=idle;
    signal stato_prossimo:  state;
    signal full: std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0):=(others=>'1');
begin
    
    comb:process(stato_corrente,start,count,s)
    begin
        case stato_corrente is
            --
            when idle =>
                load_a  <='0'; 
                load_q<='0';
                en_count<='0';
                if(start='1') then
                    init<='1'; 
                    load_m <='1';  
                    load_q <='1';  
                    load_a  <='1';    
                    stato_prossimo<=init_state;
                else
                    stato_prossimo<=idle;
                end if;
            when init_state =>
                    init<='1'; 
                    load_m <='1';  
                    load_q <='1';  
                    load_a  <='1'; 
                    stato_prossimo<=shift_state;
            when shift_state =>
                en_count<='0';
                init<='0'; 
                load_m <='0';  
                load_q <='0';  
                load_a  <='0';
                shift<='1';
                stato_prossimo<=sum_sub;
            when sum_sub =>
                init<='0';
                shift<='0';
                
                if(s='0') then
                    subtract<='1';
                else
                    subtract<='0';
                end if;
                    stato_prossimo<=load_a_state;
             when load_a_state=>
                  load_a  <='1'; 
                  stato_prossimo<=increment;
             when increment =>
                load_a  <='0';
                load_q<='1';
                en_count<='1';
                if(count=full) then
                    stato_prossimo<=correzione;
                else 
                    stato_prossimo<=shift_state;
                end if;
              when correzione =>
                load_q<='0';
                if(s='1') then
                    subtract<='0';
                    load_a<='1';
                    stato_prossimo<=idle;
                 else 
                    stato_prossimo<=idle;
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
