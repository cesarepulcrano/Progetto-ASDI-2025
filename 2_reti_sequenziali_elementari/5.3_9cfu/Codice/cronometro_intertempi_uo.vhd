----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2025 08:18:38 PM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cronometro_intertempi_uo is
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
            count_address:   in std_logic_vector(integer(ceil(log2(real(N))))-1 downto  0);
            mem_out: out std_logic_vector(16 downto 0);
            c_out       :   out std_logic
        );
end cronometro_intertempi_uo;

architecture Structural of cronometro_intertempi_uo is
    component cronometro is
        Port (  CLK: in std_logic;
                RST: in std_logic;
                set: in std_logic;
                
                load_second:in std_logic_vector(5 downto 0);
                load_minute: in std_logic_vector(5 downto 0);
                load_hour:  in std_logic_vector(4 downto 0);
                
                cont_second:    out std_logic_vector(5 downto 0);
                cont_minute:    out std_logic_vector(5 downto 0);
                cont_hour  :    out std_logic_vector(4 downto 0);
                
                c_out       :   out std_logic
        );
    end component;
    
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
    
    
    component MEM is
        Generic(N : natural :=8;
                M : natural :=8);
        Port (  CLK : in std_logic;
                RST : in std_logic;
                EN  : in std_logic;
                data_in : in std_logic_vector(M-1 downto 0);
                address : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0); -- Codifica da 0 a N-1
                data_out : out std_logic_vector(M-1 downto 0)
        );
    end component;
    
    signal chrono_out:std_logic_vector(16 downto 0) ;
    signal mem_out_signal:std_logic_vector(16 downto 0) ;
    signal address: std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
    
    
begin
    
    chrono: cronometro
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    set=>set,
                    load_second=>load_second,
                    load_minute=>load_minute,
                    load_hour=>load_hour,
                    cont_second=>chrono_out(5 downto 0),
                    cont_minute=>chrono_out(11 downto 6),
                    cont_hour=>chrono_out(16 downto 12),
                    c_out=>c_out
        );
    
    m:MEM 
        Generic Map(N=>N,M=>17)
        Port Map(   CLK =>CLK,
                    RST    =>RST,
                    EN     =>write_mem,
                    data_in=>chrono_out,
                    address=>address, 
                    data_out=>mem_out_signal
        );
    
    cont_mem:contatore_mod_N 
        Generic Map(N=>4)
        Port Map(       clock=>en_count_address,
                        reset=>rst,
                        set=>'0',
                        load=>(others=>'0'),
                        cont=>address
        );
    
    cont_second<=chrono_out(5 downto 0);
    cont_minute<=chrono_out(11 downto 6);
    cont_hour<=chrono_out(16 downto 12);
    mem_out<=mem_out_signal;
end Structural;
