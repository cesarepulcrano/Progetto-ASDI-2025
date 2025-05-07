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
    Port (  CLK100MHZ   : in std_logic;
            BTNL        : in std_logic;
            BTNR        : in std_logic;
            LED         : out std_logic_vector(3 downto 0)
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
    
--    component reader is
--        Port (  CLK:    in  std_logic;
--                RST:    in  std_logic;
--                READ:   in  std_logic;
--                data_in:in  std_logic_vector(3 downto 0);
--                ENABLE: out  std_logic;
--                output: out std_logic_vector(3 downto 0)
--              );
--    end component;

    
    component divisore_di_frequenza is
        generic(
            CLKIN_freq  : integer := 100000000;  -- clock board 100MHz
            CLKOUT_freq : integer := 1           -- frequenza desiderata 1Hz
        );
        Port (
            clock_in  : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            clock_out : out STD_LOGIC
        );
    end component;
    
    component ButtonDebouncer is
        generic (                       
            CLK_period: integer := 10;  
            btn_noise_time: integer := 10000000 
                                                
        );
        Port ( RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               BTN : in STD_LOGIC;
               CLEARED_BTN : out STD_LOGIC);
    end component;
    
    signal left_button   :   std_logic;
    signal right_button  :   std_logic;
    signal wave: std_logic;
--    signal center_button :  std_logic;
--    signal reader_to_writer: std_logic;
--    signal data_to_reg: std_logic_vector(3 downto 0);
    
begin
    
    
    div: divisore_di_frequenza 
        Port Map(
            clock_in=>CLK100MHZ,
            reset=>'0',
            clock_out=>wave
        );
    
    
    button1: ButtonDebouncer 
        Port Map(   RST=>'0',
                    CLK=>wave,
                    BTN=>BTNL,
                    CLEARED_BTN=>left_button
                 );
                 
    button2: ButtonDebouncer 
        Port Map(   RST=>'0',
                    CLK=>wave,
                    BTN=>BTNR,
                    CLEARED_BTN=>right_button
                 );
--    button3: ButtonDebouncer 
--        Port Map(   RST=>'0',
--                    CLK=>CLK100MHZ,
--                    BTN=>BTNC,
--                    CLEARED_BTN=>center_button
--                 );
    
    
    
    system: PO_PC_system 
        Port Map(   CLK=> wave ,
                    RST=>left_button,--left_button,
                    START=>right_button,
                    data_out=>LED
        );
    
--    reader1: reader
--        Port Map(   CLK=>CLK100MHZ,
--                    RST=>left_button,
--                    READ=>right_button,
--                    data_in=>data_to_reg,
--                    ENABLE=>reader_to_writer,
--                    output=>LED
                    
--        );

--    L<=reader_to_writer;
end Structural;
