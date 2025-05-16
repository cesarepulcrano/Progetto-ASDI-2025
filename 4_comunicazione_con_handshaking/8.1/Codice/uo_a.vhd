----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 11:21:00 AM
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
use IEEE.math_real.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uo_a is
    Generic(N:natural:=8;
            M:natural:=8);
    Port (  CLK:    in std_logic;
            RST:    in  std_logic;
            EN_COUNT:    in std_logic;
            RST_COUNT:   in std_logic;
            READ_ROM:   in  std_logic;
            COUNT:  out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
            data:   out std_logic_vector(M-1 downto 0)
            );
end uo_a;

architecture Structural of uo_a is
    
    component contatore_mod_N is
        Generic (N: integer := 60);
        Port (  clock   :   in  std_logic;
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
    
    signal conteggio :std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
    
begin
    
    contatore: contatore_mod_N
        Generic Map(N=>N)
        Port Map(  clock=>EN_COUNT,
                   reset=>RST,
                   set=>'0',
                   load=>(others=>'0'),
                   cont=>conteggio
        );
    
    ROM:    ROM_A 
        Generic Map(    N=>N,
                        M=>M)
        Port Map(   CLK=>CLK,
                    EN=>READ_ROM,
                    address=>conteggio,
                    data_out=>data
        );
    
    count<=conteggio;
end Structural;
