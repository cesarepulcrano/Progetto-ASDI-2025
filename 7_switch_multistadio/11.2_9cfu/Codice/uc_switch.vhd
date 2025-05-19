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
                message0: in std_logic_vector(6 downto 0);
                message1: in std_logic_vector(6 downto 0);
                message_out0:out std_logic_vector(6 downto 0);
                message_out1:out std_logic_vector(6 downto 0);
                source_out: out std_logic;
                dest_out: out std_logic
             );
end uc_switch;

    
architecture Behavioral of uc_switch is
    signal data_store: std_logic_vector(6 downto 0);

begin
   
    
    boh:process(clk,message0,message1)
    
    begin

        if(rising_edge(clk)) then
            if(data_store(6)='1') then
                message_out1<=data_store(6 downto 0);
                source_out<='1';
                dest_out<=data_store(5-Stage);
                
                data_store(6)<='0';
            elsif(message0(6)='1' and message1(6)='1') then
                    data_store<=message1;
                    
                    message_out0<=message0;
                    source_out<='0';
                    dest_out<=message0(5-Stage);        
             elsif(message0(6)='1') then
                    message_out0<=message0;
                    source_out<='0';
                    dest_out<=message0(5-Stage);
             elsif(message1(6)='1') then  
                    message_out1<=message1;
                    source_out<='1';
                    dest_out<=message1(5-Stage);
             else
                data_store<=(others=>'0');
                message_out0<=(others=>'0');
                message_out1<=(others=>'0');
             end if;
            end if;
           
    end process;

--    source_out<=source_temp;
--    dest_out<=dest_temp; 

end Behavioral;
