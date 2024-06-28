----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2 is
	    Port ( 
        X     : in std_logic_vector 	(31 downto 0);
		  Y	  : out std_logic_vector 	(31 downto 0);
		  RESET : in std_logic
		  );
end MUX_2;

architecture RCL of MUX_2 is

begin
	process(X, RESET)	begin
		case RESET is
			when '0'	=>			Y <= X;
			when '1' => 		Y <= (others => '0');
			when others =>		Y <= (others => '0');
		end case;
	end process;
end RCL;

