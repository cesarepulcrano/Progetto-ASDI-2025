----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2025 12:37:52 PM
-- Design Name: 
-- Module Name: PO_PC_fpga - Structural
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

entity PO_PC_fpga is
    Port (  CLK100MHZ : in std_logic;
            BTNL : in std_logic;
            BTNR : in std_logic;
            LED : out std_logic_vector(3 downto 0)
    );
    end PO_PC_fpga;

architecture Structural of PO_PC_fpga is
    
    component PO_PC_system 
        Generic (N : integer := 16);
        Port (  CLK : in std_logic;
                RST : in std_logic;
                START : in std_logic;
                data_out : out std_logic_vector(3 downto 0)
        );
    end component;
begin
   system: PO_PC_system 
        Port Map(   CLK=>CLK100MHZ,
                    RST=>BTNL,
                    START=>BTNR,
                    data_out=>LED
        );
    

end Structural;
