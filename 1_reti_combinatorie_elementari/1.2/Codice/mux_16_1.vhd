----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2025 12:27:21 PM
-- Design Name: 
-- Module Name: mux_16_1 - Structural
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

entity mux_16_1 is
    Port (  x   : in    STD_LOGIC_VECTOR (15 downto 0);
            s0  : in    STD_LOGIC;
            s1  : in    STD_LOGIC;
            s2  : in    STD_LOGIC;
            s3  : in    STD_LOGIC;
            y0   : out   STD_LOGIC
            
    );
end mux_16_1;

architecture Structural of mux_16_1 is
        signal u0  :   STD_LOGIC := '0';
        signal u1  :   STD_LOGIC := '0';
        signal u2  :   STD_LOGIC := '0';
        signal u3  :   STD_LOGIC := '0';
        
    component mux_4_1
        port(   a0  :   in  STD_LOGIC;
                a1  :   in  STD_LOGIC;
                a2  :   in  STD_LOGIC;
                a3  :   in  STD_LOGIC;
                s0  :   in  STD_LOGIC; -- selezione
                s1  :   in  STD_LOGIC; -- selezione
                y   :   out STD_LOGIC 
        );
     

     end component;

begin

    mux0 : mux_4_1 
        Port map(   a0 => x(0),
                    a1 => x(1),
                    a2 => x(2),
                    a3 => x(3),
                    s0 => s0,
                    s1 => s1,
                    y => u0
                );

    mux1 : mux_4_1
        Port map(   a0 => x(4),
                    a1 => x(5),
                    a2 => x(6),
                    a3 => x(7),
                    s0 => s0,
                    s1 => s1,
                    y => u1
                );

    mux2 : mux_4_1
        Port map(   a0 => x(8),
                    a1 => x(9),
                    a2 => x(10),
                    a3 => x(11),
                    s0 => s0,
                    s1 => s1,
                    y => u2
                );        

    mux3 : mux_4_1
        Port map(   a0 => x(12),
                    a1 => x(13),
                    a2 => x(14),
                    a3 => x(15),
                    s0 => s0,
                    s1 => s1,
                    y => u3
                );

    mux4 : mux_4_1
        Port map(   a0 => u0,
                    a1 => u1,
                    a2 => u2,
                    a3 => u3,
                    s0 => s2,
                    s1 => s3,
                    y => y0
                );
end Structural;
