----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2025 14:09:02
-- Design Name: 
-- Module Name: mux_2_1 - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_register is
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
end shift_register;

architecture Structural of shift_register is

    signal retro : std_logic_vector(N-1 downto 0);-- := (others => 'U');
    signal mux_ff: std_logic_vector (N-1 downto 0);
    signal mux_4_to_mux_2:std_logic_vector (N-1 downto 0);
        
    component mux_2_1
        Port (  x : in std_logic_vector(1 downto 0);
                s : in std_logic;
                y : out std_logic
        );
    end component;
    
    component mux_4_1
        Port (  x   :   in  std_logic_vector    (3  downto  0);
                s   :   in  std_logic_vector    (1  downto  0);
                y   :   out std_logic
        );
    end component;
    
    component flip_flop_d
        Port (  D   : in std_logic;
                A   : in std_logic;
                EN  : in std_logic;
                RST : in std_logic;
                Q   : out std_logic
        );
    end component;

begin
    
    mux_load:for i in N-1 downto 0  generate
        mux:mux_2_1
            Port Map(  x(0)=>mux_4_to_mux_2(i),
                       x(1)=>load_data(i),
                       s=>LOAD,
                       y=>mux_ff(i)
            );
            end generate;
    
    mux:for i in N-1 downto 0  generate
        border_mux:if(i=0 ) generate 
            mux0 : mux_4_1
                Port map( x(0) => input ,--AND LOAD,
                      x(1) => retro(i+1),
                      x(2) => '0',
                      x(3) => retro(i+2),
                      s(0) => s,
                      s(1) => Y,
                      y => mux_4_to_mux_2(i) 
                 );
             elsif(i=1 AND N>3) generate
             
                mux1 : mux_4_1
                    Port map( x(0) => retro(i-1),
                          x(1) => retro(i+1),
                          x(2) => input,
                          x(3) => retro(i+2),
                          s(0) => s,
                          s(1) => Y,
                          y => mux_4_to_mux_2(i)
                     );
             elsif(i=N-2 AND N>3) generate
             
                muxN_2 : mux_4_1
                    Port map( x(0) => retro(i-1),
                          x(1) => retro(i+1),
                          x(2) => retro(i-2),
                          x(3) => input,
                          s(0) => s,
                          s(1) => Y,
                          y => mux_4_to_mux_2(i)
                     );
             elsif(i=N-1) generate
             
                muxN_1 : mux_4_1
                    Port map( x(0) => retro(i-1),
                          x(1) => input,
                          x(2) => retro(i-2),-- AND LOAD,
                          x(3) => '0',
                          s(0) => s,
                          s(1) => Y,
                          y => mux_4_to_mux_2(i)
                     );
             else generate
                mux : mux_4_1
                    Port map( x(0) => retro(i-1),
                          x(1) => retro(i+1),
                          x(2) => retro(i-2),
                          x(3) => retro(i+2),
                          s(0) => s,
                          s(1) => Y,
                          y => mux_4_to_mux_2(i)
                     );        
             end generate border_mux;
            
        
                        
      end generate mux;
        
      FlipFlop:for i in N-1 downto 0 generate
        FF:flip_flop_d
            Port Map( D=>mux_ff(i),
                      A=>CLK,
                      EN=>EN OR LOAD,
                      RST=>RST,
                      Q=>retro(i)
            );
      end generate FlipFlop;
      
      output<=retro;  
end Structural;
