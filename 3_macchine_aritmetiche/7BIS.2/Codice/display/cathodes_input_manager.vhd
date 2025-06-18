----------------------------------------------------------------------------------

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- questo componente si occupa di selezionare il nibble da mostrare sulla cifra illuminata
-- in base al valore del counter; il componente si occupa anche di accendere o meno il punto
entity cathodes_input_manager is
  Port (
       counter : in std_logic_vector(2 downto 0);
       value8_in: in std_logic_vector(15 downto 0);
       dots_in: in std_logic_vector(7 downto 0); --configurazione dei punti degli 8 display
       output : out integer; --nibble da mostrare in base alla selezione
       dot_out : out std_logic --punto da mostrare in base alla selezione
       );
end cathodes_input_manager;

architecture Behavioral of cathodes_input_manager is

begin
    ciao:process(counter)
    begin
        case counter is
            when "000" => output<=to_integer(unsigned(value8_in(3 downto 0)))mod 10;
            when "001" => output<=to_integer(unsigned(value8_in(3 downto 0)))/10 ;
            
            when "010" => output<=to_integer(unsigned(value8_in(7 downto 4)))mod 10;
            when "011" => output<=to_integer(unsigned(value8_in(7 downto 4)))/10;
            
            
            when others=> output<=0;
        end case;
    
    with counter select
       dot_out <= dots_in(7)when "111",
               dots_in(6) when "110",
               dots_in(5) when "101",
               dots_in(4) when "100",
               dots_in(3) when "011",
               dots_in(2) when "010",
               dots_in(1) when "001",
               dots_in(0) when "000",
               '0' when others;
   end process;
end Behavioral;
