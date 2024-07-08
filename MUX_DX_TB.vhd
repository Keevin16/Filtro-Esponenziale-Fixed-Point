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
     

      X <= "11111111111111111111111111111111";
      K <= "000";

      assert (Y = "11111111111111111111111111111111") report "Test 1 failed" severity error;
      wait for 10 ns;
		
      X <= "01111111111111111111111111111111";
      K <= "001";
      assert (Y = "0011111111111111111111111111111111") report "Test 2 failed" severity error;
		wait for 10 ns;
		
      X <= "01111111111111111111111111111111";
      K <= "101";
		wait for 10 ns;
      assert (Y = "000000111111111111111111111111111") report "Test 2 failed" severity error;


      wait;
   end process;

END;
