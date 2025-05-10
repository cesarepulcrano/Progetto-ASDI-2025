----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2025 02:05:38 PM
-- Design Name: 
-- Module Name: cronometro_on_display - Structural
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

entity cronometro_on_display is
    Port (  CLK100MHZ: in std_logic; 
            RST: in std_logic;
            SET: in std_logic;
            SW: in  std_logic_vector(15 downto 0);
            anodes : out  STD_LOGIC_VECTOR (7 downto 0);
            cathodes : out  STD_LOGIC_VECTOR (7 downto 0) 
            );
end cronometro_on_display;

architecture Structural of cronometro_on_display is
    component cronometro_b is
        Port (  CLK: in std_logic;
                RST: in std_logic;
                set: in std_logic;
                
                load_second:in std_logic_vector(5 downto 0);
                load_minute: in std_logic_vector(5 downto 0);
                load_hour:  in std_logic_vector(4 downto 0);
                
                cont_second:    out std_logic_vector(5 downto 0);
                cont_minute:    out std_logic_vector(5 downto 0);
                cont_hour  :    out std_logic_vector(4 downto 0);
                
                c_out       :   out std_logic
        );
    end component;
    
    component display_on_board is
	Port(
		  clock : in  STD_LOGIC; 
		  reset : in  STD_LOGIC; 
		  load_first_part : in  STD_LOGIC; 
		  load_second_part : in  STD_LOGIC; 
		  load_dots_enable : in  STD_LOGIC; 
		  value16_in : in STD_LOGIC_VECTOR(15 downto 0);  
		  anodes : out  STD_LOGIC_VECTOR (7 downto 0); 
		  cathodes : out  STD_LOGIC_VECTOR (7 downto 0) 
			  );
    end component;
    
    component display_seven_segments is
        Generic( 
                    clock_frequency_in : integer := 100000000; 
                    clock_frequency_out : integer := 5000000
                    );
        Port ( clock : in  STD_LOGIC;
               reset : in  STD_LOGIC;
               value32_in : in  STD_LOGIC_VECTOR (16 downto 0);
               enable : in  STD_LOGIC_VECTOR (7 downto 0);
               dots : in  STD_LOGIC_VECTOR (7 downto 0);
               anodes : out  STD_LOGIC_VECTOR (7 downto 0);
               cathodes : out  STD_LOGIC_VECTOR (7 downto 0));
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
    
    signal button_1: std_logic;
    signal button_2: std_logic;
    signal chrono_to_display:   std_logic_vector(16 downto 0);
begin
    
    button1:ButtonDebouncer

        Port Map(   RST=>'0',
                    CLK=>CLK100MHZ,
                    BTN=>RST,
                    CLEARED_BTN=>button_1
               );
    button2:ButtonDebouncer

        Port Map(   RST=>'0',
                    CLK=>CLK100MHZ,
                    BTN=>SET,
                    CLEARED_BTN=>button_2
               );
    
     chrono: cronometro_b 
        Port Map(   CLK=>CLK100MHZ,
                    RST=>button_1,
                    set=>button_2,
                
--                    load_second=>SW(5 downto 0),
--                    load_minute=>SW(11 downto 6),
--                    load_hour=>"0"&SW(15 downto 12),
                      load_second=>"0"&SW(4 downto 0),
                      load_minute=>SW(10 downto 5),
                      load_hour=>SW(15 downto 11),
                    cont_second=>chrono_to_display(5 downto 0),
                    cont_minute=>chrono_to_display(11 downto 6),
                    cont_hour=>chrono_to_display(16 downto 12)

        );
    
               
    display: display_seven_segments 
        Generic Map( 
                    clock_frequency_in=>100000000, 
                    clock_frequency_out=>1000
                )
        Port Map(   clock=>CLK100MHZ,
                    reset=>button_1,
                    value32_in=>chrono_to_display,
                    enable=>"00111111",
                    dots=>"00000000",
                    anodes=>anodes,
                    cathodes=>cathodes
        );

end Structural;
