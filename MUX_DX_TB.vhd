--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

 
entity MUX_DX_TB is
end MUX_DX_TB;
 
architecture behavior of MUX_DX_TB is 

    component MULTIPLEXER_SX
    port(
         X : in  std_logic_vector(31 downto 0);
         K : in  std_logic_vector(2 downto 0);
         Y : out  std_logic_vector(31 downto 0)
        );
    end component;
    

   --Inputs
   signal X : std_logic_vector(31 downto 0) := (others => '0');
   signal K : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal Y : std_logic_vector(31 downto 0);

 
begin

   uut: MULTIPLEXER_SX port map(
          X => X,
          K => K,
          Y => Y
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
     
	   wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "000";
      wait for 10 ns;
      assert (Y = "11111111111111111111111111111111") report "Test 1 failed" severity error;

      wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "001";
		wait for 10 ns;
      assert (Y = "01111111111111111111111111111111") report "Test 2 failed" severity error;

      wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "010";
		wait for 10 ns;
      assert (Y = "00111111111111111111111111111111") report "Test 3 failed" severity error;

      wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "011";
		wait for 10 ns;
      assert (Y = "00011111111111111111111111111111") report "Test 4 failed" severity error;

      wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "100";
		wait for 10 ns;
      assert (Y = "00001111111111111111111111111111") report "Test 5 failed" severity error;

		wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "110";
		wait for 10 ns;
      assert (Y = "00000011111111111111111111111111") report "Test 7 failed" severity error;

      wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "111";		
		wait for 10 ns;
      assert (Y = "00000001111111111111111111111111") report "Test 8 failed" severity error;


      wait;
   end process;

END;
