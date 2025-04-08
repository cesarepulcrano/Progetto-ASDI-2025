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
    Generic(N : integer := 2);
    Port (  input   : in std_logic;
            RST     : in std_logic;
            CLK     : in std_logic; -- Abilitazione
            s       : in std_logic; -- 0 = shift a destra, 1 = shift a sinistra
            Y       : in std_logic; -- 0 = shift di 1 bit, 1 = shift di 2 bit
            output  : out std_logic
    );
end shift_register;

architecture Structural of shift_register is

    signal retro : std_logic_vector(N-1 downto 0) := (others => 'U');

    component mux_2_1
        Port (  x : in std_logic_vector(1 downto 0);
                s : in std_logic;
                y : out std_logic
        );
    end component;
    
    component flip_flop_d
        Port (  D   : in std_logic;
                A   : in std_logic;
                RST : in std_logic;
                Q   : out std_logic
        );
    end component;

begin

    shift : for i in N-1 downto 1 generate
        mux : mux_2_1
            Port map( x(0) => retro(i),
                      x(1) => retro(i-1),
                      s => s,
                      y => retro(i)
            );
    end generate shift;
        
end Structural;
