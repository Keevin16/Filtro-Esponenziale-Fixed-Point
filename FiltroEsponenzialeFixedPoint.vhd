----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity FiltroEsponenzialeFixedPoint is
	generic(
		WIDTH:Integer :=32
	);
	port(
		X				: in  std_logic_vector (WIDTH-1 downto 0);
		K				: in  std_logic_vector (2 downto 0);
		CLOCK			: in 	std_logic;
		INIT			: in 	std_logic;
		Y				: out std_logic_vector (WIDTH-1 downto 0)
	);
end FiltroEsponenzialeFixedPoint;

architecture RCL of FiltroEsponenzialeFixedPoint is

	signal COMMUNICATION_X 		: std_logic_vector(WIDTH-1 downto 0);
	signal COMMUNICATION_K		: std_logic_vector(2 downto 0);
	signal COMMUNICATION_OUT1	: std_logic_vector(WIDTH-1 downto 0);
	signal COMMUNICATION_C2_OUT: std_logic_vector(WIDTH-1 downto 0);
	signal COMMUNICATION_CSA	: std_logic_vector(WIDTH-1 downto 0);
	signal COMMUNICATION_C2_IN : std_logic_vector(WIDTH-1 downto 0);
	

	component C2AndShift is
		generic(
			WIDTH:Integer :=32
		);
		port(
			Y_CSA		: in  std_logic_vector (WIDTH-1 downto 0);
			K			: in 	std_logic_vector (2 downto 0);
			Z_CSA		: out std_logic_vector (WIDTH-1 downto 0)
		); 
	end component;
	
	
	component HoldAndShift_X is
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
	end component;
	
	component Adder is
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
	end component;
	
begin

COMMUNICATION_C2_IN	<= COMMUNICATION_CSA;
COMMUNICATION_OUT1	<= COMMUNICATION_CSA;

	

	ShiftX_Istance	:	HoldAndShift_X
			generic map (
				WIDTH => WIDTH
			)
			port map(
				X				=>	X,
				K				=> K,
				K_SH			=> COMMUNICATION_K,
				X_SHIFTED	=>	COMMUNICATION_X,
				
				CLOCK 		=> CLOCK,
				RESET			=> INIT
			);
	
	
	C2_Istance		:	C2AndShift
		generic map(
			WIDTH	=> WIDTH
		)
		port map(
			Y_CSA				=>	COMMUNICATION_C2_IN,
			K					=>	COMMUNICATION_K,
			Z_CSA				=>	COMMUNICATION_C2_OUT
		);

	
	AdderIstance: Adder
		generic map(
			WIDTH	=> WIDTH
		)
		port map(
			X					=> COMMUNICATION_X,
			Y					=>	COMMUNICATION_OUT1,
			Y_SHIFTED		=>	COMMUNICATION_C2_OUT,
			Y_CSA				=> COMMUNICATION_CSA,
			CLOCK 			=> CLOCK,
			RESET				=> INIT
		);
		
	Y							<= COMMUNICATION_CSA;
	

end RCL;
