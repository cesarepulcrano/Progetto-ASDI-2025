----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2025 06:32:30 PM
-- Design Name: 
-- Module Name: mux_4_1 - Structural
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

entity mux_4_1 is
    Port (  x   :   in  std_logic_vector    (3  downto  0);
            s   :   in  std_logic_vector    (1  downto  0);
            y   :   out std_logic
    );
end mux_4_1;

architecture Structural of mux_4_1 is
    
    signal mux0_2   :   std_logic;
    signal mux1_2   :   std_logic;

    component   mux_2_1
        Port(   x : in std_logic_vector(1 downto 0);
                s : in std_logic;
                y : out std_logic
        );
    end component; 
begin
    
    mux_0: mux_2_1
        Port Map(   --x=>x( 3 downto 2),
                    x(0)=>x(0),
                    x(1)=>x(1),
                    s=>s(0),
                    y=>mux0_2
        );
    
    mux_1: mux_2_1
        Port Map(   --x=>x( 1 downto 0),
                    x(0)=>x(2),
                    x(1)=>x(3),
                    s=>s(0),
                    y=>mux1_2
        );    
    
    mux_2: mux_2_1
        Port Map(   --x=>mux1_2 & mux0_2,
                    x(0)=>mux0_2,
                    x(1)=>mux1_2,
                    s=>s(1),
                    y=>y
        );
end Structural;
