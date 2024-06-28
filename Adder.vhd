----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity Adder is
		generic(
			WIDTH:Integer :=32
		);
		port(
			X				: in  std_logic_vector (WIDTH-1 downto 0);
			Y				: in 	std_logic_vector (WIDTH-1 downto 0);
			Y_SHIFTED	: in std_logic_vector  (WIDTH-1 downto 0);
			
			Y_CSA			: out std_logic_vector (WIDTH-1 downto 0);
			
			CLOCK 		: in std_logic;
			RESET			: in std_logic
		);
end Adder;

architecture RCL of Adder is

	signal COMMUNICATION : std_logic_vector(WIDTH-1 downto 0);
	
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
	
	component CSA is 
		port(
			A : in std_logic_vector 	(31 downto 0);
			B : in std_logic_vector 	(31 downto 0);
			C : in std_logic_vector		(31 downto 0);
			Z : out std_logic_vector 	(31 downto 0)
		);
	end component;
begin

	IstanceCSA: CSA
		port map(
			A	=> X,
			B	=>	Y,
			C	=> Y_SHIFTED,
			Z	=> COMMUNICATION
		);
		
	SH_CSA: MEMORY
			generic map (
				WIDTH => WIDTH
			)
			port map(
				Y		=> COMMUNICATION,
				Q		=> Y_CSA,
				CLOCK => CLOCK,
				RESET => RESET
			);

end RCL;