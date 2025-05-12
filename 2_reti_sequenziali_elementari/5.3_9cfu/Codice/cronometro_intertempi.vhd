----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2025 08:18:38 PM
-- Design Name: 
-- Module Name: cronometro_intertempi - Structural
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

entity cronometro_intertempi is
    Generic(N: natural:=4);
    Port (  CLK: in std_logic;
            RST: in std_logic;
            set: in std_logic;
            
            load_second:in std_logic_vector(5 downto 0);
            load_minute: in std_logic_vector(5 downto 0);
            load_hour:  in std_logic_vector(4 downto 0);
            
            cont_second:    out std_logic_vector(5 downto 0);
            cont_minute:    out std_logic_vector(5 downto 0);
            cont_hour  :    out std_logic_vector(4 downto 0);
            
            stop:   in std_logic;
            c_out       :   out std_logic
        );
end cronometro_intertempi;

architecture Structural of cronometro_intertempi is
    component cronometro is
        Port (  CLK: in std_logic;
                RST: in std_logic;
                set: in std_logic;
                
                load_second:in std_logic_vector(5 downto 0);
                load_minute: in std_logic_vector(5 downto 0);
                load_hour:  in std_logic_vector(4 downto 0);
                
                cont_second:    out std_logic_vector(5 downto 0);
                cont_minute:    out std_logic_vector(5 downto 0);
                cont_hour  :    out std_logic_vector(4 downto 0);
                
                c_out       :   out std_logic
        );
    end component;
begin
    
    chrono: cronometro
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    set=>set,
                    load_second=>load_second,
                    load_minute=>load_minute,
                    load_hour=>load_hour,
                    cont_second=>cont_second,
                    cont_minute=>cont_second,
                    cont_hour=>cont_second,
                    c_out=>c_out
        );

    

end Structural;
