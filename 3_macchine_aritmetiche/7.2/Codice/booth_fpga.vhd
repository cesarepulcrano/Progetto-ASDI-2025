----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 06:38:31 PM
-- Design Name: 
-- Module Name: booth_fpga - Structural
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

entity booth_fpga is
    Generic (   N: natural :=8);
    Port (  CLK100MHZ : in std_logic;
            BTNR: in std_logic;
            SW_X: in std_logic_vector(N-1 downto 0);
            SW_Y: in std_logic_vector(N-1 downto 0);
            BTNL: in std_logic;
            LED:  out  std_logic_vector(2*N-1 downto 0)
             );
end booth_fpga;

architecture Structural of booth_fpga is
    component booth_multiplier is
        Generic(N: natural :=8);
        Port (  CLK:    in  std_logic;
                RST:    in  std_logic;
                ENABLE: in  std_logic;
                X:      in  std_logic_vector(N-1 downto 0);
                Y:      in  std_logic_vector(N-1 downto 0);
                output: out std_logic_vector(2*N-1 downto 0) 
         );
    end component;
    
    component ButtonDebouncer is
        generic (                       
            CLK_period: integer := 10;  -- periodo del clock (della board) in nanosecondi
            btn_noise_time: integer := 10000000 -- durata stimata dell'oscillazione del bottone in nanosecondi
                                                -- il valore di default è 10 millisecondi
        );
        Port ( RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               BTN : in STD_LOGIC;
               CLEARED_BTN : out STD_LOGIC);
    end component;
    
    signal BTNR_sig: std_logic;
    signal BTNL_sig: std_logic;
begin
    
    rst:ButtonDebouncer
        Port Map(   RST=>BTNR_sig,
                    CLK=>CLK100MHZ,
                    BTN=>BTNR,
                    CLEARED_BTN=>BTNR_sig
                    );
    
    start:ButtonDebouncer
        Port Map(   RST=>BTNR_sig,
                    CLK=>CLK100MHZ,
                    BTN=>BTNL,
                    CLEARED_BTN=>BTNL_sig
                    );
    
    boot: booth_multiplier
        Generic Map(N=>N)
        Port Map(   CLK=>CLK100MHZ,
                    RST=>BTNR_sig,
                    ENABLE=>BTNL_sig,
                    X=>SW_X(N-1 downto 0),
                    Y=>SW_Y(N-1 downto 0),
                    output=>LED
                );

end Structural;
