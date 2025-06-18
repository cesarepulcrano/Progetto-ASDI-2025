----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/09/2025 12:01:48 PM
-- Design Name: 
-- Module Name: divisore_fpga - Structural
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

entity divisore_fpga is
    Port (  CLK100MHZ   :   in std_logic;
            BTNL        :   in std_logic;
            BTNR        :   in std_logic;
            AN          :   out std_logic_vector(7 downto 0);
            CA          :   out std_logic_vector(7 downto 0);
            SW          :   in std_logic_vector(7 downto 0);
            LED         :   out std_logic_vector(15 downto 0)
            
            --risultato   :   std_logic_vector(3 downto 0);
            --resto       :   std_logic_vector(3 downto 0)
             );
end divisore_fpga;

architecture Structural of divisore_fpga is
    
    component divisore is
    Generic     (   N           :   natural :=4); 
    Port        (   clk         :   in      std_logic;
                    rst         :   in      std_logic;
                    start       :   in      std_logic;
                    D           :   in      std_logic_vector(   N-1 downto  0   );
                    V           :   in      std_logic_vector(   N-1 downto  0   );
                    risultato   :   out      std_logic_vector(   N-1 downto  0   );
                    resto       :   out      std_logic_vector(   N-1 downto  0   )
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
				clock_frequency_in : integer := 100000000; 
				clock_frequency_out : integer := 5000
				);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           value8_in : in  STD_LOGIC_VECTOR (15 downto 0);
           enable : in  STD_LOGIC_VECTOR (7 downto 0);
           dots : in  STD_LOGIC_VECTOR (7 downto 0);
           anodes : out  STD_LOGIC_VECTOR (7 downto 0);
           cathodes : out  STD_LOGIC_VECTOR (7 downto 0));
end component;
    
    signal start_signal:    std_logic;
    signal rst_signal  :    std_logic;
    signal ris_signal  :    std_logic_vector(3 downto 0);
    signal res_signal  :    std_logic_vector(3 downto 0);
    
begin
    
    
    start:ButtonDebouncer 
        Port Map(   RST=>rst_signal,
                    CLK=>CLK100MHZ,
                    BTN=>BTNR,
                    CLEARED_BTN =>start_signal);
    res:ButtonDebouncer 
        Port Map(   RST=>'0', -- oppure rst_signal
                    CLK=>CLK100MHZ,
                    BTN=>BTNL,
                    CLEARED_BTN =>rst_signal);
    
    div:divisore 
        Port Map(   clk         =>CLK100MHZ,
                    rst         =>rst_signal,
                    start       =>start_signal,
                    D           =>SW(3 downto 0),
                    V           =>SW(7 downto 4),
                    risultato   =>ris_signal,
                    resto       =>res_signal
                     );
    
--    display:display_on_board 
--	Port Map(
--		          clock           =>CLK100MHZ,
--		          reset           =>rst_signal,
--		          load_first_part =>start_signal,
--		          load_dots_enable=>'1',
--		          value8_in      =>res_signal&ris_signal,
--		          anodes          =>AN,
--		          cathodes        =>CA
--		      );
--	display:display_seven_segments
--	Generic Map( 
--				clock_frequency_in=>100000000,
--				clock_frequency_out=>50000
--				)
--    Port Map( clock      =>CLK100MHZ,
--           reset      =>rst_signal,
--           value8_in  =>"00000000"&res_signal&ris_signal,
--           enable     =>"11111111",
--           dots       =>"00000100",
--           anodes     =>AN,
--           cathodes   =>CA	      
--		   );   
		LED(3 downto 0)<=ris_signal;      
		LED(7 downto 4)<=res_signal; 
		LED(15 downto 8)<=SW;     
end Structural;
