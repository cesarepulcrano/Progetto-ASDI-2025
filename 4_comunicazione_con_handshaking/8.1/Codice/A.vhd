----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 11:21:00 AM
-- Design Name: 
-- Module Name: A - Structural
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

entity A is
    Generic(N:natural:=8;
            M:natural:=8);
    Port (  CLK:    in std_logic;
            RST:    in std_logic;
            START:  in  std_logic;
            ACK:    in  std_logic;
            REQ:    out std_logic;
            data:   out std_logic_vector(M-1 downto 0) );
end A;

architecture Structural of A is
    
    component uc_a is
        Generic(N:natural:=8);
        Port (  CLK:    in  std_logic;
                RST:    in  std_logic;
                START:  in  std_logic;
                COUNT:  in  std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
                ACK :   in  std_logic;
                REQ :   out std_logic;
                EN_COUNT:    out  std_logic;
                RST_COUNT:   out  std_logic;
                READ_ROM:   out std_logic
                 );
    end component;
    
    component uo_a is
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
    end component;
    
    signal en_count: std_logic;
    signal rst_count:std_logic;
    signal read_rom:std_logic;
    signal count: std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
    
begin
    
    uc: uc_a
        Generic Map(N=>N) 
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    START=>START,
                    COUNT=>count,
                    ACK=>ACK,
                    REQ=>REQ,
                    EN_COUNT=>en_count,
                    RST_COUNT=>rst_count,
                    READ_ROM=>read_rom
                 );
    
    uo: uo_a
        Generic Map(N=>N,
                    M=>M)
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    EN_COUNT=>en_count,
                    RST_COUNT=>rst_count,
                    READ_ROM=>read_rom,
                    COUNT=>count,
                    data=>data
                );

end Structural;
