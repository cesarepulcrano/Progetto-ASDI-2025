----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2025 12:48:12 PM
-- Design Name: 
-- Module Name: riconoscitore_101 - Behavioral
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

entity riconoscitore_101 is
    Port (  input   :   in  std_logic;
            a       :   in  std_logic; -- segnale ti tempificazione(clock)
            reset   :   in  std_logic;
            m       :   in  std_logic; --0 modalità non sovrapposta, 1 modalità parzialmente sovrapposta
            output  :   out std_logic
     );
end riconoscitore_101;

architecture Behavioral of riconoscitore_101 is
    --da S0 a S4 stati automa 1(m=0, non sovrapposto)
    --da S5 a S7 stati automa 1(m=1,parzialmente sovrapposto)
    type    stato is (S0,S1,S2,S3,S4,S5,S6,S7);
    signal  stato_corrente  :   stato   :=S0;
    signal  stato_prossimo  :   stato;
begin
    
    state_proccess: process(stato_corrente,input,m)
        begin
            
            case stato_corrente is
                when  S0 =>
                    if(m='0')  then
                        if(input='0') then
                            stato_prossimo<=S1;
                            output<='0';
                        else
                            stato_prossimo<=S2;
                            output<='0';
                        end if;
                     else
                        stato_prossimo<=S5;
                        output<='0';
                     end if;
                     
                 when  S1=>
                    if(m='0')  then                        
                        stato_prossimo<=S3;
                        output<='0';
                    else
                        stato_prossimo<=S5;
                        output<='0';
                    end if;
                    
                 when  S2 =>
                    if(m='0')  then
                        if(input='0') then
                            stato_prossimo<=S4;
                            output<='0';
                        else
                            stato_prossimo<=S3;
                            output<='0';
                        end if;
                     else
                        stato_prossimo<=S5;
                        output<='0';
                     end if;
                 when  S3 =>
                    if(m='0')  then
                        stato_prossimo<=S0;
                        output<='0';
                     else
                        stato_prossimo<=S5;
                        output<='0';
                     end if;
                 when  S4 =>
                    if(m='0')  then
                        if(input='0') then
                            stato_prossimo<=S0;
                            output<='0';
                        else
                            stato_prossimo<=S0;
                            output<='1';
                        end if;
                     else
                        stato_prossimo<=S5;
                        output<='0';
                     end if;
                 when  S5 =>
                    if(m='1')  then
                        if(input='0') then
                            stato_prossimo<=S5;
                            output<='0';
                        else
                            stato_prossimo<=S6;
                            output<='0';
                        end if;
                     else
                        stato_prossimo<=S0;
                        output<='0';
                     end if;
                 when  S6 =>
                    if(m='1')  then
                        if(input='0') then
                            stato_prossimo<=S7;
                            output<='0';
                        else
                            stato_prossimo<=S6;
                            output<='0';
                        end if;
                     else
                        stato_prossimo<=S0;
                        output<='0';
                     end if;
                 when  S7 =>
                    if(m='1')  then
                        if(input='0') then
                            stato_prossimo<=S5;
                            output<='0';
                        else
                            stato_prossimo<=S5;
                            output<='1';
                        end if;
                     else
                        stato_prossimo<=S0;
                        output<='0';
                     end if;
            end case;

    end process;
    
    memory_process  :   process (a,reset)
        begin   
            if(reset = '1') then
                stato_corrente<=S0;
            elsif(a'event and a='1') then
                stato_corrente<=stato_prossimo;
            end if;
    end process;


end Behavioral;
