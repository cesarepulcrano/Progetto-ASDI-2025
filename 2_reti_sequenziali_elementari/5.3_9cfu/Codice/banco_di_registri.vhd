----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 07:17:44 PM
-- Design Name: 
-- Module Name: banco_di_registri - Structural
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

entity banco_di_registri is
    Generic (N:natural:=4);
    Port (  CLK: in std_logic;
            RST: in std_logic;
            EN:  in std_logic;
            input : in std_logic_vector(16 downto 0);
            output : out std_logic_vector(16 downto 0) );
end banco_di_registri;

architecture Structural of banco_di_registri is
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
                soutput  : out std_logic;
                output : out std_logic_vector (N-1 downto 0)
        );
        end component;

    signal chain:std_logic_vector(N-1 downto 0):=(others=>'0');


begin
    
   
        
       sr0:shift_register 
        Generic Map(N=>17)
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    input=>'0',
                    LOAD=>'0',
                    load_data=>input,
                    EN=>EN,
                    s=>'1',
                    Y=>'0',
                    soutput=>chain(0)
                    --output(0)=>chain(0)
        );
    
    banco : for i in N-2 downto 0 generate
    sr:shift_register 
        Generic Map(N=>17)
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    input=>chain(i),
                    LOAD=>'0',
                    load_data=>(others=>'0'),
                    EN=>EN,
                    s=>'1',
                    Y=>'0',
                    soutput=>chain(i+1)
                    --output(0)=>chain(i+1)
        );
    end generate;
    srN:shift_register 
        Generic Map(N=>17)
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    input=>chain(N-1),
                    LOAD=>'0',
                    load_data=>(others=>'0'),
                    EN=>EN,
                    s=>'1',
                    Y=>'0',
                    output=>output
        );
end Structural;
