----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2025 07:31:13 PM
-- Design Name: 
-- Module Name: operational_unit - Structural
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
use IEEE.math_real.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity operational_unit is
    GENERIC(N: natural :=8);
    Port (  CLK: in std_logic;
            RST: in std_logic;
            X:  in  std_logic_vector(  N-1 downto 0);
            Y:  in  std_logic_vector(  N-1 downto 0);
            init: in std_logic;
            SHIFT:  in std_logic;
            LOAD_A: in std_logic;
            LOAD_Q: in std_logic;
            LOAD_M: in std_logic;
            SUBTRACT: in std_logic;
            en_count: in std_logic;
            Q0: out std_logic;
            Q1: out std_logic;
            count:  out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
            output:  out  std_logic_vector(  2*N-1 downto 0)
            
     );
end operational_unit;

architecture Structural of operational_unit is
    component shift_register is
        Generic(N : integer := 8);
        Port (  CLK     : in std_logic; -- Abilitazione
                RST     : in std_logic;
                input   : in std_logic;
                LOAD    : in std_logic;
                load_data: in std_logic_vector(N-1 downto 0);
                EN : in std_logic;
                s       : in std_logic:='1'; -- 0 = shift a destra, 1 = shift a sinistra
                Y       : in std_logic:='0'; -- 0 = shift di 1 bit, 1 = shift di 2 bit
                output  : out std_logic_vector (N-1 downto 0)
        );
    end component;
    
    component M_register is
        Generic(N: natural:=8);
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               load : in STD_LOGIC;
               input : in STD_LOGIC_VECTOR(N-1 downto 0);
               output : out STD_LOGIC_VECTOR(N-1 downto 0)
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
    
    component adder_subtractor is
        Generic(N : natural :=8);
        Port (  a:in std_logic_vector(N-1 downto 0);
                b:in std_logic_vector(N-1 downto 0);
                c_in: in std_logic;
                s: out std_logic_vector(N-1 downto 0);
                c_out : out std_logic
              );
    end component;
    
    component mux_2_1 is
        Port (  x : in std_logic_vector(1 downto 0);
                s : in std_logic;
                y : out std_logic
        );
    end component;
    
    signal A_to_Q :std_logic;
    signal sum_to_A:std_logic_vector(N-1 downto 0);
    signal M_out:std_logic_vector(N-1 downto 0);
    signal output_temp : std_logic_vector(2*N-1 downto 0);
    signal a_input:std_logic:='0';
    signal mux_to_A: std_logic_vector (N-1 downto 0);
    signal finale: std_logic:='0';
    
begin
    
    selettore:for i in  N-1 downto 0 generate
        mux:mux_2_1
        Port Map(   x(0)=>sum_to_A(i),
                    x(1)=>'0',
                    s=>init,
                    y=>mux_to_A(i)
        );
    
    end generate;
        

    A: shift_register 
        Generic Map(N=>N)
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    input=>a_input,
                    LOAD=>LOAD_A,
                    load_data=>mux_to_A,
                    EN=>SHIFT,
                    s=>'1',
                    Y=>'0',
                    output=>output_temp(2*N-1 downto N)
        );
    a_input<=output_temp(2*N-1);
    A_to_Q<=output_temp(N);
    
    Q: shift_register 
        Generic Map(N=>N+1)
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    input=>A_to_Q,
                    LOAD=>LOAD_Q,
                    load_data=>X&"0",
                    EN=>SHIFT,
                    s=>'1',
                    Y=>'0',
                    output(N downto 1)=>output_temp(N-1 downto 0),
                    output(0)=>Q0
        );
      --Q0<=output(0);
      Q1<=output_temp(0); 
      
      M:M_register 
        Generic Map(N=>N)
        Port Map( CLK=>CLK,
               RST=>RST,
               load=>LOAD_M,
               input=>Y,
               output=>M_out
               );
               
      contatore_mod_8:contatore_mod_N         
          Generic Map(N=>N)
          Port Map( clock=>en_count ,
                    reset=>RST,
                    set=>'0',
                    load=>(others=>'0'),
                    cont=>count
            );
      
      adder:adder_subtractor
        Generic Map(N=>N)
        Port Map(   a=>output_temp(2*N-1 downto N),
                    b=>M_out,
                    c_in=>SUBTRACT,
                    s=>sum_to_A
              );
        output<=output_temp;   
end Structural;        