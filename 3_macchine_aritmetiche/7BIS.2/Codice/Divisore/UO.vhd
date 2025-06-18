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
                risultato   :   out     std_logic_vector(   N-1 downto  0   ) ;
                resto       :   out     std_logic_vector(   N-1 downto  0   )
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

    component mux_2_1 is
    Port (  x : in std_logic_vector(1 downto 0);
            s : in std_logic;
            y : out std_logic
    );
    end component;
    
    signal  b_to_sum    :   std_logic_vector(N-1 downto 0);
    signal  s_to_sum    :   std_logic_vector(N downto 0);
    signal  q_to_a      :   std_logic;
    signal  q_0         :   std_logic;
    signal  sum_out     :   std_logic_vector(N downto 0);
    signal  mux_to_a    :   std_logic_vector(N downto 0);
    signal  mux_to_q    :   std_logic_vector(N-1 downto 0);
    signal  quoziente   :   std_logic_vector(N-1 downto 0);
    signal  resto_sig   :   std_logic_vector(N downto 0);
    signal  a_to_sum    :   std_logic_vector(N downto 0);
    signal  mux_segno   :   std_logic_vector(N downto 0);
begin

    contatore:contatore_mod_N
        Generic Map(N=>N)
        Port Map(       clock=>en_count,
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
    
    selettoreq:for i in  N-1 downto 1 generate
        muxq:mux_2_1
        Port Map(   x(0)=>quoziente(i),
                    x(1)=>D(i),
                    s=>init,
                    y=>mux_to_q(i)
        );
    end generate;
    
    muxq_1:mux_2_1
        Port Map(   x(0)=>q_0,
                    x(1)=>D(0),
                    s=>init,
                    y=>mux_to_q(0)
        );
    
    Q: shift_register
        Generic Map(N=>N)
        Port Map(   clk=>clk,    
                    rst=>rst,
                    en=>shift,
                    input=>'0',
                    load=>load_q,
                    data_in=>mux_to_q,
                    serial_out=>q_to_a,
                    output=>quoziente
        );
    
    selettore_neg:for i in  N downto 0 generate
        mux:mux_2_1
        Port Map(   x(0)=>'0',
                    x(1)=>'1',
                    s=>D(N-1),
                    y=>mux_segno(i)
        );
    
    end generate;
    
    selettore:for i in  N downto 0 generate
        mux:mux_2_1
        Port Map(   x(0)=>sum_out(i),
                    x(1)=>mux_segno(i),
                    s=>init,
                    y=>mux_to_A(i)
        );
    
    end generate;
    
    A: shift_register
        Generic Map(N=>5)
        Port Map(   clk=>clk,    
                    rst=>rst,
                    en=>shift,
                    input=>q_to_a,
                    load=>load_a,
                    data_in=>mux_to_a,
                    output=>resto_sig
        );
    

    s_to_sum<="0" & b_to_sum; --prima c'era "0" controllare
    a_to_sum<=resto_sig;
    
    adder: adder_subtractor
        Generic Map(N=>5)
        Port Map(   a=>a_to_sum,
                    b=>s_to_sum,
                    c_in=>subtract,
                    s=>sum_out
              );

   q_0<=not(resto_sig(4)); 
   s<=resto_sig(4);
   risultato<=quoziente; 
   resto<=resto_sig(3 downto 0);    
end Structural;
