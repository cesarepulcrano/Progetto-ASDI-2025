----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/15/2025 02:10:27 PM
-- Design Name: 
-- Module Name: uart_fpga - Structural
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

entity uart_fpga is
    Port ( 
            CLK100MHZ   :   in  std_logic;
            BTNL        :   in  std_logic;
            BTNR        :   in  std_logic;
            CA          :   out std_logic_vector(7 downto 0);
            AN          :   out std_logic_vector(7 downto 0)
            );
end uart_fpga;


architecture Structural of uart_fpga is
    component a_b_system is
        Generic (   N   :   natural :=8;
                    M   :   natural := 8);
        Port (
                clk: in std_logic; 
                rst: in std_logic;
                wr: in std_logic;
                rd: in std_logic;
                overrun:     out std_logic;
                a_output:   out std_logic;
                output: out std_logic_vector (M-1 downto 0)
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
    
    component display_seven_segments is
        Generic( 
                    clock_frequency_in : integer := 50000000; 
                    clock_frequency_out : integer := 5000000
                    );
        Port ( clock : in  STD_LOGIC;
               reset : in  STD_LOGIC;
               value16_in : in  STD_LOGIC_VECTOR (15 downto 0);
               enable : in  STD_LOGIC_VECTOR (7 downto 0);
               dots : in  STD_LOGIC_VECTOR (7 downto 0);
               anodes : out  STD_LOGIC_VECTOR (7 downto 0);
               cathodes : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal rst_signal: std_logic;
    signal wr_signal : std_logic;
    signal rd_signal : std_logic;
    signal mem_content: std_logic_vector(7 downto 0);
    signal oe_signal: std_logic;
    signal a_signal: std_logic;
begin

    wr_button:ButtonDebouncer 
        generic Map(                       
            CLK_period      =>10,
            btn_noise_time  => 10000000
                                    
        )                           
        Port Map( 
                    RST          =>rst_signal,
                    CLK          =>CLK100MHZ,
                    BTN          =>BTNL,
                    CLEARED_BTN  =>wr_signal
        );
    
    rd_button:ButtonDebouncer 
        generic Map(                       
            CLK_period      =>10,
            btn_noise_time  => 10000000
                                    
        )                           
        Port Map( 
                    RST          =>rst_signal,
                    CLK          =>CLK100MHZ,
                    BTN          =>BTNR,
                    CLEARED_BTN  =>rd_signal
        );
     
     a_b: a_b_system 
--        Generic (   N   :   natural :=8;
--                    M   :   natural := 8);
        Port Map(
                clk     =>CLK100MHZ,
                rst     =>rst_signal,
                wr      =>wr_signal,
                rd      =>rd_signal,
                overrun =>oe_signal,
                a_output=>a_signal,
                output  =>mem_content
                 ); 
      
      display:display_seven_segments 
        Generic Map( 
                    clock_frequency_in=>100000000, 
                    clock_frequency_out=>5000
                    )
        Port Map( 
               clock        =>CLK100MHZ,
               reset        =>rst_signal,
               value16_in   =>oe_signal&"000000"&a_signal&mem_content,
               enable       =>"11111111",
               dots         =>"10001000",
               anodes       =>AN,
               cathodes     =>CA   
               ); 
                        
end Structural;
