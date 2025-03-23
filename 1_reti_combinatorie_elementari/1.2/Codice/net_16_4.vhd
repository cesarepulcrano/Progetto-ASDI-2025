----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2025 12:20:34 PM
-- Design Name: 
-- Module Name: net_16_4 - Structural
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

entity net_16_4 is
    Port (  input    :   in std_logic_vector(15 downto 0);
            input_control   :   in std_logic_vector (3 downto 0);
            output_control  :   in std_logic_vector (1 downto 0);
            output  :   out std_logic_vector (3 downto 0)
    );
end net_16_4;

architecture Structural of net_16_4 is
    signal demux_in :   std_logic :='0';
    
    component mux_16_1
        port(   x   :   in std_logic_vector (15 downto 0);
                s0  :   in std_logic;
                s1  :   in std_logic;
                s2  :   in std_logic;
                s3  :   in std_logic;
                y0  :   out std_logic
        );
    end component;
    
    component demux_1_4
        port(   x   :   in  std_logic;
                s0  :   in  std_logic;
                s1  :   in  std_logic;
                y   :   out std_logic_vector (3 downto 0)
        );
    end component;
    
begin
    
    mux0:   mux_16_1
        Port map(   x=>input,
                    s0=>input_control(0),
                    s1=>input_control(1),
                    s2=>input_control(2),
                    s3=>input_control(3),
                    y0=>demux_in
        );
        
    demux0: demux_1_4
        Port map(   x=>demux_in,
                    s0=>output_control(0),
                    s1=>output_control(1),
                    y=>output
        );

end Structural;
