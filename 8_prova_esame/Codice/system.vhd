----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 05:30:08 PM
-- Design Name: 
-- Module Name: system - Structural
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

entity system is
    Port (  
            clk: in std_logic;
            rst: in std_logic;
            start: in std_logic;
            output: out std_logic_vector(3 downto 0)
     );
end system;

architecture Structural of system is
    
    component A is
        Port ( 
                clk: in std_logic;
                rst: in std_logic;
                start: in std_logic;
                req:  out std_logic;
                ack: in std_logic;
                data_out: out std_logic_vector(3 downto 0)
        );
    end component;
    
    component B is
        Port ( 
                clk: in std_logic;
                rst: in std_logic;
                req: in std_logic;
                ack: out std_logic;
                data_in: in std_logic_vector(3 downto 0);
                data_out: out std_logic_vector(3 downto 0)
        );
    end component;
    
    signal req_signal:std_logic;
    signal ack_signal:std_logic;
    signal a_to_b    :std_logic_vector(3 downto 0); 
    
begin

      a_unit:A 
        Port Map( 
                clk     =>clk,
                rst     =>rst,
                start   =>start,
                req     =>req_signal,
                ack     =>ack_signal,
                data_out=>a_to_b
        );
       
       b_unit:B 
        Port Map( 
                clk     =>clk,
                rst     =>rst,
                req     =>req_signal,
                ack     =>ack_signal,
                data_in =>a_to_b,
                data_out=>output
        ); 
end Structural;
