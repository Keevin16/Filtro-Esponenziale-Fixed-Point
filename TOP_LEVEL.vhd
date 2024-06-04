----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_LEVEL is
	port(
		CLOCK,RESET : in std_logic;
		X				: in std_logic_vector(31 downto 0);
		Y				: out std_logic_vector(31 downto 0)
	);
end TOP_LEVEL;

architecture Behavioral of TOP_LEVEL is
	signal FINAL_Y			: std_logic_vector(31 downto 0);
	signal COMMUNICATION	: std_logic_vector(31 downto 0);
	signal TEMP_X 			: std_logic_vector(31 downto 0);
	signal TEMP_Y			: std_logic_vector(31 downto 0);
		
		component MULTIPLEXER_DX is 
			port(
				CLOCK : in std_logic;
				RESET : in std_logic;
				X     : in std_logic_vector (31 downto 0);
				K     : in std_logic_vector (2 downto 0);
				Y     : out std_logic_vector (31 downto 0)
			);
		end component;
		
		component MEMORY is
			port (
				CLOCK, RESET : in std_logic;
				Y : in std_logic_vector(31 downto 0);
				Q : out std_logic_vector(31 downto 0)
			);
		end component;

		component topLevelOnY is
			port (
			  CLOCK, RESET :in std_logic;
			  Y 				:in std_logic_vector	(31 downto 0);
			  K				:in std_logic_vector	( 2 downto 0);
			  Z 				:out std_logic_vector(31 downto 0)
			);
		end component;
	
		component CSA_TWOIN is
			 generic (
				  INITIAL_CIN : std_logic := '0'
			 );
			 port (
				A : in std_logic_vector(31 downto 0);
				B : in std_logic_vector(31 downto 0);
				Z : out std_logic_vector(31 downto 0)
			 );
		end component;
		
begin
		process begin
			FINAL_Y <= (others => '0'); 
		end process;
		
		multiplexerDX: MULTIPLEXER_Dx 
			port map (
            CLOCK => CLOCK,
            RESET => RESET,
            X     => X,
            K     => K,
            Y     => TEMP_X
        );

		istanceMemory: MEMORY
			port map(
				CLOCK	=> CLOCK, 
				RESET	=> RESET,
				Y 		=> FINAL_Y,
				Q 		=> TEMP_Y
			);
			
		istanceTopLevelY: topLevelOnY
			port map(
				CLOCK	=> CLOCK, 
				RESET	=> RESET,
				Y 		=> TEMP_Y,
				K		=>	K,
				Z 		=>TEMP_Y
			);
			
		istanceCSA: CSA_TWOIN
			generic map (
				INITIAL_CIN => '0'  
			)
			port map (
				A => TEMP_X,     
				B => TEMP_Y,           
            Z => FINAL_Y
			);

end Behavioral;

