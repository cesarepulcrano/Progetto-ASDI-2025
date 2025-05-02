----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:03:11 PM
-- Design Name: 
-- Module Name: contatore_mod_64 - Structural
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

entity contatore_mod_64 is
    Port (      clock   :   in  std_logic;
                reset   :   in  std_logic;
                set     :   in  std_logic;
                load    :   in  std_logic_vector(5 downto  0);
                cont    :   out  std_logic_vector(5    downto  0);
                co      :   out std_logic
                );
end contatore_mod_64;

architecture Structural of contatore_mod_64 is
    
    component contatore_mod_32
        port(
                clock   :   in  std_logic;
                reset   :   in  std_logic;
                set     :   in  std_logic;
                load    :   in  std_logic_vector(4    downto  0);
                cont    :   out std_logic_vector(4   downto  0);
                co      :   out std_logic
        );
    end component;   
    
    
    component and_gate
        port(
                a   :   in  std_logic;
                b  :   in  std_logic;
                y    :   out  std_logic

        );
    end component;
    
    
    signal cont_signal: std_logic;
    signal and_signal: std_logic;
begin
    
    mod32_0: contatore_mod_32
        port Map(
                clock=>clock, 
                reset=>reset,
                set=>set,
                load=> load(2 downto 0),
                cont => cont(2 downto 0), 
                co => cont_signal
        );
      
    and_gate0: and_gate
        port Map(
                    a=>cont_signal,
                    b=>clock,
                    y=>and_signal
        );
    mod32_1:contatore_mod_32
        port Map(
                clock=>and_signal, 
                reset=>reset,
                set=>set,
                load=> load(5 downto 3),
                cont => cont(5 downto 3), 
                co => co
        );
       

end Structural;
