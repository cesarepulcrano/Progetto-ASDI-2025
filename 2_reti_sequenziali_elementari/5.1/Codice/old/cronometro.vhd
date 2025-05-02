----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 23 59 59
-- Create Date: 04/18/2025 03:25:50 PM
-- Design Name: 
-- Module Name: cronometro - Structural
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

entity cronometro is
    Port (  CLK: in std_logic;
            RST: in std_logic;
            set: in std_logic;
            
            load_second:in std_logic_vector(4 downto 0);
            load_minute: in std_logic_vector(5 downto 0);
            load_hour:  in std_logic_vector(5 downto 0);
            
            cont_second:    out std_logic_vector(4 downto 0);
            cont_minute:    out std_logic_vector(5 downto 0);
            cont_hour  :    out std_logic_vector(5 downto 0);
            
            c_out       :   out std_logic
             );
end cronometro;

architecture Structural of cronometro is
     
     signal second_signal: std_logic;
     signal second_value: std_logic_vector(5 downto 0);
     signal reset_second:   std_logic;
     
     signal minute_signal: std_logic;
     signal minute_value: std_logic_vector(5 downto 0);
     signal reset_minute:   std_logic;
     
     signal hour_signal: std_logic;
     signal hour_value: std_logic_vector(4 downto 0);
     signal reset_hour:   std_logic;
     component contatore_mod_32 is
        port(
                clock   :   in  std_logic;
                reset   :   in  std_logic;
                set     :   in  std_logic;
                load    :   in  std_logic_vector(4    downto  0);
                cont    :   out  std_logic_vector(4    downto  0);
                co      :   out std_logic
        );
      end component;
        
    component contatore_mod_64 is
        Port (      clock   :   in  std_logic;
                    reset   :   in  std_logic;
                    set     :   in  std_logic;
                    load    :   in  std_logic_vector(5 downto  0);
                    cont    :   out  std_logic_vector(5    downto  0);
                    co      :   out std_logic
         );
    end component;
                

begin

    secondi:contatore_mod_64
        Port Map(   clock=>CLK,
                    reset=>reset_second,-- OR (cont_second(5) AND cont_second(4) AND cont_second(3) AND(NOT cont_second(2)) AND cont_second(1) AND cont_second(0)),
                    set=>set,
                    load=>load_second,
                    cont=>second_value,
                    co=>second_signal
        );
        
     reset_second<=RST OR (second_value(5) AND second_value(4) AND second_value(3) AND(NOT second_value(2)) AND second_value(1) AND second_value(0));
     
     
     minuti:contatore_mod_64
        Port Map(   clock=>second_signal,
                    reset=>reset_minute,-- OR (cont_second(5) AND cont_second(4) AND cont_second(3) AND(NOT cont_second(2)) AND cont_second(1) AND cont_second(0)),
                    set=>set,
                    load=>load_minute,
                    cont=>minute_value,
                    co=>minute_signal
        );
        
     reset_minute<=RST OR (minute_value(5) AND minute_value(4) AND minute_value(3) AND(NOT minute_value(2)) AND minute_value(1) AND minute_value(0));
     
     
     ore:contatore_mod_32
        Port Map(   clock=>minute_signal,
                    reset=>reset_hour,-- OR (cont_second(5) AND cont_second(4) AND cont_second(3) AND(NOT cont_second(2)) AND cont_second(1) AND cont_second(0)),
                    set=>set,
                    load=>load_hour,
                    cont=>hour_value,
                    co=>hour_signal
        );
     reset_hour<=RST OR (hour_value(4) AND(NOT hour_value(3)) AND hour_value(2) AND hour_value(1) AND hour_value(0));
end Structural;
