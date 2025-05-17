----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 05:30:08 PM
-- Design Name: 
-- Module Name: B - Structural
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

entity B is
    Port ( 
            clk: in std_logic;
            rst: in std_logic;
            req: in std_logic;
            ack: out std_logic;
            data_in: in std_logic_vector(3 downto 0);
            data_out: out std_logic_vector(3 downto 0)
    );
end B;

architecture Structural of B is
    
    component uo_b is
        Port (  
                clk : in std_logic;
                rst : in std_logic;
                data_in : std_logic_vector(3 downto 0);
                write_reg_in : in std_logic;
                write_reg_out : in std_logic;
                data_out : out std_logic_vector
         );
    end component;
    
    component uc_b is
        Port ( 
                clk: in std_logic;
                rst: in std_logic;
                req: in std_logic;
                ack: out std_logic;
                write_reg_in : out std_logic;
                write_reg_out : out std_logic
        );
    end component;
    
    signal write_reg_in : std_logic;
    signal write_reg_out : std_logic;
    
begin
    
    uo:uo_b 
        Port Map(  
                clk         =>clk,
                rst         =>rst,
                data_in     =>data_in,
                write_reg_in=>write_reg_in,
                write_reg_out=>write_reg_out,
                data_out    =>data_out
         );
    
    uc:uc_b 
        Port Map( 
                clk          =>clk,
                rst          =>rst,
                req          =>req,
                ack          =>ack,
                write_reg_in =>write_reg_in,
                write_reg_out=>write_reg_out
                
        );

end Structural;
