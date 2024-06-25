----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity PA is
	generic(
		WIDTH:Integer :=32
	);
	port(
		X    : in  std_logic_vector (width - 1 downto 0);
      S    : out std_logic_vector (width - 1 downto 0)
   );
end PA;

architecture RCL of PA is
    signal CARRY: std_logic_vector(WIDTH-1 downto 0);
    component HA is 
		 port(
			X  	: in  std_logic;
			Y		: in  std_logic;
			SUM   : out std_logic;
			COUT 	: out std_logic
		 );
    end component;

begin
    
	 FirstHA: Ha
		port map(
				X		=> X(0),
				Y 		=> '1',
				SUM	=> S(0),
				COUT	=> CARRY(0)
		);
	 
   HAs: for I in 1 to WIDTH - 2 generate
        U: HA port map(
            X    => X(I),
            Y	  => CARRY(I-1),
            SUM  => S(I),
            COUT => CARRY(I)
        );
	end generate;
		  
	LastHA: HA
		port map(
				X		=> X(WIDTH-1),
				Y 		=> CARRY(WIDTH-2),
				SUM	=> S(WIDTH-1),
				COUT	=> open
		);

end RCL;