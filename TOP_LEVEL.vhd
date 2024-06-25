----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity TOP_LEVEL is 
	generic(
		WIDTH:Integer :=32
	);
	port(
		X			: in  std_logic_vector (WIDTH-1 downto 0);
		K			: in 	std_logic_vector (2 downto 0);
		Y			: out std_logic_vector (WIDTH-1 downto 0);
		CLOCK		: in 	std_logic;
		RESET		: in 	std_logic
   );
end TOP_LEVEL;

architecture RCL of TOP_LEVEL is

	signal COMMUNICATION_OUT1	: std_logic_vector(WIDTH-1 downto 0);
	signal COMMUNICATION_OUT2	: std_logic_vector(WIDTH-1 downto 0);
	signal COMMUNICATION_X		: std_logic_vector(WIDTH-1 downto 0);
	signal COMMUNICATION_Y		: std_logic_vector(WIDTH-1 downto 0);
	signal CSA_RESULT				: std_logic_vector(WIDTH-1 downto 0);

	component MULTIPLEXER_SX is
		port (
			X  : in 	std_logic_vector 	(WIDTH-1 downto 0);
			K  : in 	std_logic_vector 	(2 downto 0);
			Y  : out std_logic_vector	(WIDTH-1 downto 0)
		);
	end component;
	
	component TopLevelY is
		port(
			Y_RESULT : in  std_logic_vector (WIDTH-1 downto 0);
			Y_OUT1   : out std_logic_vector (WIDTH-1 downto 0);
			Y_OUT2	: out std_logic_vector (WIDTH-1 downto 0);
			K			: in std_logic_vector (2 downto 0);
			CLOCK		: in std_logic;
			RESET		: in std_logic
		);
	end component;
	
	component CSA is
		port(
			A : in std_logic_vector 	(31 downto 0);
			B : in std_logic_vector 	(31 downto 0);
			C : in std_logic_vector		(31 downto 0);
			Z : out std_logic_vector 	(31 downto 0)
		);
	end component;
	
begin
	COMMUNICATION_Y	<=	(others => '0');

	MuxIstance: MULTIPLEXER_SX
		port map(
			X		=>	X,
			K		=> K,
			Y		=> COMMUNICATION_X
		);
		
	ToplevelIstance: ToplevelY
		port map(
			Y_RESULT	=>	CSA_RESULT,
			Y_OUT1   => COMMUNICATION_OUT1,
			Y_OUT2	=> COMMUNICATION_OUT2,
			K			=> K,
			CLOCK		=> CLOCK,
			RESET		=>	RESET
		);
	CSAIstance: CSA
		port map(
			A 			=> COMMUNICATION_X,
			B  		=> COMMUNICATION_OUT1,
			C  		=> COMMUNICATION_OUT2,
			Z  		=> CSA_RESULT
		);
		Y	<= CSA_RESULT;
end RCL;