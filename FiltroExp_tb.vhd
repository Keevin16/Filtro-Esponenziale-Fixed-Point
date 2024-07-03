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
 
begin
 
   uut: FiltroEsponenzialeFixedPoint port map (
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

		X		<= x"1f680000";--	8040.00
		K		<= "101";
	
		--wait for CLOCK_period*7 ;
				wait for 432 ns ;
		
		INIT	<= '1';
		wait for CLOCK_period;
		
		INIT <= '0';
		X <= x"1e900000";-- 7824.00
		K <= "111";	
			--wait for CLOCK_period*8;
		wait for 170 ns ;
 
      wait;
   end process;

END;
