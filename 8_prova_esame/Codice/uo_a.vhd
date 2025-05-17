----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 05:30:08 PM
-- Design Name: 
-- Module Name: uo_a - Structural
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

entity uo_a is
    Port (
            clk: in std_logic;
            rst: in std_logic;
            en_count: in std_logic;
            read_rom: in std_logic;
            count: out std_logic_vector(2 downto 0);
            data_out: out std_logic_vector(3 downto 0)
    
     );
end uo_a;

architecture Structural of uo_a is
    
    component contatore_mod_N is
        Generic (N: integer := 60);
        Port (      clock   :   in  std_logic;
                    reset   :   in  std_logic;
                    set     :   in  std_logic;
                    load    :   in  std_logic_vector(integer(ceil(log2(real(N))))-1 downto  0);
                    cont    :   out  std_logic_vector(integer(ceil(log2(real(N))))-1    downto  0);
                    co      :   out std_logic
        );
    end component;
    
    component ROM_A is
        Generic(N : natural := 8;
                M : natural := 8);
        Port (  CLK : in std_logic;
                EN  : in std_logic;
                address : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0); -- Codifica da 0 a N-1
                data_out : out std_logic_vector(M-1 downto 0)
        );
    end component;
    
    signal address: std_logic_vector(2 downto 0);
    
begin

    contatore: contatore_mod_N 
        Generic Map(N=>8)
        Port map(   clock=>en_count,
                    reset=>rst,
                    set  =>'0',
                    load =>(others=>'0'),
                    cont =>address
        );
        
    rom:ROM_A 
        Generic Map(N=> 8,M=>4)
        Port Map(   CLK     =>clk,
                    EN      =>read_rom,
                    address =>address,
                    data_out=>data_out
        );
     
     count<=address;       
end Structural;
