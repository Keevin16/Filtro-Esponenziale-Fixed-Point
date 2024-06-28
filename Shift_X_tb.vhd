--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
 
entity Shift_X_tb is
end Shift_X_tb;
 
architecture behavior of Shift_X_tb is 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component HoldAndShift_X
    port(
         X 				: in  std_logic_vector(31 downto 0);
         K 				: in  std_logic_vector(2 downto 0);
         K_SH 		 	: out  std_logic_vector(2 downto 0);
         X_SHIFTED 	: out  std_logic_vector(31 downto 0);
         CLOCK 		: in std_logic;
         RESET 		: in  std_logic
        );
    end component;
    

   --Inputs
   signal X : std_logic_vector(31 downto 0) := (others => '0');
   signal K : std_logic_vector(2 downto 0) := (others => '0');
   signal CLOCK : std_logic := '0';
   signal RESET : std_logic := '0';

 	--Outputs
   signal K_SH : std_logic_vector(2 downto 0);
   signal X_SHIFTED : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLOCK_period : time := 10 ns;
 
BEGIN
 
	uut: HoldAndShift_X port map (
          X => X,
          K => K,
          K_SH => K_SH,
          X_SHIFTED => X_SHIFTED,
          CLOCK => CLOCK,
          RESET => RESET
        );

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
		 X 			<= "10000111011001010100001100100001";
       RESET 		<= '1';
       wait for CLOCK_period;
			assert X_SHIFTED = "00000000000000000000000000000000" report "Test case 0 failed" severity error;
			assert K_SH = "000" report "Test case 1 failed" severity error;
		
		RESET			<= '0';
		K				<=	"001";
		X 				<=	"00010010001101000101011001111000";
		wait for CLOCK_period;
			assert X_SHIFTED ="00001001000110100010101100111100" report "Test case 2 failed"   severity error;
			assert K_SH = "001"											  report "Test case 2.b failed" severity error; 
			
		X				<= "00001001000110100010101100111100";
		K				<= "111";
		
		wait for 6 ns;
		X				<= "00001001000000000010101100111100";--it's a different value!
		
				
			assert X_SHIFTED ="00000000000100100011010001010110" report "Test case 3 failed"   severity error;
			assert K_SH = "111"											  report "Test case 3.b failed" severity error;

      wait;
   end process;

end;