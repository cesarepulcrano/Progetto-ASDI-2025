----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 01:01:50 PM
-- Design Name: 
-- Module Name: UO_a - Structural
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UO_a is
    Generic (   N   :   natural :=8;
                M   :   natural := 8);
    Port (  clk:    in std_logic;
            rst:    in std_logic;
            en_count:    in std_logic;
            read_rom:    in std_logic;
            count:  out std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
            --uart
            TBE :   out std_logic;
            WR :   in std_logic;
            output: out std_logic
             );
end UO_a;

architecture Structural of UO_a is
    
    component contatore_mod_N is
        Generic (N: integer := 60);
        Port (      clock   :   in  std_logic;
                    reset   :   in  std_logic;
                    set     :   in  std_logic;
                    load    :   in  std_logic_vector(integer(ceil(log2(real(N))))-1 downto  0);
                    cont    :   out  std_logic_vector(integer(ceil(log2(real(N))))-1    downto  0);
                    co      :   out std_logic
        );
    end component;
    
    component ROM_A is
        Generic(N : natural := 8;
                M : natural := 8);
        Port (  CLK : in std_logic;
                EN  : in std_logic;
                address : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0); -- Codifica da 0 a N-1
                data_out : out std_logic_vector(M-1 downto 0)
        );
    end component;
    
    component Rs232RefComp is
        Port ( 
            TXD 	: out std_logic  	:= '1';
            RXD 	: in  std_logic;					
            CLK 	: in  std_logic;					--Master Clock
            DBIN 	: in  std_logic_vector (7 downto 0);--Data Bus in
            DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
            RDA	: inout std_logic;						--Read Data Available(1 quando il dato è disponibile nel registro rdReg)
            TBE	: inout std_logic 	:= '1';				--Transfer Bus Empty(1 quando il dato da inviare è stato caricato nello shift register)
            RD		: in  std_logic;					--Read Strobe(se 1 significa "leggi" --> fa abbassare RDA)
            WR		: in  std_logic;					--Write Strobe(se 1 significa "scrivi" --> fa abbassare TBE)
            PE		: out std_logic;					--Parity Error Flag
            FE		: out std_logic;					--Frame Error Flag
            OE		: out std_logic;					--Overwrite Error Flag
            RST		: in  std_logic	:= '0');			--Master Reset
    end component;
    
    signal address: std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
    signal rom_to_uart: std_logic_vector(M-1 downto 0);
    signal TBE_bus: std_logic;
    
    
    
begin
    
    contatore :contatore_mod_N
        Generic Map(N=>N)
        Port Map(   clock=>en_count,
                    reset=>rst,
                    set=>'0',
                    load=>(others=>'0'),
                    cont=>address
                    --co      :   out std_logic
        );
    count<=address;
    rom: ROM_A
        Generic Map(N=>N,
                    M=>M)
        Port Map(   CLK=>clk,
                    EN=>read_rom,
                    address=>address,
                    data_out=>rom_to_uart
        );
    -- TBE per dire quando il dato è stato messo nello sr uart
    uart:Rs232RefComp
        Port Map( 
            TXD =>output,	--
            RXD =>'0',
            CLK =>clk, --
            DBIN =>rom_to_uart, --
            --DBOUT =>,
            --RDA	=>,
            TBE	=>TBE_bus,--
            RD	=>'0',	
            WR	=>WR,	
--            PE	=>PE,	
--            FE	=>FE,	
--            OE	=>OE,	
            RST	=>rst
            );
     TBE<=TBE_bus;       
end Structural;
