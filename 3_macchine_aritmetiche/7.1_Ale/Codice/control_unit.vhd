library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2025 07:31:13 PM
-- Design Name: 
-- Module Name: operational_unit - Structural
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

entity control_unit is
    generic (N : natural := 8);
    port (
        CLK      : in  std_logic;
        RST      : in  std_logic;
        ENABLE   : in  std_logic;
        Q0       : in  std_logic;
        Q1       : in  std_logic;
        count    : in  std_logic_vector(integer(ceil(log2(real(N)))) - 1 downto 0);

        SHIFT     : out std_logic;
        LOAD_A    : out std_logic;
        LOAD_Q    : out std_logic;
        LOAD_M    : out std_logic;
        SUBTRACT  : out std_logic;
        init      : out std_logic;
        en_count  : out std_logic
    );
end control_unit;

architecture Behavioral of control_unit is
    type state is (IDLE, INIT_STATE, SCAN, SUM, SUB, LOAD_A_REG, SHIFT_STATE, COUNT_STATE, TEST);
    signal stato_corrente, stato_prossimo : state := IDLE;

begin

    comb: process(stato_corrente, ENABLE, Q0, Q1, count)
    begin
        -- Default assignments
        SHIFT     <= '0';
        LOAD_A    <= '0';
        LOAD_Q    <= '0';
        LOAD_M    <= '0';
        SUBTRACT  <= '0';
        init      <= '0';
        en_count  <= '0';

        case stato_corrente is
            when IDLE =>
                if ENABLE = '1' then
                    stato_prossimo <= INIT_STATE;
                else
                    stato_prossimo <= IDLE;
                end if;

            when INIT_STATE =>
                init    <= '1';
                LOAD_A  <= '1';
                LOAD_Q  <= '1';
                LOAD_M  <= '1';
                stato_prossimo <= SCAN;

            when SCAN =>
                if Q1 = '0' and Q0 = '1' then
                    stato_prossimo <= SUM;
                elsif Q1 = '1' and Q0 = '0' then
                    stato_prossimo <= SUB;
                else
                    stato_prossimo <= SHIFT_STATE;
                end if;

            when SUM =>
                SUBTRACT <= '0';  -- No subtraction = sum (by default)
                stato_prossimo <= LOAD_A_REG;

            when SUB =>
                SUBTRACT <= '1';
                stato_prossimo <= LOAD_A_REG;

            when LOAD_A_REG =>
                LOAD_A <= '1';
                stato_prossimo <= SHIFT_STATE;

            when SHIFT_STATE =>
                SHIFT <= '1';
                stato_prossimo <= COUNT_STATE;

            when COUNT_STATE =>
                en_count <= '1';
                stato_prossimo <= TEST;

            when TEST =>
                if count = std_logic_vector(to_unsigned(N-1, count'length)) then
                    stato_prossimo <= IDLE;
                else
                    stato_prossimo <= SCAN;
                end if;

            when others =>
                stato_prossimo <= IDLE;
        end case;
    end process;
    
    mem: process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                stato_corrente <= IDLE;
            else
                stato_corrente <= stato_prossimo;
            end if;
        end if;
    end process;

end Behavioral;