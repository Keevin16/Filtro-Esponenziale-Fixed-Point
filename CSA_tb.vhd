LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY CSA_tb IS
END CSA_tb;
 
ARCHITECTURE behavior OF CSA_tb IS 

    COMPONENT CSA_TWOIN
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Z : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Z : std_logic_vector(31 downto 0);
   constant clock_period : time := 10 ns;
 
BEGIN
 
   uut: CSA_TWOIN PORT MAP (
          A => A,
          B => B,
          Z => Z
        );

   CLOCK_process :process
   begin
		CLOCK <= '0';
		wait for clock_period/2;
		CLOCK <= '1';
		wait for clock_period/2;
   end process;



   stim_proc: process
   begin      
      wait for 100 ns;  

      wait for clock_period*10;

      -- Test case 1: Somma di due numeri positivi
      A <= "00000000000000000000000000001010";
      B <= "00000000000000000000000000001111";
      wait for clock_period*10;
      assert Z = "00000000000000000000000000011001" report "Test case 1 failed" severity error;

      -- Test case 2: Somma di un numero positivo e uno negativo
      A <= "11111111111111111111111111111110";
      B <= "00000000000000000000000000001001";
      wait for clock_period*10;
      assert Z = "10000000000000000000000000000011" report "Test case 2 failed" severity error;

      -- Test case 3: Somma di numeri negativi
      A <= "11111111111111111111111111111000";
      B <= "11111111111111111111111111111100";
      wait for clock_period*10;
      assert Z = "11111111111111111111111111111010" report "Test case 3 failed" severity error;

      wait;
   end process;

END behavior;
