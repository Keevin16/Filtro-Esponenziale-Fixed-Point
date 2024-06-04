--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY MULTIPLEXER_tb IS
END MULTIPLEXER_tb;
 
ARCHITECTURE behavior OF MULTIPLEXER_tb IS 
 
 
    COMPONENT MULTIPLEXER
    PORT(
         CLOCK : IN  std_logic;
         RESET : IN  std_logic;
         X : IN  std_logic_vector(31 downto 0);
         K : IN  std_logic_vector(2 downto 0);
         Y : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
		signal CLOCK : std_logic := '0';
		signal RESET : std_logic := '0';
		signal X : std_logic_vector(31 downto 0) := (others => '0');
		signal K : std_logic_vector(2 downto 0) := (others => '0');

		signal Y : std_logic_vector(31 downto 0);

		-- Clock period definitions
		constant CLOCK_period : time := 10 ns;
 
BEGIN
 
   uut: MULTIPLEXER PORT MAP (
          CLOCK => CLOCK,
          RESET => RESET,
          X => X,
          K => K,
          Y => Y
        );

   CLOCK_process :process
   begin
		CLOCK <= '0';
		wait for CLOCK_period/2;
		CLOCK <= '1';
		wait for CLOCK_period/2;
   end process;
 

   stim_proc: process
   begin		
      wait for 100 ns;	

      wait for CLOCK_period*10;

            -- Test 1: Verifica il corretto funzionamento con K = "000"
      wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "000";
      wait for CLOCK_period;
      assert (Y = "11111111111111111111111111111111") report "Test 1 failed" severity error;

      -- Test 2: Verifica il corretto funzionamento con K = "001"
      wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "001";
      wait for CLOCK_period;
      assert (Y = "01111111111111111111111111111111") report "Test 2 failed" severity error;

      -- Test 3: Verifica il corretto funzionamento con K = "010"
      wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "010";
      wait for CLOCK_period;
      assert (Y = "00111111111111111111111111111111") report "Test 3 failed" severity error;

      -- Test 4: Verifica il corretto funzionamento con K = "011"
      wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "011";
      wait for CLOCK_period;
      assert (Y = "00011111111111111111111111111111") report "Test 4 failed" severity error;

      -- Test 5: Verifica il corretto funzionamento con K = "100"
      wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "100";
      wait for CLOCK_period;
      assert (Y = "00001111111111111111111111111111") report "Test 5 failed" severity error;

		-- Test 7: Verifica il corretto funzionamento con K = "110"
      wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "110";
      wait for CLOCK_period;
      assert (Y = "00000011111111111111111111111111") report "Test 7 failed" severity error;

      -- Test 8: Verifica il corretto funzionamento con K = "111"
      wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "111";
      wait for CLOCK_period;
      assert (Y = "00000001111111111111111111111111") report "Test 8 failed" severity error;

      -- Test 9: Verifica il corretto funzionamento con X = "00000000000000000000000000000001" e K = "000"
      wait for 10 ns;
      X <= "00000000000000000000000000000001";
      K <= "000";
      wait for CLOCK_period;
      assert (Y = "00000000000000000000000000000001") report "Test 9 failed" severity error;

      -- Test 10: Verifica il corretto funzionamento con X = "11111111111111111111111111111111" e K = "000"
      wait for 10 ns;
      X <= "11111111111111111111111111111111";
      K <= "000";
      wait for CLOCK_period;
      assert (Y = "11111111111111111111111111111111") report "Test 10 failed" severity error;



      wait;
   end process;

END;
