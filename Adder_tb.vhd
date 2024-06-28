--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
 
entity Adder_tb is
end Adder_tb;
 
architecture behavior of Adder_tb is
 
    
    component Adder
    port(
         X : in  std_logic_vector(31 downto 0);
         Y : in  std_logic_vector(31 downto 0);
         Y_SHIFTED : in  std_logic_vector(31 downto 0);
         Y_CSA : out  std_logic_vector(31 downto 0);
         CLOCK : in  std_logic;
         RESET : in  std_logic
        );
    end component;
    

   --Inputs
   signal X : std_logic_vector(31 downto 0) := (others => '0');
   signal Y : std_logic_vector(31 downto 0) := (others => '0');
   signal Y_SHIFTED : std_logic_vector(31 downto 0) := (others => '0');
   signal CLOCK : std_logic := '0';
   signal RESET : std_logic := '0';

 	--Outputs
   signal Y_CSA : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLOCK_period : time := 20 ns;
 
begin
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Adder port map(
          X => X,
          Y => Y,
          Y_SHIFTED => Y_SHIFTED,
          Y_CSA => Y_CSA,
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
 

   -- Stimulus process
   stim_proc: process
   begin		
		
		RESET				<= '1';
		wait for CLOCK_period;
		
			RESET 		<= '0';
			X				<= "00000000001111000011111000000000";--3948032
			Y				<= "00000000011110000000001110000100";--7865220
			Y_SHIFTED	<= "00000000101100110101000101111101";--11751805
			wait for CLOCK_period;
			assert Y_CSA = "00000001011001111001001100000001"
					report "Test case 1 failed" severity error;
				
			X				<= "00000011110111010110001101001001";--64840521
			Y				<= "00000011011011110000001101100100";--57607012
			Y_SHIFTED	<= "00000100010010000101000000101111";--71847983
			wait for 11 ns;
			RESET <= '1';
			assert Y_CSA = "00001011100101001011011011011100"
					report "Test case 2 failed" severity error;
			wait for 9 ns;		
			
			RESET <='0';
			X				<= "01011010110011111101100010010111";--1523570839
			Y				<= "01010110011100010110001110110101";--1450271669
			Y_SHIFTED	<= "01010001111011101101101010001001";--1374608009
			wait for CLOCK_period;
			assert Y_CSA = "00000011001100000001011011010101"--Il numero è più piccolo perchè vengono persi i bit più grandi
					report "Test case 3 failed" severity error;
					
      wait;
   end process;

END;
