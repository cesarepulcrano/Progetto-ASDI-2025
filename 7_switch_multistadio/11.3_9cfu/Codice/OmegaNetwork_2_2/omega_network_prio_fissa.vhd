----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 02:01:41 PM
-- Design Name: 
-- Module Name: omega_network_prio_fissa - Structural
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity omega_network_prio_fissa is
    Generic(N: natural:=4);
    Port ( 
                message0 : in  std_logic_vector(3 downto 0);
                message1 : in  std_logic_vector(3 downto 0);
                message2 : in  std_logic_vector(3 downto 0);
                message3 : in  std_logic_vector(3 downto 0);
                r0 : in STD_LOGIC;
                r1 : in STD_LOGIC;
                r2 : in STD_LOGIC;
                r3 : in STD_LOGIC;
                y0 : out STD_LOGIC_VECTOR (1 downto 0);
                y1 : out STD_LOGIC_VECTOR (1 downto 0);
                y2 : out STD_LOGIC_VECTOR (1 downto 0);
                y3 : out STD_LOGIC_VECTOR (1 downto 0) 
    
    );
end omega_network_prio_fissa;

architecture Structural of omega_network_prio_fissa is
    
    component network is
        Port (
                n0 : in STD_LOGIC_VECTOR (1 downto 0);
                n1 : in STD_LOGIC_VECTOR (1 downto 0);
                n2 : in STD_LOGIC_VECTOR (1 downto 0);
                n3 : in STD_LOGIC_VECTOR (1 downto 0);
                source : in STD_LOGIC_VECTOR(1 downto 0);
                dest : in STD_LOGIC_VECTOR(1 downto 0);
                y0 : out STD_LOGIC_VECTOR (1 downto 0);
                y1 : out STD_LOGIC_VECTOR (1 downto 0);
                y2 : out STD_LOGIC_VECTOR (1 downto 0);
                y3 : out STD_LOGIC_VECTOR (1 downto 0)
         );
    end component;
    
    component uc is
        Port (  
                r0       : in  std_logic;
                r1       : in  std_logic;
                r2       : in  std_logic;
                r3       : in  std_logic;
                dest0  : in std_logic_vector(1 downto 0);
                dest1  : in std_logic_vector(1 downto 0);
                dest2  : in std_logic_vector(1 downto 0);
                dest3  : in std_logic_vector(1 downto 0);
                source   : out std_logic_vector(1 downto 0);
                dest     : out std_logic_vector(1 downto 0)
         );
    end component;
    
    signal source_signal : std_logic_vector(1 downto 0);
    signal dest_signal : std_logic_vector(1 downto 0);
begin
    
    u:uc
        Port Map(  
                r0=> r0,      
                r1=> r1,      
                r2=> r2,      
                r3=> r3,
                dest0=>message0(3 downto 2),      
                dest1=>message1(3 downto 2),      
                dest2=>message2(3 downto 2),      
                dest3=>message3(3 downto 2),      
                source =>source_signal,  
                dest=>dest_signal     
         );
    
    net:network 
        Port map(
                n0=>message0(1 downto 0),
                n1=>message1(1 downto 0),
                n2=>message2(1 downto 0),
                n3=>message3(1 downto 0),
                source=>source_signal,
                dest=>dest_signal,
                y0=>y0,
                y1=>y1,
                y2=>y2,
                y3=>y3
         );
    
end Structural;
