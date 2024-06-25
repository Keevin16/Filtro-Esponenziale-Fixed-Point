----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity TopLevelY is
	generic(
		WIDTH:Integer :=32
	);
	port(
		Y_RESULT : in  std_logic_vector (WIDTH-1 downto 0);
      Y_OUT1   : out std_logic_vector (WIDTH-1 downto 0);
		Y_OUT2	: out std_logic_vector (WIDTH-1 downto 0);
		K			: in std_logic_vector (2 downto 0);
		CLOCK		: in std_logic;
		RESET		: in std_logic
   );
end TopLevelY;

architecture RCL of TopLevelY is

	signal COMMUNICATION_MEM	: std_logic_vector(WIDTH-1 downto 0);
	signal COMMUNICATION_C2 	: std_logic_vector(WIDTH-1 downto 0);

	component MEMORY is
		port (
			CLOCK, RESET : in std_logic;
			Y : in std_logic_vector(WIDTH-1 downto 0);
			Q : out std_logic_vector(WIDTH-1 downto 0)
		);
	end component;
	
	component C2 is 
		port(
			Y: in	 std_logic_vector	(WIDTH - 1 downto 0);
			Z: out std_logic_vector (WIDTH - 1 downto 0)
		);
	end component;

	component MULTIPLEXER_SX is
		port (
			X  : in 	std_logic_vector 	(WIDTH-1 downto 0);
			K  : in 	std_logic_vector 	(2 downto 0);
			Y  : out std_logic_vector	(WIDTH-1 downto 0)
		);
	end component;
	
begin
	MemoryIstance: MEMORY
		port map(
			CLOCK 	=> CLOCK,
			RESET 	=>	RESET,
			Y			=> Y_RESULT,
			Q			=>	COMMUNICATION_MEM
		);
		
	Y_OUT1			<=	COMMUNICATION_MEM;
	
	C2Istance: C2
		port map(
			Y 			=>	COMMUNICATION_MEM,
			Z			=>	COMMUNICATION_C2 
		);
	
	MuxIstance: MULTIPLEXER_SX
		port map(
			X			=>	COMMUNICATION_C2,
			K			=>	K,
			Y			=>	Y_OUT2
		);
	
end RCL;