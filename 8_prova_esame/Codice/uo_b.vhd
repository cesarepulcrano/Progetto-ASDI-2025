----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 05:30:08 PM
-- Design Name: 
-- Module Name: uo_b - Structural
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

entity uo_b is
    Port (  
            clk : in std_logic;
            rst : in std_logic;
            data_in : std_logic_vector(3 downto 0);
            write_reg_in : in std_logic;
            write_reg_out : in std_logic;
            data_out : out std_logic_vector
     );
end uo_b;

architecture Structural of uo_b is
    
    component sommatore_cla is
        Port (
                x: in   std_logic_vector(3 downto 0);
                y: in   std_logic_vector(3 downto 0);
                c_in: in std_logic;
                s: out  std_logic_vector(3 downto 0)
        
         );
    end component;
    
    component reg is
        Generic(N: natural:=8);
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               load : in STD_LOGIC;
               input : in STD_LOGIC_VECTOR(N-1 downto 0);
               output : out STD_LOGIC_VECTOR(N-1 downto 0)
               );
    end component;
    
    signal  reg_in_signal : std_logic_vector(3 downto 0);
    signal  reg_out_signal: std_logic_vector(3 downto 0);
    signal  ris           : std_logic_vector(3 downto 0); 
    
begin
    
    reg_in:reg 
        Generic Map(N=>4)
        Port Map(       CLK      =>clk,
                       RST      =>rst,
                       load     =>write_reg_in,
                       input    =>data_in,
                       output   =>reg_in_signal
                       );

    
    cla:sommatore_cla 
        Port Map(
                x   =>reg_in_signal,
                y   =>reg_out_signal,
                c_in=>'0',
                s   =>ris
        
         );
    
    reg_out:reg 
        Generic Map(N=>4)
        Port Map( CLK      =>clk,
               RST      =>rst,
               load     =>write_reg_out,
               input    =>ris,
               output   =>reg_out_signal
               );
     
     data_out<=reg_out_signal;
     
end Structural;
