----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- The input Y is the value leaving the FFDs
entity topLevelOnY is
    port (
        CLOCK, RESET :in std_logic;
        Y 				:in std_logic_vector	(31 downto 0);
		  K				:in std_logic_vector	( 2 downto 0);
        Z 				:out std_logic_vector(31 downto 0)
    );
end topLevelOnY;

architecture Behavioral of topLevelOnY is
	signal COMMUNICATION : std_logic_vector(31 downto 0);
	signal COMMUNICATION2: std_logic_vector(31 downto 0);
	
		component MULTIPLEXER_SX is 
			port(
				CLOCK : in std_logic;
				RESET : in std_logic;
				X     : in std_logic_vector (31 downto 0);
				K     : in std_logic_vector (2 downto 0);
				Y     : out std_logic_vector (31 downto 0)
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
		
		component MULTIPLEXER_DX is 
			port(
				CLOCK : in std_logic;
				RESET : in std_logic;
				X     : in std_logic_vector (31 downto 0);
				K     : in std_logic_vector (2 downto 0);
				Y     : out std_logic_vector (31 downto 0)
			);
		end component;
	
begin

		multiplexerSX: MULTIPLEXER_SX 
			port map (
            CLOCK => CLOCK,
            RESET => RESET,
            X     => Y,
            K     => K,
            Y     => COMMUNICATION
        );
			
		csaTwoIn: CSA_TWOIN
			generic map (
				INITIAL_CIN => '1'  
			)
			port map (
				A => COMMUNICATION,     
				B => not Y,           
            Z => COMMUNICATION2
			);
			
		multiplexerDX: MULTIPLEXER_Dx 
			port map (
            CLOCK => CLOCK,
            RESET => RESET,
            X     => COMMUNICATION2,
            K     => K,
            Y     => Z
        );
		
end Behavioral;

