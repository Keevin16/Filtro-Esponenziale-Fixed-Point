--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

 
ENTITY C2_Shift_tb IS
END C2_Shift_tb;
 
ARCHITECTURE behavior OF C2_Shift_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component C2AndShift
    port(
         Y_CSA : in  std_logic_vector(31 downto 0);
         K : in  std_logic_vector(2 downto 0);
         Z_CSA : out  std_logic_vector(31 downto 0)
        );
    end component;
    

   --Inputs
   signal Y_CSA : std_logic_vector(31 downto 0) := (others => '0');
   signal K : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal Z_CSA : std_logic_vector(31 downto 0);
 

begin
 
   uut: C2AndShift port map(
          Y_CSA => Y_CSA,
          K => K,
          Z_CSA => Z_CSA
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
	
      wait for 100 ns;	

		
		Y_CSA <= "00011110000111110000000000000000";
      K		<= "111";
		wait for 10 ns;
--		assert Z_CSA = "11111111110000111100001000000000"
--			report "Test case 1 failed" severity error;
--
--		Y_CSA <= "00000000101100110101000101111101";
--      K		<= "111";
--		wait for 10 ns;
--		assert Z_CSA = "00000001111111101001100101011101"
--			report "Test case 2 failed" severity error;
--		
--		Y_CSA <= x"AF170000";
--		K		<= "110";
--		wait for 10 ns;
--		assert Z_CSA = "00000001010000111010010000000000" report "Test case 3 failed" severity error;
--      
		wait;
   end process;
	
end;
