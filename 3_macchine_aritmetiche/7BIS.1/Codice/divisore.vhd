----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 02:15:41 AM
-- Design Name: 
-- Module Name: divisore - Structural
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

entity divisore is
    Generic     (   N           :   natural :=4); 
    Port        (   clk         :   in      std_logic;
                    rst         :   in      std_logic;
                    start       :   in      std_logic;
                    D           :   in      std_logic_vector(   N-1 downto  0   );
                    V           :   in      std_logic_vector(   N-1 downto  0   );
                    risultato   :   out      std_logic_vector(   N-1 downto  0   )
                 );
end divisore;

architecture Structural of divisore is
    
    component UC is
        Generic (   N           :   natural :=4); 
        Port    (   clk         :   in      std_logic;
                    rst         :   in      std_logic;
                    start       :   in      std_logic;
                    init        :   out     std_logic;
                    en_count    :   out     std_logic;                           
                    load_m      :   out     std_logic;                           
                    load_q      :   out     std_logic;                           
                    load_a      :   out     std_logic;                           
                    subtract    :   out     std_logic;                           
                    shift       :   out     std_logic;                           
                    count       :   in      std_logic_vector(integer(ceil(log2(real(N-1))))-1 downto 0);
                    s           :   in      std_logic
    
                    );
    end component;
    
    component UO is
        Generic (   N           :   natural :=4); 
        Port    (   clk         :   in      std_logic;
                    rst         :   in      std_logic;
                    D           :   in      std_logic_vector(   N-1 downto  0   );
                    V           :   in      std_logic_vector(   N-1 downto  0   );
                    init        :   in      std_logic;
                    en_count    :   in      std_logic                            ;
                    load_m      :   in      std_logic                            ;
                    load_q      :   in      std_logic                            ;
                    load_a      :   in      std_logic                            ;
                    subtract    :   in      std_logic                            ;
                    shift       :   in      std_logic                            ;
                    count       :   out     std_logic_vector(integer(ceil(log2(real(N-1))))-1 downto 0);
                    s           :   out     std_logic;
                    risultato   :   out     std_logic_vector(   N-1 downto  0   ) 
                    );
    end component;
    
    signal init: std_logic;        
    signal en_count :std_logic;   
    signal load_m  : std_logic;    
    signal load_q  : std_logic;    
    signal load_a   : std_logic;   
    signal subtract : std_logic;   
    signal shift    : std_logic;   
    signal count     :  std_logic_vector(integer(ceil(log2(real(N-1))))-1 downto 0);
    signal s: std_logic;
    
    
begin
    
    c: UC 
        Generic Map(   N=>N)           
        Port    Map(   clk=>clk,         
                        rst=>rst,
                        start=>start,         
                        init=>init,      
                        en_count=>en_count,  
                        load_m=>load_m,   
                        load_q=>load_q,   
                        load_a=>load_a,   
                        subtract=>subtract,  
                        shift=>shift,  
                        count=>count,   
                        s=>s
    
       );

    o: UO 
        Generic Map(   N=>N)         
        Port    Map(   clk=>clk,         
                    rst=>rst,        
                    D  =>D,         
                    V  =>V,         
                    init=>init,      
                    en_count=>en_count,  
                    load_m=>load_m,   
                    load_q=>load_q,   
                    load_a=>load_a,   
                    subtract=>subtract,  
                    shift=>shift,  
                    count=>count,   
                    s=>s,    
                    risultato =>risultato  
         );


end Structural;
