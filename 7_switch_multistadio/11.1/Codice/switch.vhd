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

entity switch is
    Port ( 
            x0 : in STD_LOGIC_VECTOR (1 downto 0);
            x1 : in STD_LOGIC_VECTOR (1 downto 0);
            s_in : in STD_LOGIC;
            s_out : in STD_LOGIC;
            y0 : out STD_LOGIC_VECTOR (1 downto 0);
            y1 : out STD_LOGIC_VECTOR (1 downto 0)
           );
end switch;

architecture Structural of switch is
    
    component bit_switch is
        Port ( 
                x : in STD_LOGIC_VECTOR (1 downto 0);
                s_in : in STD_LOGIC;
                s_out : in STD_LOGIC;
                y : out STD_LOGIC_VECTOR (1 downto 0)
    
               );
    end component;
    
begin
    
    bit0:bit_switch
        Port Map( 
                x(0)=>x0(0),
                x(1)=>x1(0),
                s_in=>s_in,
                s_out=>s_out,
                y(0)=>y0(0),
                y(1)=>y1(0)
               );
     
     bit1:bit_switch
        Port Map( 
                x(0)=>x0(1),
                x(1)=>x1(1),
                s_in=>s_in,
                s_out=>s_out,
                y(0)=>y0(1),
                y(1)=>y1(1)
               );   
end Structural;
