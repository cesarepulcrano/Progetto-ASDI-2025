----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 11:21:00 AM
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uo_b is
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
end uo_b;

architecture Structural of uo_b is
    
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
    
    component ROM_B is
        Generic(N : natural := 8;
                M : natural := 8);
        Port (  CLK : in std_logic;
                EN  : in std_logic;
                address : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0); -- Codifica da 0 a N-1
                data_out : out std_logic_vector(M-1 downto 0)
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
    
    component reg is
        Generic(N: natural:=8);
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               load : in STD_LOGIC;
               input : in STD_LOGIC_VECTOR(N-1 downto 0);
               output : out STD_LOGIC_VECTOR(N-1 downto 0)
               );
    end component;
    
    component ripple_carry_adder is
        Generic(N : natural :=8);
        Port (  a:in std_logic_vector(N-1 downto 0);
                b:in std_logic_vector(N-1 downto 0);
                c_in: in std_logic;
                s: out std_logic_vector(N-1 downto 0);
                c_out : out std_logic
              );
    end component;
    
    signal conteggio :std_logic_vector (integer(ceil(log2(real(N))))-1    downto  0);
    signal operando_1 :std_logic_vector(M-1 downto 0);
    signal operando_2 :std_logic_vector(M-1 downto 0);
    signal risultato :std_logic_vector(M-1 downto 0);
    
begin
    
    contatore: contatore_mod_N 
        Generic Map(N=>N)
        Port Map(   clock=>EN_COUNT,
                    reset=>RST,
                    set=>'0',
                    load=>(others=>'0'),
                    cont=>conteggio
        );

    
    rom: ROM_B 
        Generic Map(N=>N,
                    M=>M)
        Port Map(   CLK=>CLK,
                    EN=>READ_ROM,
                    address=>conteggio, -- Codifica da 0 a N-1
                    data_out=>operando_1
        );

    
    memd: MEM
        Generic Map(N=>N,
                    M=>M)
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    EN=>WRITE_MEM,
                    data_in=>risultato,
                    address=>conteggio, -- Codifica da 0 a N-1
                    data_out=>data_out
        );

    
    reg_in: reg 
        Generic Map(N=>M)
        Port Map( CLK=>CLK,
               RST=>RST,
               load=>write_reg,
               input=>data_in,
               output=>operando_2
               );
    
    rca: ripple_carry_adder
        Generic Map(N=>M)
        Port Map(   a=>operando_1,
                    b=>operando_2,
                    c_in=>'0',
                    s=>risultato

              );
              
    count<=conteggio;

end Structural;
