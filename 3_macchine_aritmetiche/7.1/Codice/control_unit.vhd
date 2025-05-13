----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2025 07:31:13 PM
-- Design Name: 
-- Module Name: control_unit - Behavioral
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

entity control_unit is
    Generic(N: natural:=8);
    Port (  CLK: in std_logic;
            RST: in std_logic;
            ENABLE: in  std_logic;
            Q0: in std_logic;
            Q1: in std_logic;
            count:  in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
            SHIFT:out std_logic;
            LOAD_A: out std_logic;
            LOAD_Q: out std_logic;
            LOAD_M: out std_logic;
            SUBTRACT: out std_logic;
            init: out std_logic;
            en_count:   out std_logic
            
     );
end control_unit;

architecture Behavioral of control_unit is
    
    type state is (IDLE,SCAN,SUM_STATE,SUBTRACT_STATE,LOADA_STATE,RSHIFT,INCREMENT,TEST);
    signal stato_corrente: state :=IDLE;
    signal stato_prossimo: state;
begin
    comb:process(stato_corrente,ENABLE,Q0,Q1,count)
    begin
        --en_count<='0';
        --SUBTRACT<='0';
        SHIFT<='0';
                init<='0';
                LOAD_A<='0'; --prove
                LOAD_Q<='0';
                LOAD_M<='0';
        case stato_corrente is
        when IDLE =>
            if(ENABLE='1') then
                SHIFT<='0';
                init<='1';
                LOAD_A<='1'; --prove
                LOAD_Q<='1';
                LOAD_M<='1';
                stato_prossimo<=SCAN;
            else
                stato_prossimo<=IDLE;
            end if;    
        when SCAN =>
            SHIFT<='0';
            init<='0';
            LOAD_A<='0';
            LOAD_Q<='0';
            LOAD_M<='0';
            if(Q1='0' AND Q0='1') then
                stato_prossimo<=SUM_STATE;
            elsif(Q1='1' AND Q0='0')  then
                stato_prossimo<=SUBTRACT_STATE;   
            else
                stato_prossimo<=RSHIFT;
            end if;    
        when SUM_STATE =>
            SUBTRACT<='0';
            stato_prossimo<=LOADA_STATE;
        when SUBTRACT_STATE =>
            SUBTRACT<='1';
            
            stato_prossimo<=LOADA_STATE;
        when LOADA_STATE =>
            SHIFT<='0';
            LOAD_A<='1';
            stato_prossimo<=RSHIFT;    
        when RSHIFT =>
            LOAD_A<='0';
            SHIFT<='1';
            stato_prossimo<=INCREMENT;
        when INCREMENT =>
            SHIFT<='0';
            en_count<='1';
            stato_prossimo<=TEST;
        when TEST=>
            en_count<='0';
            if(count=std_logic_vector(to_unsigned(N-1,integer(ceil(log2(real(N)))))) ) then
                stato_prossimo<=IDLE;
            else
                stato_prossimo<=SCAN;
            end if;                                              
        end case;
    end process;

    mem: process(CLK)
    begin
        if(rising_edge(CLK)) then
            if(RST='1') then
                stato_corrente<=IDLE;
            else
                stato_corrente<=stato_prossimo;
            end if;
        end if;
    end process;

end Behavioral;
