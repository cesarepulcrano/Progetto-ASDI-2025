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

entity PO_PC_system is
    Generic (N : integer := 16);
    Port (  CLK : in std_logic;
            RST : in std_logic;
            START : in std_logic;
            data_out : out std_logic_vector(3 downto 0)
    );
end PO_PC_system;

architecture Structural of PO_PC_system is

    component PO is
        Generic (N : integer);
        Port (  CLK : in std_logic;
                RST : in std_logic;
                READ_ROM : in std_logic;
                WRITE_MEM : in std_logic;
                EN_COUNT : in std_logic;
                RST_COUNT : in std_logic;
                COUNT : out std_logic_vector(integer(ceil(log2(real(N))))-1 downto  0);
                data_out : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component PC is
        Generic (N : integer);
        Port (  CLK : in std_logic;
                RST : in std_logic;
                START : in std_logic;
                COUNT : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto  0);
                READ_ROM : out std_logic;
                WRITE_MEM : out std_logic;
                EN_COUNT : out std_logic;
                RST_COUNT : out std_logic
        );
    end component;
    
    signal rom_read : std_logic;
    signal mem_write : std_logic;
    signal count_en : std_logic;
    signal count_rst : std_logic;
    signal count_value : std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);

begin

    PO_part: PO
        Generic Map (N=>N)
        Port Map (  CLK=>CLK,
                    RST=>RST,
                    READ_ROM=>rom_read,
                    WRITE_MEM=>mem_write,
                    EN_COUNT=>count_en,
                    RST_COUNT=>count_rst,
                    COUNT=>count_value,
                    data_out=>data_out
        );
    
    
   
    PC_part: PC
        Generic Map (N=>N)
        Port Map (  CLK=>CLK,
                    RST=>RST,
                    START=>START,
                    COUNT=>count_value,
                    READ_ROM=>rom_read,
                    WRITE_MEM=>mem_write,
                    EN_COUNT=>count_en,
                    RST_COUNT=>count_rst
        );
end Structural;
