----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity CSA is
	port(
			A : in std_logic_vector 	(31 downto 0);
			B : in std_logic_vector 	(31 downto 0);
			C : in std_logic_vector		(31 downto 0);
			Z : out std_logic_vector 	(31 downto 0)
	);
end CSA;

architecture RCL of CSA is

	signal CARRY_SAVE	: std_logic_vector (31 downto 0);
   signal SUM_CSA   	: std_logic_vector (31 downto 0);
	signal CARRY_IN	: std_logic_vector (31 downto 0);
	
	component FA is 
        port(
            X     : in  std_logic;  
            Y     : in  std_logic;  
				CIN   : in  std_logic;  
            SUM   : out std_logic;  
            COUT  : out std_logic 
        );
	end component;
	 
	component HA is 
       port(
				X     : in  std_logic;  
				Y     : in  std_logic;   
				SUM   : out std_logic;  
				COUT  : out std_logic 
       );
   end component;

begin
--top part 
	carrySave: for I in 0 to 31 generate
		carrySaveInstance: FA
			port map(
				X 		=> A(I),
				Y 		=> B(I),
				CIN	=> C(I),		
				SUM 	=> SUM_CSA(I),
				COUT	=> CARRY_SAVE(I)
			);
	end generate;
	
--botton part 	    			 
		firstHa : HA
			port map(
				X		=> CARRY_SAVE(0),
				Y 		=> SUM_CSA(1),
				SUM	=> Z(1),
				COUT	=> CARRY_IN(0)
			);	 
				
	Z(0)		<= SUM_CSA(0);
			 
	fullAdders : for K in 1 to 30 generate
		fullAdderIstance: FA
			port map(
				X		=> CARRY_SAVE (K),
				Y		=> SUM_CSA (K+1),
				CIN	=> CARRY_IN (K-1),
				SUM	=> Z(K+1),
				COUT	=> CARRY_IN (K)
			);
	end generate;
		  
		lastHa : HA
			port map(
				X		=> CARRY_SAVE	(31),
				Y 		=> CARRY_IN	(30),
				SUM	=> open,
				COUT	=> open
			);
end RCL;