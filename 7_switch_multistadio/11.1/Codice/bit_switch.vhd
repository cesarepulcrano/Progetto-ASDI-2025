----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 01:08:19 PM
-- Design Name: 
-- Module Name: switch - Structural
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



entity bit_switch is
    Port ( 
            x : in STD_LOGIC_VECTOR (1 downto 0);
            s_in : in STD_LOGIC;
            s_out : in STD_LOGIC;
            y : out STD_LOGIC_VECTOR (1 downto 0)

           );
end bit_switch;

architecture Structural of bit_switch is
    
    component mux_2_1 is
        Port (  x : in std_logic_vector(1 downto 0);
                s : in std_logic;
                y : out std_logic
        );
    end component;
    
    component demux1_2 is
        Port (
                x: in std_logic;
                s: in std_logic;
                y: out std_logic_vector(1 downto 0) 
                );
    end component;
    
    signal mux_demux: std_logic;
    
begin
    
    ingresso: mux_2_1 
        Port Map(   x=>x,
                    s=>s_in,
                    y=>mux_demux
                    
        );

    uscita: demux1_2 
        Port Map(   x=>mux_demux,
                    s=>s_out,
                    y=>y
        );
    

end Structural;
