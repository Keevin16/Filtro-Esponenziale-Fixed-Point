----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HA is
	port(
        X      : in  std_logic;  
        Y      : in  std_logic;    
        SUM    : out std_logic;  
        COUT   : out std_logic   
    );
end HA;

architecture behavior of HA is begin
	
	SUM	<= X xor Y;
	COUT 	<= X and Y;
	
end behavior;