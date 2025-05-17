----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 08:48:35 PM
-- Design Name: 
-- Module Name: test_register - Structural
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

entity test_register is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           load : in STD_LOGIC;
           input : in STD_LOGIC_VECTOR (3 downto 0);
           output : out STD_LOGIC_VECTOR (3 downto 0));
end test_register;

architecture Structural of test_register is
    component mux_2_1 is
        Port (  x : in std_logic_vector(1 downto 0);
                s : in std_logic;
                y : out std_logic
        );
    end component;
    
    component flip_flop_d is
        Port (  D   : in std_logic;
                A   : in std_logic;
                RST : in std_logic;
                Q   : out std_logic
        );
    end component;
    
    signal mux_to_ff: std_logic_vector(3 downto 0);
    signal ff_out: std_logic_vector(3 downto 0);
begin
    
    mux0:mux_2_1 
        Port Map(   x(0)=>ff_out(0),
                    x(1)=>input(0),
                    s=>load,
                    y=>mux_to_ff(0)
        );
     
        
    ff0:flip_flop_d 
        Port Map(   D  =>mux_to_ff(0),
                    A  =>clk,
                    RST=>rst,
                    Q  =>ff_out(0)
        );
    
    mux1:mux_2_1 
        Port Map(   x(0)=>ff_out(1),
                    x(1)=>input(1),
                    s=>load,
                    y=>mux_to_ff(1)
        );
     
        
    ff1:flip_flop_d 
        Port Map(   D  =>mux_to_ff(1),
                    A  =>clk,
                    RST=>rst,
                    Q  =>ff_out(1)
        );
    
    mux2:mux_2_1 
        Port Map(   x(0)=>ff_out(2),
                    x(1)=>input(2),
                    s=>load,
                    y=>mux_to_ff(2)
        );
     
        
    ff2:flip_flop_d 
        Port Map(   D  =>mux_to_ff(2),
                    A  =>clk,
                    RST=>rst,
                    Q  =>ff_out(2)
        );
    
    mux3:mux_2_1 
        Port Map(   x(0)=>ff_out(3),
                    x(1)=>input(3),
                    s=>load,
                    y=>mux_to_ff(3)
        );
     
        
    ff3:flip_flop_d 
        Port Map(   D  =>mux_to_ff(3),
                    A  =>clk,
                    RST=>rst,
                    Q  =>ff_out(3)
        );
        
     output<=ff_out;               
end Structural;
