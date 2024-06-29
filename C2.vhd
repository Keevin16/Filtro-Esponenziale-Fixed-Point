----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity C2 is
	generic(
		WIDTH:Integer :=32
	);
	port(
		Y		: in std_logic_vector	(WIDTH - 1 downto 0);
		Z		: out std_logic_vector (WIDTH - 1 downto 0)
	);
end C2;

architecture RCL of C2 is

	component PA is 
		port(
			X    : in  std_logic_vector (WIDTH - 1 downto 0);
			S    : out std_logic_vector (WIDTH - 1 downto 0)
		);
	end component;

begin
	 C2Instance: PA
		port map(
			X	=>	not Y,
			S	=> Z
		);
end RCL;