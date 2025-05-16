----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 02:01:56 PM
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
    Generic(N:natural:=8;
            M:natural:=8);
    Port (  CLK: in std_logic;
            RST: in std_logic;
            START: in std_logic;
            data_out:   out std_logic_vector(M-1 downto 0) 
            );
end system;

architecture Structural of system is
    
    component A is
        Generic(N:natural:=8;
                M:natural:=8);
        Port (  CLK:    in std_logic;
                RST:    in std_logic;
                START:  in  std_logic;
                ACK:    in  std_logic;
                REQ:    out std_logic;
                data:   out std_logic_vector(M-1 downto 0) );
    end component;
    
    component B is
        Generic(N:natural:=8;
                M:natural:=8);
        Port (  CLK:    in std_logic;
                RST:    in std_logic;
                REQ:    in std_logic;
                ACK:    out  std_logic;
                data_in:   in std_logic_vector(M-1 downto 0);
                data_out:   out std_logic_vector(M-1 downto 0) 
                );
    end component;
    
    signal ack:std_logic;
    signal req:std_logic;
    signal data:std_logic_vector(M-1 downto 0);
begin
    
    A_unit: A
        Generic Map(N=>N,
                    M=>M)
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    START=>START,
                    ACK=>ack,
                    REQ=>req,
                    data=>data
                 );
    
    B_unit: B
        Generic Map(N=>N,
                    M=>M)
        Port Map(   CLK=>CLK,
                    RST=>RST,
                    REQ=>req,
                    ACK=>ack,
                    data_in=>data,
                    data_out=>data_out
                );


end Structural;
