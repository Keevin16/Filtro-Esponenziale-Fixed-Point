----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity FA is
    Port (
        X      : in  std_logic;  
        Y      : in  std_logic;  
        CIN    : in  std_logic;  
        SUM    : out std_logic;  
        COUT   : out std_logic   
    );
end entity FA;

architecture behavior of FA is begin

        SUM  <= X xor Y xor CIN;    
        COUT <= (X and Y) or (Y and CIN) or (X and CIN);
		  
end architecture behavior;