----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 02:05:00 AM
-- Design Name: 
-- Module Name: uc_switch - Behavioral
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

entity uc_switch is
      Generic(Stage:natural:=0);
      Port (    clk : std_logic;
                rst: std_logic;
                message0: in std_logic_vector(5 downto 0);
                message1: in std_logic_vector(5 downto 0);
                message_out0:out std_logic_vector(5 downto 0);
                message_out1:out std_logic_vector(5 downto 0);
                source_out: out std_logic;
                dest_out: out std_logic
             );
end uc_switch;

    
architecture Behavioral of uc_switch is
    signal data_store: std_logic_vector(5 downto 0):="UUUUUU";
    signal message0_sig :std_logic_vector(5 downto 0):="UUUUUU";
    signal message1_sig :std_logic_vector(5 downto 0):="UUUUUU";
    signal nu : std_logic_vector(2 downto 0):="100";
begin
   
    
    boh:process(clk,message0,message1)
    
    begin
        message0_sig<=message0;
    message1_sig<=message1; 
        if(rising_edge(clk)) then
            if(data_store/="UUUUUU") then
                nu<="000";
                message0_sig<=data_store(5 downto 0);
                source_out<='1';
                dest_out<=message1(Stage+3);
                data_store<="UUUUUU";
            elsif(message0/="UUUUUU") then
                nu<="001";
                message0_sig<=message0;
                source_out<='0';
                dest_out<=message0(Stage+3);
                --message0_sig<="UUUUUUU";
            --elsif(message1_sig/="UUUUUU") then
            elsif(message1_sig/="UUUUUU" ) then  
                nu<="010";
                message_out1<=message1;
                source_out<='1';
                dest_out<=message1(Stage+3);
                message1_sig<="UUUUUU";
            elsif(message0(5 downto 3)=message1(5 downto 3)) then
                    nu<="011";
                    data_store<=message1;
                    message_out0<=message0;
                    dest_out<=message0(Stage+3);
                    source_out<='0';
            end if;
         end if;           
    end process;
    message_out0<=message0_sig;
    message_out1<=message1_sig;
end Behavioral;
