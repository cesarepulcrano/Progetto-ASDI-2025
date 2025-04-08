----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/01/2025 01:47:56 PM
-- Design Name: 
-- Module Name: riconoscitore_101_fpga - Behavioral
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

entity riconoscitore_101_fpga is
    Port (  SW_in   :   in  std_logic ;
            SW_mode :   in std_logic;
            BTN_in  :   in std_logic;
            BTN_mode    :   in std_logic;
            CLK    :   in  std_logic; -- segnale di tempificazione (clock)
            RST   :   in  std_logic;
            LED_out  :   out std_logic
    );
end riconoscitore_101_fpga;

architecture Structural of riconoscitore_101_fpga is
    signal input_signal : std_logic ;
    signal mode_signal : std_logic ;

    component riconoscitore_101
        Port(   input   :   in  std_logic;
                a       :   in  std_logic; -- segnale di tempificazione (clock)
                reset   :   in  std_logic;
                m       :   in  std_logic; -- 0 modalità non sovrapposta, 1 modalità parzialmente sovrapposta
                output  :   out std_logic
                
        );
    end component;
    
    component switch_capture is
        Port (  clock   :   in std_logic;
                button  :   in  std_logic;
                input : in std_logic;
                output  :   out std_logic
        );
    end component;   
    
    component ButtonDebouncer is
        generic (                       
            CLK_period: integer := 10;  -- periodo del clock (della board) in nanosecondi
            btn_noise_time: integer := 10000000 -- durata stimata dell'oscillazione del bottone in nanosecondi
                                                -- il valore di default � 10 millisecondi
        );
        Port ( RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               BTN : in STD_LOGIC;
               CLEARED_BTN : out STD_LOGIC);
    end component;
    
begin

    button_input : ButtonDebouncer
        Port map(RST => RST,
                CLK => CLK,
                BTN => BTN_in,
                CLEARED_BTN => input_signal
        );
        
    button_mode : ButtonDebouncer
        Port map(RST => RST,
                CLK => CLK,
                BTN => BTN_mode,
                CLEARED_BTN => mode_signal
        );
    
    --button_input:   switch_capture
      --  Port map(   clock=>CLK,
        --            button=>BTN_in, -- BTNL
          --          input=>SW_in, -- primo switch
            --        output=>input_signal
     --   );
        
    --button_mode:   switch_capture
    --    Port map(   clock=>CLK,
     --               button=>BTN_mode, -- BTNR
     --               input=>SW_mode, -- secondo switch
     --               output=>mode_signal   
      --  );
        
    riconoscitore: riconoscitore_101
        port map(
                input=> input_signal, 
                a=>CLK,
                reset=>RST,
                m=>mode_signal,
                output=>LED_out  
                
        );

end Structural;
