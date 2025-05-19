----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 02:15:41 AM
-- Design Name: 
-- Module Name: UO - Structural
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

entity UO is
    Generic (   N           :   natural :=4); 
    Port    (   clk         :   in      std_logic;
                rst         :   in      std_logic;
                D           :   in      std_logic_vector(   N-1 downto  0   );
                V           :   in      std_logic_vector(   N-1 downto  0   );
                init        :   in      std_logic;
                en_count    :   in      std_logic                            ;
                load_m      :   in      std_logic                            ;
                load_q      :   in      std_logic                            ;
                load_a      :   in      std_logic                            ;
                subtract    :   in      std_logic                            ;
                shift       :   in      std_logic                            ;
                count       :   out     std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
                s           :   out     std_logic;
                risultato   :   out     std_logic_vector(   N-1 downto  0   ) 
                );
end UO;

architecture Structural of UO is
    
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
    
    component M_register is
        Generic(N: natural:=8);
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               load : in STD_LOGIC;
               input : in STD_LOGIC_VECTOR(N-1 downto 0);
               output : out STD_LOGIC_VECTOR(N-1 downto 0)
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
    
    component shift_register is
        Generic(N : integer := 8);
        Port (  clk     : in std_logic;
                rst     : in std_logic;
                en     : in std_logic;
                input   : in std_logic;
                load    : in std_logic;
                data_in: in std_logic_vector(N-1 downto 0);
                serial_out: out std_logic;
                output  : out std_logic_vector (N-1 downto 0)
        );
    end component;
    
    component flip_flop_d is
        Port (  D   : in std_logic;
                A   : in std_logic;
                EN  : in std_logic;
                RST : in std_logic;
                Q   : out std_logic
        );
    end component;
    
    component mux_2_1 is
    Port (  x : in std_logic_vector(1 downto 0);
            s : in std_logic;
            y : out std_logic
    );
    end component;
    
    signal  b_to_sum    :   std_logic_vector(N-1 downto 0);
    signal  q_to_a      :   std_logic:='0';
    signal  a_to_s      :   std_logic;
    signal  s_to_q      :   std_logic;
    signal  s_out      :   std_logic;
    signal  try      :   std_logic;
    signal  sum_out     :   std_logic_vector(2*N-1 downto 0);
    signal  mux_to_a    :   std_logic_vector(2*N-1 downto 0);
    signal  quoziente   :   std_logic_vector(N-1 downto 0);
    signal  resto       :   std_logic_vector(2*N-1 downto 0);
    signal  a_setup     :   std_logic_vector(2*N-1 downto 0);
begin
    a_setup<="0000"& D;
    contatore:contatore_mod_N
        Generic Map(N=>N)
        Port Map(      clock=>en_count,
                    reset=>rst,
                    set=>'0',
                    load=>(others=>'0'),
                    cont=>count
        );
    
    M:  M_register 
        Generic Map (    N=>N)
        Port map    (   CLK=>clk,
                        RST=>rst,
                        load=>load_m,
                        input=>V,
                        output=>b_to_sum
               );
    
    Q: shift_register
        Generic Map(N=>N)
        Port Map(   clk=>clk,    
                    rst=>rst,
                    en=>shift,
                    input=>'0',
                    load=>load_q,
                    data_in=>D,
                    serial_out=>q_to_a,
                    output=>quoziente
        );
    try<=quoziente(0);
    selettore:for i in  2*N-1 downto 0 generate
        mux:mux_2_1
        Port Map(   x(0)=>sum_out(i),
                    x(1)=>a_setup(i),
                    s=>init,
                    y=>mux_to_A(i)
        );
    
    end generate;
    
    A: shift_register
        Generic Map(N=>2*N)
        Port Map(   clk=>clk,    
                    rst=>rst,
                    en=>shift,
                    input=>q_to_a,
                    load=>load_a,
                    data_in=>mux_to_a,
                    serial_out=>a_to_s,
                    output=>resto
        );
    risultato<=quoziente;
    S_reg: flip_flop_d
        Port Map(   D=>a_to_s,
                    A=>clk,
                    EN=>shift,
                    RST=>rst,
                    Q=>s_out
        );
    
    adder: adder_subtractor
    Generic Map(N=>2*N)
    Port Map(   a=>resto,
                b=>"0000"&b_to_sum,
                c_in=>subtract,
                s=>sum_out
          );

    
       s_to_q<=not(s_out);
       s<=s_out;  
end Structural;
