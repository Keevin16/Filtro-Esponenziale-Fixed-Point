----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity C2AndShift is
	generic(
		WIDTH:Integer :=32
	);
	port(
		Y_CSA			: in  std_logic_vector (WIDTH-1 downto 0);
		K				: in 	std_logic_vector (2 downto 0);
		Z_CSA			: out std_logic_vector (WIDTH-1 downto 0)
   );
end C2AndShift;

architecture RCL of C2AndShift is
	signal COMMUNICATION : std_logic_vector(WIDTH-1 downto 0);
	
	component C2 is 
		port(
			Y		: in	 std_logic_vector	(WIDTH-1 downto 0);
			Z		: out std_logic_vector (WIDTH-1 downto 0)
		);
	end component;

	component MULTIPLEXER_SX is
		port (
			X  : in 	std_logic_vector 	(WIDTH-1 downto 0);
			K  : in 	std_logic_vector 	(2 downto 0);
			Y  : out std_logic_vector	(WIDTH-1 downto 0)
		);
	end component;
-- -30 È 00010 --shiftato di uno fa -15 che è 0001
begin
	C2Istance: C2
		port map(
			Y 					=>	Y_CSA,
			Z					=>	COMMUNICATION
		);
	
	MuxIstance: MULTIPLEXER_SX
		port map(
			X			=>	COMMUNICATION,
			K			=>	K,
			Y			=>	Z_CSA
		);	
	
end RCL;
