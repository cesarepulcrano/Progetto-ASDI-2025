----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2025 03:16:38 PM
-- Design Name: 
-- Module Name: contatore_mod_N - Structural
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

entity contatore_mod_32 is
    --Generic(N   :   integer :=16);
    Port (  clock   :   in  std_logic;
            reset   :   in  std_logic;
            set     :   in  std_logic;
            load    :   in  std_logic_vector(integer(ceil(log2(real(32))))-1    downto  0);
            cont    :   out std_logic_vector(integer(ceil(log2(real(32))))-1    downto  0);
            co      :   out std_logic
    );
end contatore_mod_32;



architecture Structural of contatore_mod_32 is
    
    signal ff_connect   :   std_logic_vector(integer(ceil(log2(real(32))))-1   downto  0);
    signal and_connect  :   std_logic_vector(integer(ceil(log2(real(32))))-2   downto  0);
    signal mux_connect  :   std_logic_vector(integer(ceil(log2(real(32))))-1   downto  0);
    component flip_flop_T   is
        port(   clock:  in  std_logic;
                reset:  in  std_logic;
                y:      out std_logic
        );
    end component;
    
    component   mux_2_1 is
        port(   x:  in std_logic_vector(1   downto  0);
                s:  in std_logic;
                y:  out std_logic
        );
    end component;
    
    component and_gate is
    Port ( a: in std_logic; b: in std_logic; y: out std_logic);
end component;
    
    begin
        mux0: mux_2_1
            port map(       x(0)=>clock,
                            x(1)=>load(0),
                            s=>set,
                            y=>mux_connect(0)
                    
            ); 
        --mux:for i in  1 to integer(ceil(log2(real(N))))-1 generate
        mux:for i in  1 to integer(ceil(log2(real(32))))-1 generate
            mux: mux_2_1
                port map(   x(0)=>and_connect(i-1),
                            x(1)=>load(i),
                            s=>set,
                            y=>mux_connect(i)
                    
                );
        end generate mux;
        
        --ff: for i in 0 to integer(ceil(log2(real(N))))-1 generate 
        ff: for i in 0 to integer(ceil(log2(real(32))))-1 generate
            ff: flip_flop_T
                port map(   clock=>mux_connect(i),
                            reset=>reset,
                            y=>ff_connect(i)
                );
        end generate ff;
        
        
        and_gate_0: and_gate
            Port map(   a=> ff_connect(0),
                        b=> clock,
                        y=>  and_connect(0)
            );
        --secondo stadio
        and_gate_1: and_gate
            Port map( a=>ff_connect(0) AND ff_connect(1),
                      b=>clock,
                      y=> and_connect(1)
            );
            --terzo
        and_gate_2: and_gate
            Port map( a=>ff_connect(0) AND ff_connect(1) AND ff_connect(2),
                      b=>clock,
                      y=>and_connect(2)
            );        
        and_gate_3: and_gate
            Port map( a=>ff_connect(0) AND ff_connect(1) AND ff_connect(2) AND ff_connect(3),
                      b=>clock,
                      y=>and_connect(3)
            ); 

      cont<=ff_connect;
      co<=ff_connect(4) ; 
    end Structural;
