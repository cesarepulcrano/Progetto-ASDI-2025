----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2025 03:27:35 AM
-- Design Name: 
-- Module Name: cronometro_intertempi - Structural
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cronometro_intertempi is
    Generic(N: natural :=4);    
    Port (
                clk : in STD_LOGIC;
                rst : in STD_LOGIC;
                start: in std_logic;
                save: in std_logic;
                second:    out std_logic_vector(5 downto 0);
                minute:    out std_logic_vector(5 downto 0);
                hour  :    out std_logic_vector(4 downto 0);
                intertempo_second:  out std_logic_vector(5 downto 0);
                intertempo_minute: out  std_logic_vector(5 downto 0);
                intertempo_hour: out    std_logic_vector(4 downto 0)
     );
end cronometro_intertempi;

architecture Structural of cronometro_intertempi is
    
    component cronometro_intertempi_uc is
        Generic(N: natural:=4);
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               start: in std_logic;
               en_count : out STD_LOGIC;
               save: in std_logic;
               write_mem : out STD_LOGIC;
               count : in STD_LOGIC_VECTOR (integer(ceil(log2(real(N))))-1 downto 0)
               );
    end component;
    
    component cronometro_intertempi_uo is
        Generic(N: natural:=4);
        Port (  CLK: in std_logic;
                RST: in std_logic;
                set: in std_logic;
                load_second:in std_logic_vector(5 downto 0);
                load_minute: in std_logic_vector(5 downto 0);
                load_hour:  in std_logic_vector(4 downto 0);
                cont_second:    out std_logic_vector(5 downto 0);
                cont_minute:    out std_logic_vector(5 downto 0);
                cont_hour  :    out std_logic_vector(4 downto 0);
                write_mem:   in std_logic;
                en_count_address:   in std_logic;
                mem_out: out std_logic_vector(16 downto 0);
                count_address:   in std_logic_vector(integer(ceil(log2(real(N))))-1 downto  0);
                c_out       :   out std_logic
            );
    end component;
    
    signal en_count_sig:std_logic;
    signal write_mem_sig:std_logic;
    signal count_sig:std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
    
    signal sec_sig:std_logic_vector(6 downto 0);
    signal min_sig:std_logic_vector(6 downto 0);
    signal hour_sig:std_logic_vector(5 downto 0);
    signal intertempi: std_logic_vector(16 downto 0);
    
begin
    
    uc:cronometro_intertempi_uc 
        Generic Map(N=>N)
        Port Map( 
               clk                   =>clk,
               rst                   =>rst,
               start                 =>start,
               en_count              =>en_count_sig,
               save                  =>save,
               write_mem             =>write_mem_sig,
               count                 =>count_sig
          );                           
    uo:cronometro_intertempi_uo   
        Generic Map(N=>N)      
        Port Map(  
                CLK                  =>clk,
                RST                  =>rst,
                set                  =>'0',
                load_second          =>(others=>'0'),
                load_minute          =>(others=>'0'),
                load_hour            =>(others=>'0'),
                cont_second          =>second,
                cont_minute          =>minute,
                cont_hour            =>hour,
                write_mem            =>write_mem_sig,
                en_count_address     =>en_count_sig,
                count_address=>count_sig,
                mem_out              =>intertempi

            );
    intertempo_second<=intertempi(5 downto 0);
    intertempo_minute<=intertempi(11 downto 6);
    intertempo_hour<=intertempi(16 downto 12);
end Structural;
