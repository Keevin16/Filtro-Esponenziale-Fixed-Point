-------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
 
entity CSA_tb is
end CSA_tb;
 
architecture behavior of CSA_tb is 

    component CSA
    port(
         A : in  std_logic_vector(31 downto 0);
         B : in  std_logic_vector(31 downto 0);
         C : in  std_logic_vector(31 downto 0);
			Z : out  std_logic_vector(31 downto 0)
        );
    end component;
    
   signal A_TEST : std_logic_vector(31 downto 0) := (others => '0');
   signal B_TEST : std_logic_vector(31 downto 0) := (others => '0');
	signal C_TEST : std_logic_vector(31 downto 0) := (others => '0');
   signal Z_TEST : std_logic_vector(31 downto 0);
 
begin
   uut: CSA port map(
         A => A_TEST,
         B => B_TEST,
			C => C_TEST,
			Z => Z_TEST
		  );

   stim_proc: process
   begin       

			A_TEST	<= "00000000001111000011111000000000";--3948032
			B_TEST	<= "00000000011110000000001110000100";--7865220
			C_TEST	<= "00000000101100110101000101111101";--11751805
			wait for 20 ns;
			assert Z_TEST = "00000001011001111001001100000001"
					report "Test case 1 failed" severity error;
				
			A_TEST	<= "00000011110111010110001101001001";--64840521
			B_TEST	<= "00000011011011110000001101100100";--57607012
			C_TEST	<= "00000100010010000101000000101111";--71847983
			wait for 20 ns;
			assert Z_TEST = "00001011100101001011011011011100"
					report "Test case 2 failed" severity error;
			
			A_TEST	<= "01011010110011111101100010010111";--1523570839
			B_TEST	<= "01010110011100010110001110110101";--1450271669
			C_TEST	<= "01010001111011101101101010001001";--1374608009
			wait for 20 ns;
			assert Z_TEST = "00000011001100000001011011010101"--Il numero è più piccolo perchè vengono persi i bit più grandi
					report "Test case 3 failed" severity error;
			
      wait;
   end process;

END behavior;
