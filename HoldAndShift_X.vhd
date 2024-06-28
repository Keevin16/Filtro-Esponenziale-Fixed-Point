----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity HoldAndShift_X is
	generic(
		WIDTH:Integer :=32
	);
	port(
		X				: in  std_logic_vector (WIDTH-1 downto 0);
		K				: in 	std_logic_vector (2 downto 0);
		K_SH			: out std_logic_vector (2 downto 0);
		X_SHIFTED	: out std_logic_vector (WIDTH-1 downto 0);
		CLOCK 		: in std_logic;
		RESET			: in std_logic
   );
end HoldAndShift_X;

architecture RCL of HoldAndShift_X is

	signal COMMUNICATION_X: std_logic_vector(WIDTH-1 downto 0);
	signal COMMUNICATION_K: std_logic_vector(2 downto 0);
	
	component MEMORY is
		generic (
			WIDTH: Integer := 32
		);
		port (
			CLOCK : in std_logic; 
			RESET : in std_logic;
			Y 		: in std_logic_vector(WIDTH-1 downto 0);
			Q 		: out std_logic_vector(WIDTH-1 downto 0)
		);
	end component;
	
	component MULTIPLEXER_SX is
		port (
			X  	: in 	std_logic_vector 	(WIDTH-1 downto 0);
			K  	: in 	std_logic_vector 	(2 downto 0);
			Y  	: out std_logic_vector	(WIDTH-1 downto 0)
		);
	end component;
	
	begin
		SH_X: MEMORY
			generic map (
				WIDTH => WIDTH
			)
			port map(
				Y		=> X,
				Q		=> COMMUNICATION_X,
				CLOCK => CLOCK,
				RESET => RESET
			);		
		
		SH_K: MEMORY
			generic map (
				WIDTH => 3
			)
			port map(
				Y		=> K,
				Q		=> COMMUNICATION_K,
				CLOCK => CLOCK,
				RESET => RESET
			);				
		
		MUX_Istance: MULTIPLEXER_SX
			port map(
				X		=>	COMMUNICATION_X,
				K		=>	COMMUNICATION_K,
				Y		=>	X_SHIFTED
			);
		K_SH <= COMMUNICATION_K;
end RCL;