----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:29:17 22/10/2012 
-- Design Name: 
-- Module Name:    cathode_manager - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cathodes_manager is
    Port ( value : in  integer; --dato da mostrare sulla cifra del display
           dot : in  STD_LOGIC; --configurazione del punto: acceso o spento
           cathodes_dot : out  STD_LOGIC_VECTOR (7 downto 0)); --indica i 7 catodi pi� il punto
end cathodes_manager;

architecture Behavioral of cathodes_manager is

-- i catodi sono collegati nel seguente ordine:
-- cathodes[0]=CA
-- cathodes[2]=CB
--....
-- i catodi sono 0-attivi
constant zero   : std_logic_vector(6 downto 0) := "1000000"; 
constant one    : std_logic_vector(6 downto 0) := "1111001"; 
constant two    : std_logic_vector(6 downto 0) := "0100100"; 
constant three  : std_logic_vector(6 downto 0) := "0110000"; 
constant four   : std_logic_vector(6 downto 0) := "0011001"; 
constant five   : std_logic_vector(6 downto 0) := "0010010"; 
constant six    : std_logic_vector(6 downto 0) := "0000010"; 
constant seven  : std_logic_vector(6 downto 0) := "1111000"; 
constant eight  : std_logic_vector(6 downto 0) := "0000000"; 
constant nine   : std_logic_vector(6 downto 0) := "0010000"; 
--constant a   	 : std_logic_vector(6 downto 0) := "0001000"; 
--constant b      : std_logic_vector(6 downto 0) := "0000011"; 
--constant c      : std_logic_vector(6 downto 0) := "1000110"; 
--constant d      : std_logic_vector(6 downto 0) := "0100001"; 
--constant e      : std_logic_vector(6 downto 0) := "0000110"; 
--constant f      : std_logic_vector(6 downto 0) := "0001110";

signal cathodes : std_logic_vector(6 downto 0); --segnale temporaneo per codificare
                                                --il pattern sui 7 led in base alla cifra da mostrare (value)

begin
	

seven_segment_decoder_process: process

  begin
        case value is 
            
          when 0 => cathodes <= zero; 
          when 1 => cathodes <= one; 
          when 2 => cathodes <= two; 
          when 3 => cathodes <= three; 
          when 4 => cathodes <= four; 
          when 5 => cathodes <= five; 
          when 6 => cathodes <= six; 
          when 7 => cathodes <= seven; 
          when 8 => cathodes <= eight; 
          when 9 => cathodes <= nine; 
		  when others => cathodes <= (others => '0');
        end case;

  end process seven_segment_decoder_process;
  
cathodes_dot <= (not dot)&cathodes; --segnale complessivo di 7+1 bit con catodi e punto



end Behavioral;