----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity CSA_TWOIN is
   generic (
			INITIAL_CIN : std_logic:='0'
   );
	port(
			A : in std_logic_vector 	(31 downto 0);
			B : in std_logic_vector 	(31 downto 0);
			Z : out std_logic_vector (31 downto 0)
	);
end CSA_TWOIN;

architecture Behavioral of CSA_TWOIN is

	signal CARRY_SAVE	: std_logic_vector (31 downto 0);
   signal SUM_CSA   	: std_logic_vector (31 downto 0);
	signal CARRY_IN	: std_logic_vector (31 downto 0);
	signal TEMP_Z		: std_logic_vector (31 downto 0);
	signal LAST_COUT 	: std_logic; 
	
	component FA is 
        port(
            X     : in  std_logic;  
            Y     : in  std_logic;  
            CIN   : in  std_logic;  
            S     : out std_logic;  
            COUT  : out std_logic 
        );
    end component;
	 
	 component HA is 
        port(
            X     : in  std_logic;  
            Y     : in  std_logic;   
            S     : out std_logic;  
            COUT  : out std_logic 
        );
    end component;

begin

	--top part 
	--da definire il primo full adder con input 1
			
		firstFullAdder: FA
        port map(
            X    => A(0),
            Y    => B(0),
            CIN  => INITIAL_CIN, 
            S    => SUM_CSA(0),
            COUT => CARRY_SAVE(0)
        );
			
		carrySave: for I in 0 to 30 generate
			carrySaveInstance: HA
				port map(
					X 		=> A(I+1),
					Y 		=> B(I+1),
					S 		=> SUM_CSA(I+1),
					COUT	=> CARRY_SAVE(I+1)
				);
		end generate;
	
	--botton part 	    			 
			firstHa : HA
				port map(
					X		=> CARRY_SAVE(0),
					Y 		=> SUM_CSA(1),
					S		=> TEMP_Z(1),
					COUT	=> CARRY_IN(0)
				);	 
				
		TEMP_Z(0)		<= SUM_CSA(0);
			 
		fullAdders : for K in 0 to 29 generate
			fullAdderIstance: FA
				port map(
					X		=> CARRY_SAVE (K+1),
					Y		=> SUM_CSA (K+2),
					CIN	=> CARRY_IN (K),
					S		=> TEMP_Z(K+1),
					COUT	=> CARRY_IN (K+1)
				);
		end generate;
			  
			lastHa : HA
				port map(
					X		=> CARRY_SAVE	(31),
					Y 		=> CARRY_IN	(30),
					S		=> TEMP_Z(31),
					COUT	=> LAST_COUT
				);
				
		process (TEMP_Z, LAST_COUT) begin
			TEMP_Z		<= LAST_COUT & TEMP_Z(30 downto 0);
		end process;
		
		Z		<= TEMP_Z; 				
		
end Behavioral;