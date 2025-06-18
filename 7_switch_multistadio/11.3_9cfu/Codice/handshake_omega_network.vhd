----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2025 04:23:46 PM
-- Design Name: 
-- Module Name: handshake_omega_network - Structural
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

entity handshake_omega_network is
    Port (
            clk                 : in std_logic;
            rst                 : in std_logic;
            invia_a             : in std_logic;
            invia_b             : in std_logic;
            dato_ricevuto_a     : out std_logic_vector(1 downto 0);
            dato_ricevuto_b     : out std_logic_vector(1 downto 0)
     );
end handshake_omega_network;

architecture Structural of handshake_omega_network is
    
    component A is
        Port ( 
                clk                 : in std_logic;
                rst                 : in std_logic; 
                invia               : in std_logic;  
                controllo_input     : in std_logic_vector(1 downto 0);
                dato_in             : in std_logic_vector(1 downto 0);
                controllo_output    : out std_logic_vector(1 downto 0);
                dato_out            : out std_logic_vector(1 downto 0);
                selezione_output    : out std_logic_vector(1 downto 0) ;
                dato_ricevuto       : out std_logic_vector(1 downto 0)                
        );
    end component;
    
    component B is
        Port ( 
                clk                 : in std_logic;
                rst                 : in std_logic;   
                invia               : in std_logic;
                controllo_input     : in std_logic_vector(1 downto 0);
                dato_in             : in std_logic_vector(1 downto 0);
                controllo_output    : out std_logic_vector(1 downto 0);
                dato_out            : out std_logic_vector(1 downto 0);
                selezione_output    : out std_logic_vector(1 downto 0) ;
                dato_ricevuto       : out std_logic_vector(1 downto 0)                 
        );
    end component;
    
    component omega_network_prio_fissa is
        Generic(N: natural:=4);
        Port ( 
                    message0 : in  std_logic_vector(3 downto 0);
                    message1 : in  std_logic_vector(3 downto 0);
                    message2 : in  std_logic_vector(3 downto 0);
                    message3 : in  std_logic_vector(3 downto 0);
                    r0 : in STD_LOGIC;
                    r1 : in STD_LOGIC;
                    r2 : in STD_LOGIC;
                    r3 : in STD_LOGIC;
                    y0 : out STD_LOGIC_VECTOR (1 downto 0);
                    y1 : out STD_LOGIC_VECTOR (1 downto 0);
                    y2 : out STD_LOGIC_VECTOR (1 downto 0);
                    y3 : out STD_LOGIC_VECTOR (1 downto 0) 
        
        );
    end component;
    
    signal a_data_in:std_logic_vector(1 downto 0);
    signal a_data_out:std_logic_vector(1 downto 0);
    signal a_control_in:std_logic_vector(1 downto 0);
    signal a_control_out:std_logic_vector(1 downto 0);
    signal a_sel: std_logic_vector(1 downto 0);
    
    signal b_data_in:std_logic_vector(1 downto 0);
    signal b_data_out:std_logic_vector(1 downto 0);
    signal b_control_in:std_logic_vector(1 downto 0);
    signal b_control_out:std_logic_vector(1 downto 0);
    signal b_sel: std_logic_vector(1 downto 0);
begin
    
    a_node:A 
        Port Map( 
                clk                 =>clk,
                rst                 =>rst,
                invia               =>invia_a,
                controllo_input     =>a_control_in,
                dato_in             =>a_data_in,
                controllo_output    =>a_control_out,
                dato_out            =>a_data_out,
                selezione_output    =>a_sel   ,
                dato_ricevuto       =>dato_ricevuto_a       
        );                           
                                    
                                    
    b_node:B                        
        Port Map(                   
                clk                 =>clk,
                rst                 =>rst,
                invia               =>invia_b,
                controllo_input     =>b_control_in, 
                dato_in             =>b_data_in,    
                controllo_output    =>b_control_out,
                dato_out            =>b_data_out,   
                selezione_output    =>b_sel ,
                dato_ricevuto       =>dato_ricevuto_b      
                       
        ) ;                          
                                    
                                    
    net:omega_network_prio_fissa    
        Port Map(                   
                    message0        =>"00" & a_control_out,
                    message1        =>"01" & a_data_out,
                    message2        =>"10" & b_control_out,
                    message3        =>"11" & b_data_out,   
                    r0              =>a_sel(0),
                    r1              =>a_sel(1),
                    r2              =>b_sel(0),
                    r3              =>b_sel(1),
                    y0              =>b_control_in,
                    y1              =>b_data_in,
                    y2              =>a_control_in,
                    y3              =>a_data_in
        
        );
--net:omega_network_prio_fissa    
--        Port Map(                   
--                    message0        =>"10" & a_control_out,
--                    message1        =>"11" & a_data_out,
--                    message2        =>"00" & b_control_out,
--                    message3        =>"01" & b_data_out,   
--                    r0              =>a_sel(0),
--                    r1              =>a_sel(1),
--                    r2              =>b_sel(0),
--                    r3              =>b_sel(1),
--                    y0              =>a_control_in,
--                    y1              =>a_data_in,
--                    y2              =>b_control_in,
--                    y3              =>b_data_in
        
--        );
end Structural;
