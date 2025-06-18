----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2025 04:24:26 PM
-- Design Name: 
-- Module Name: A - Behavioral
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

entity B is
    Port ( 
            clk                 : in std_logic;
            rst                 : in std_logic; 
            invia               : in std_logic;  
            controllo_input     : in std_logic_vector(1 downto 0);
            dato_in             : in std_logic_vector(1 downto 0);
            controllo_output    : out std_logic_vector(1 downto 0);
            dato_out            : out std_logic_vector(1 downto 0);
            selezione_output    : out std_logic_vector(1 downto 0);
            dato_ricevuto       : out std_logic_vector(1 downto 0)               
    );
end B;
-- controllo_input = 01 richiesta di ricevere
-- controllo_input = 10 richiesta di ricevere accettata
-- controllo_output = 01 richiesta di mandare
-- controllo_output = 10 richiesta di mandare accettata

-- selezione per selezionare linea controllo o linea dato
architecture Behavioral of B is
    type state is (idle,send_req,wait_ack,send_data,send_ack,ricevi);
    signal stato_corrente : state := idle;
    signal stato_prossimo : state;

begin
    
    comb:process(stato_corrente,invia,controllo_input,dato_in)
    begin

        case stato_corrente is
        when idle =>
            selezione_output<="00";
            if(invia='1') then
                stato_prossimo<=send_req;
            elsif(controllo_input="01") then
                stato_prossimo<=ricevi;
            else
                stato_prossimo<=idle;
            end if;
        when send_req =>
            selezione_output(0)<='1';
            controllo_output<="01";
            stato_prossimo<=send_data;
                                
        when send_data =>
            selezione_output(0)<='0';
            selezione_output(1)<='1';
            dato_out<="11";
            stato_prossimo<=wait_ack;
        when wait_ack =>
            selezione_output(0)<='0'; 
            selezione_output(1)<='0';   
            if(controllo_input="10") then
                stato_prossimo<=idle;
            else
                stato_prossimo<=wait_ack;
            end if;             
        when send_ack =>
            selezione_output(0)<='1';
            controllo_output<="10";
            stato_prossimo<=idle;
        when ricevi =>  
            selezione_output(0)<='0';
            dato_ricevuto<=dato_in;
            stato_prossimo<=send_ack;
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
