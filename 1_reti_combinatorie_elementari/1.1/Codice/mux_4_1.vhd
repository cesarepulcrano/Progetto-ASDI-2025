----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2025 12:14:22 PM
-- Design Name: 
-- Module Name: mux4_1 - Behavioral
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
    Port (  a0  :   in  STD_LOGIC;
            a1  :   in  STD_LOGIC;
            a2  :   in  STD_LOGIC;
            a3  :   in  STD_LOGIC;
            s0  :   in  STD_LOGIC;
            s1  :   in  STD_LOGIC;
            y   :   out STD_LOGIC
    
    );
end mux_4_1;

architecture Dataflow of mux_4_1 is

    begin
        y <= ((a0 AND  NOT(s1) AND NOT(s0)) OR (a1 AND  NOT(s1) AND s0) OR (a2 AND  s1 AND NOT(s0)) OR (a3 AND  s1 AND s0));

end Dataflow;
