--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
 
entity C2_tb is
end C2_tb;
 
architecture behavior of C2_tb is
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component C2
    port(
         Y : in  std_logic_vector(31 downto 0);
         Z : out  std_logic_vector(31 downto 0)
        );
    end component;
    

   --Inputs
   signal Y_TEST : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Z_TEST : std_logic_vector(31 downto 0);

 
begin
 
	uut: C2 port map(
          Y => Y_TEST,
          Z => Z_TEST
        );

   stim_proc: process
   begin		
      Y_TEST <= "01010101010101010101010101010101";
      wait for 10 ns;
      assert (Z_TEST= "10101010101010101010101010101011") report "Test 1 failed" severity error;

	   Y_TEST <= "10000000000010000000000000000000";
      wait for 10 ns;
      assert (Z_TEST= "01111111111110000000000000000000") report "Test 2 failed" severity error;

	   Y_TEST <= "01011010110011111101100010010111";
      wait for 10 ns;
      assert (Z_TEST= "10100101001100000010011101101001") report "Test 3 failed" severity error;
		
		Y_TEST <= "00000000000000000000000000000000";
      wait for 10 ns;
      assert (Z_TEST= "00000000000000000000000000000000") report "Test 3 failed" severity error;
		
      wait;
   end process;

END;
