----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2025 04:29:16 PM
-- Design Name: 
-- Module Name: uc - Behavioral
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

entity uc is
    Port (  
            message0 : in  std_logic_vector(5 downto 0);
            message1 : in  std_logic_vector(5 downto 0);
            message2 : in  std_logic_vector(5 downto 0);
            message3 : in  std_logic_vector(5 downto 0);
            r0       : in  std_logic;
            r1       : in  std_logic;
            r2       : in  std_logic;
            r3       : in  std_logic;
            source   : out std_logic_vector(1 downto 0);
            dest     : out std_logic_vector(1 downto 0);
            payload0 : out std_logic_vector(1 downto 0);
            payload1 : out std_logic_vector(1 downto 0);
            payload2 : out std_logic_vector(1 downto 0);
            payload3 : out std_logic_vector(1 downto 0)
     );
end uc;

    
architecture Behavioral of uc is
    signal source_temp: std_logic_vector(1 downto 0);
    signal dest_temp: std_logic_vector(1 downto 0);
    signal payload_temp: std_logic_vector(1 downto 0);

begin
    
    process(message0,message1,message2,message3,r0,r1,r2,r3) 
    begin
        if(r0='1') then
            source_temp<=message0(5 downto 4);
            dest_temp<=message0(3 downto 2);
        elsif(r1='1') then
            source_temp<=message1(5 downto 4);
            dest_temp<=message1(3 downto 2);
        elsif(r2='1') then
            source_temp<=message2(5 downto 4);
            dest_temp<=message2(3 downto 2);        
        elsif(r3='1') then
            source_temp<=message3(5 downto 4);
            dest_temp<=message3(3 downto 2);
        end if   ;
    end process;
    source<=source_temp;
    dest<=dest_temp;
    payload0<=message0(1 downto 0);
    payload1<=message1(1 downto 0);
    payload2<=message2(1 downto 0);
    payload3<=message3(1 downto 0);
end Behavioral;
