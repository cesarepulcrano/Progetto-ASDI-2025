----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 06:15:24 PM
-- Design Name: 
-- Module Name: sommatore_cla - Structural
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

entity sommatore_cla is
    Port (
            x: in   std_logic_vector(3 downto 0);
            y: in   std_logic_vector(3 downto 0);
            c_in: in std_logic;
            c_out: out std_logic;
            s: out  std_logic_vector(3 downto 0)
    
     );
end sommatore_cla;

architecture Structural of sommatore_cla is
    
    component generazione_propagazione is
        Port ( 
                x : in std_logic_vector(3 downto 0);
                y : in std_logic_vector(3 downto 0);
                P : out std_logic_vector(3 downto 0);
                G : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component carry_look_ahead is
        Port (
                P: in std_logic_vector(3 downto 0);
                G: in std_logic_vector(3 downto 0);
                c_in: in std_logic;
                carry: out std_logic_vector(3 downto 0);
                c_out: out std_logic;
                P_out: out std_logic_vector(3 downto 0)
         );
    end component;
    
    signal P_signal : std_logic_vector(3 downto 0);
    signal G_signal : std_logic_vector(3 downto 0);
    signal carry_signal : std_logic_vector(3 downto 0);
    signal cla_to_xor : std_logic_vector(3 downto 0);
    
begin
    
    ga: generazione_propagazione 
        Port Map( 
                x =>x,
                y =>y,
                P =>P_signal,
                G =>G_signal
        );
    
    cla:carry_look_ahead
        Port Map(
                P    =>P_signal,
                G    =>G_signal,
                c_in =>c_in,
                carry=>carry_signal,
                c_out=>c_out,
                P_out=>cla_to_xor
         );
    
    s<=cla_to_xor xor carry_signal;
end Structural;
