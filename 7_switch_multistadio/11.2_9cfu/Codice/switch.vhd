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
    Generic(Stage:natural:=0);
    Port (  
            clk : std_logic;
            rst: std_logic;
            x0 : in STD_LOGIC_VECTOR (6 downto 0);
            x1  : in STD_LOGIC_VECTOR (6 downto 0);
            y0 : out STD_LOGIC_VECTOR (6 downto 0);
            y1 : out STD_LOGIC_VECTOR (6 downto 0)
           );
end switch;

architecture Structural of switch is
    
    component uc_switch is
      Generic(Stage:natural:=0);
          Port (clk : std_logic;
                rst: std_logic;
                message0: in std_logic_vector(6 downto 0);
                message1: in std_logic_vector(6 downto 0);
                message_out0:out std_logic_vector(6 downto 0);
                message_out1:out std_logic_vector(6 downto 0);
                source_out: out std_logic;
                dest_out: out std_logic
             );
    end component;
    
    component uo_switch is
        Port ( 
                x0 : in STD_LOGIC_VECTOR (6 downto 0);
                x1 : in STD_LOGIC_VECTOR (6 downto 0);
                s_in : in STD_LOGIC;
                s_out : in STD_LOGIC;
                y0 : out STD_LOGIC_VECTOR (6 downto 0);
                y1 : out STD_LOGIC_VECTOR (6 downto 0)
               );
    end component;
    
    signal sel:std_logic;
    signal dest: std_logic;
    signal message0_uc: std_logic_vector(6 downto 0);
    signal message1_uc: std_logic_vector(6 downto 0);
begin
      uc: uc_switch 
      Generic Map(Stage=>Stage)
      Port Map( clk=>clk,
                rst=>rst,
                message0 =>x0,
                message1 =>x1,
                message_out0=>message0_uc,
                message_out1=>message1_uc,
                source_out=>sel,
                dest_out=>dest
             );
        
      uo:uo_switch 
        Port Map( 
                x0    =>message0_uc,
                x1    =>message1_uc,
                s_in  =>sel,
                s_out =>dest,
                y0    =>y0,
                y1    =>y1
               );
end Structural;
