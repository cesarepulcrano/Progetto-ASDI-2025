----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2025 18:18:05
-- Design Name: 
-- Module Name: PO - Behavioral
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
use IEEE.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PO is
    Generic (N : integer := 16);
    Port (  CLK : in std_logic;
            RST : in std_logic;
            READ_ROM : in std_logic;
            WRITE_MEM : in std_logic;
            EN_COUNT : in std_logic;
            RST_COUNT : in std_logic;
            COUNT : out std_logic_vector(integer(ceil(log2(real(N))))-1 downto  0);
            data_out : out std_logic_vector(3 downto 0)
    );
end PO;

architecture Structural of PO is

    component contatore_mod_N is
        Generic (N: integer);
        Port (      clock   :   in  std_logic;
                    reset   :   in  std_logic;
                    set     :   in  std_logic;
                    load    :   in  std_logic_vector(integer(ceil(log2(real(N))))-1 downto  0);
                    cont    :   out  std_logic_vector(integer(ceil(log2(real(N))))-1    downto  0);
                    co      :   out std_logic
        );
    end component;

    component ROM is
        Generic(N : integer);
        Port (  CLK : in std_logic;
                EN  : in std_logic;
                address : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0); -- Codifica da 0 a N-1
                data_out : out std_logic_vector(7 downto 0)
        );
    end component;
    
    component M_machine is
        port (
            input   :   in std_logic_vector(7 downto 0); -- Valore contenuto nella ROM
            output  :   out std_logic_vector(3 downto 0) -- Output trasformato
        );
    end component;
    
    component MEM is
        Generic(N : integer);
        Port (  CLK : in std_logic;
                RST : in std_logic;
                EN  : in std_logic;
                data_in : in std_logic_vector(3 downto 0);
                address : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0); -- Codifica da 0 a N-1
                data_out : out std_logic_vector(3 downto 0)
        );
    end component;
    
    signal rom_out : std_logic_vector(7 downto 0) := (others => '0');
    signal count_in : std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0) := (others => '0');
    signal count_end : std_logic;
    signal mem_in : std_logic_vector(3 downto 0) := (others => '0');

begin

    counter : contatore_mod_N
        Generic Map (N=>N)
        Port Map (  clock=>CLK,
                    reset=>RST,
                    set=>EN_COUNT,
                    load=>(others => '0'),
                    cont=>count_in,
                    co=>count_end
        );
    
    COUNT <= count_in; -- Aggiornamento del contatore per il sistema completo
    count_end <= RST_COUNT;

    ROM_mem : ROM
        Generic Map (N=>N)
        Port Map (  CLK=>CLK,
                    EN=>READ_ROM,
                    address=>count_in,
                    data_out=>rom_out
        );
        
    M : M_machine
        Port Map (
            input=>rom_out,
            output=>mem_in
        );
        
   MEM_store: MEM
        Generic Map (N=>N)
        Port Map (  CLK=>CLK,
                RST=>RST,
                EN=>WRITE_MEM,
                data_in=>mem_in,
                address=>count_in,
                data_out=>data_out
        );

end Structural;
