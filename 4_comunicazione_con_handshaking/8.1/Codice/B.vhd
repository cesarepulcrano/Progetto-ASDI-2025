----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 11:21:00 AM
-- Design Name: 
-- Module Name: B - Structural
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

entity B is
    Generic(N:natural:=8;
            M:natural:=8);
    Port (  CLK:    in std_logic;
            RST:    in std_logic;
            REQ:    in std_logic;
            ACK:    out  std_logic;
            data_in:   in std_logic_vector(M-1 downto 0);
            data_out:   out std_logic_vector(M-1 downto 0) 
            );
end B;

architecture Structural of B is
    
    component uc_b is
        Generic(N:natural:=8 );
        Port (  CLK:    in std_logic;
                RST:    in  std_logic;
                COUNT:  in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
                REQ:    in std_logic;
                EN_COUNT:    out std_logic;
                RST_COUNT:   out std_logic;
                READ_ROM:   out  std_logic;
                WRITE_MEM:  out std_logic;
                WRITE_REG:  out std_logic;
                ACK:    out std_logic
              );
    end component;
    
    component uo_b is
        Generic(N:natural:=8;
                M:natural:=8);
        Port (  CLK:    in std_logic;
                RST:    in  std_logic;
                EN_COUNT:    in std_logic;
                RST_COUNT:   in std_logic;
                READ_ROM:   in  std_logic;
                data_in:   in std_logic_vector(M-1 downto 0);
                WRITE_MEM:  in std_logic;
                WRITE_REG:  in std_logic;
                COUNT:  out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
                data_out:   out std_logic_vector(M-1 downto 0)
                );
    end component;
    
    signal conteggio: std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
    signal en_count : std_logic;
    signal rst_count : std_logic;
    signal read_rom:std_logic;
    signal write_mem:std_logic;
    signal write_reg:std_logic;
begin

    uc: uc_b
        Generic Map(N=>N )
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    COUNT=>conteggio,
                    REQ=>REQ,
                    EN_COUNT=>en_count,
                    RST_COUNT=>rst_count,
                    READ_ROM=>read_rom,
                    WRITE_MEM=>write_mem,
                    WRITE_REG=>write_reg,
                    ACK=>ACK
              );

    
    uo: uo_b
        Generic Map(N=>N,
                    M=>M)
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    EN_COUNT=>en_count,
                    RST_COUNT=>rst_count,
                    READ_ROM=>read_rom,
                    data_in=>data_in,
                    WRITE_MEM=>write_mem,
                    WRITE_REG=>write_reg,
                    COUNT=>conteggio,
                    data_out=>data_out
                );

end Structural;
