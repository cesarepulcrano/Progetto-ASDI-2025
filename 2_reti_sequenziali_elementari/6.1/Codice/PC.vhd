----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2025 18:18:05
-- Design Name: 
-- Module Name: PO - Behavioral
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
use IEEE.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Generic (N : integer := 8);
    Port (  CLK : in std_logic;
            RST : in std_logic;
            START : in std_logic;
            COUNT : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto  0);
            READ_ROM : out std_logic;
            WRITE_MEM : out std_logic;
            EN_COUNT : out std_logic;
            RST_COUNT : out std_logic
    );
end PC;

architecture Behavioral of PC is

    type state is (IDLE, READROM, WRITEMEM, CNT);
    signal stato_corrente : state := IDLE;
    signal stato_prossimo : state;
    
begin

    comb: process(stato_corrente, START, COUNT)
    begin
        case stato_corrente is
            when IDLE =>
                RST_COUNT <= '1';
                if(START = '1') then
                    stato_prossimo <= READROM;
                elsif(START ='0') then
                    stato_prossimo <= IDLE;
                end if;
            when READROM =>
                RST_COUNT <= '0';
                READ_ROM <= '1';
                stato_prossimo <= WRITEMEM;
            when WRITEMEM =>
                READ_ROM <= '0';
                WRITE_MEM <= '1';
                stato_prossimo <= CNT;
            when CNT =>
                WRITE_MEM <= '0';
                EN_COUNT <= '1';
                if(COUNT = std_logic_vector(to_unsigned(N-1,integer(ceil(log2(real(N))))))) then
                    stato_prossimo <= IDLE;
                else
                    stato_prossimo <= READROM;
                end if;
        end case;
    end process;
    
    mem: process(CLK)
    begin
        if(CLK'event AND CLK = '1') then
            if(RST = '1') then
                stato_corrente <= IDLE;
            else
                stato_corrente <= stato_prossimo;
            end if;
        end if;
    end process;

end Behavioral;
