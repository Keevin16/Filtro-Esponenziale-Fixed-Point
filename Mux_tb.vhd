library ieee;
use ieee.std_logic_1164.all;

entity MULTIPLEXER_tb is
end MULTIPLEXER_tb;

architecture behavior of MULTIPLEXER_tb is
   -- Component declaration for the DUT
   component MULTIPLEXER_DX
       port (
           CLOCK : in  std_logic;
           RESET : in  std_logic;
           X     : in  std_logic_vector(31 downto 0);
           K     : in  std_logic_vector(2 downto 0);
           Y     : out std_logic_vector(31 downto 0)
       );
   end component;

   -- Signals for testbench
   signal CLOCK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal X : std_logic_vector(31 downto 0) := (others => '0');
   signal K : std_logic_vector(2 downto 0) := (others => '0');
   signal Y : std_logic_vector(31 downto 0);

   -- Constants for simulation parameters
   constant CLOCK_period : time := 10 ns;

begin
   -- Instantiate the DUT (Design Under Test)
   uut: MULTIPLEXER_DX
       port map (
           CLOCK => CLOCK,
           RESET => RESET,
           X => X,
           K => K,
           Y => Y
       );

   -- Clock process
   CLOCK_process: process
   begin
       while true loop
           CLOCK <= '0';
           wait for CLOCK_period / 2;
           CLOCK <= '1';
           wait for CLOCK_period / 2;
       end loop;
   end process;

   -- Stimulus process
   stim_proc: process
   begin
       wait for 100 ns;  -- Wait initial stabilization

       -- Test 1: Verifica il corretto funzionamento con K = "000"
       X <= "10001000011001100111110011110101";
       K <= "000";
       wait for 10 ns;
       assert Y = "10001000011001100111110011110101" report "Test 1 failed" severity error;
       wait for CLOCK_period;

       -- Test 2: Verifica il corretto funzionamento con K = "001"
       X <= "10001000011001100111110011110101";
       K <= "001";
       wait for 10 ns;
       assert Y = "01000100001100110011111001111010" report "Test 2 failed" severity error;
       wait for CLOCK_period;

       -- Test 3: Verifica il corretto funzionamento con K = "010"
       X <= "10001000011001100111110011110101";
       K <= "010";
       wait for 10 ns;
       assert Y = "00100010000110011001111100111101" report "Test 3 failed" severity error;
       wait for CLOCK_period;

       -- Test 4: Verifica il corretto funzionamento con K = "011"
       X <= "10001000011001100111110011110101";
       K <= "011";
       wait for 10 ns;
       assert Y = "00010001000011001100111110011110" report "Test 4 failed" severity error;
       wait for CLOCK_period;

       -- Test 5: Verifica il corretto funzionamento con K = "100"
       X <= "10001000011001100111110011110101";
       K <= "100";
       wait for 10 ns;
       assert Y = "00001000100001100110011111001111" report "Test 5 failed" severity error;
       wait for CLOCK_period;

      -- Test 6: Verifica il corretto funzionamento con K = "101"
      X <= "10001000011001100111110011110101";
      K <= "101";
      wait for 10 ns;
      assert Y = "00000100010000110011001111100111" report "Test 5 failed" severity error;
      wait for CLOCK_period;

		-- Test 7: Verifica il corretto funzionamento con K = "110"
      X <= "10001000011001100111110011110101";
      K <= "110";
      wait for CLOCK_period;
      assert (Y = "00000010001000011001100111110011") report "Test 7 failed" severity error;

      -- Test 8: Verifica il corretto funzionamento con K = "111"
      X <= "10001000011001100111110011110101";
      K <= "111";
      wait for CLOCK_period;
      assert (Y = "00000001000100001100110011111001") report "Test 8 failed" severity error;

		wait;
	end process;

END;
