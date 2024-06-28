--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
 
entity FiltroExp_tb is
end FiltroExp_tb;
 
architecture behavior of FiltroExp_tb is 
 
   
    component FiltroEsponenzialeFixedPoint
    port(
         X 			: in  std_logic_vector(31 downto 0);
         K 			: in  std_logic_vector(2 downto 0);
         CLOCK 	: in  std_logic;
         INIT 		: in  std_logic;
--			VALID_OUT: out std_logic;
         Y 			: out  std_logic_vector(31 downto 0)
    );
	end component;
    

   --Inputs
   signal X : std_logic_vector(31 downto 0) := (others => '0');
   signal K : std_logic_vector(2 downto 0) := (others => '0');
   signal CLOCK : std_logic := '0';
   signal INIT : std_logic := '0';

 	--Outputs
   signal Y : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLOCK_period : time := 40 ns;
 
BEGIN
 
   uut: FiltroEsponenzialeFixedPoint PORT MAP (
          X => X,
          K => K,
          CLOCK => CLOCK,
          INIT => INIT,
          Y => Y
        );

   -- Clock process definitions
    CLOCK_process :process
    begin
        while true loop
            CLOCK <= '0';
            wait for CLOCK_period/2;
            CLOCK <= '1';
            wait for CLOCK_period/2;
        end loop;
    end process;
 

   stim_proc: process
   begin		
		INIT <='1';
		wait for CLOCK_period;
			assert Y = "00000000000000000000000000000000" report "Test case 0 failed" severity error;
			
		
		
		INIT 	<='0';
		wait for CLOCK_period;
		
		X		<= x"1E1F0000";
		K		<= "111";
	
--		wait for CLOCK_period;
--			assert Y = X"00000000011110000000001110000100" report "Test case 1 failed" severity error;
--		
--		wait for CLOCK_period;
--			assert Y = "00000000101100110101000101111101" report "Test case 2 failed" severity error;
		 	wait for 300 ns;
			INIT	<= '1';
			wait for 100 ns;
			
			INIT <='0';
		
	
 
      wait;
   end process;

END;