-------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
 
ENTITY TopLevelY_TB IS
END TopLevelY_TB;
 
ARCHITECTURE behavior OF TopLevelY_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TopLevelY
    PORT(
         Y_RESULT : IN  std_logic_vector(31 downto 0);
         Y_OUT1 : OUT  std_logic_vector(31 downto 0);
         Y_OUT2 : OUT  std_logic_vector(31 downto 0);
         K : IN  std_logic_vector(2 downto 0);
         CLOCK : IN  std_logic;
         RESET : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Y_RESULT : std_logic_vector(31 downto 0) := (others => '0');
   signal K : std_logic_vector(2 downto 0) := (others => '0');
   signal CLOCK : std_logic := '0';
   signal RESET : std_logic := '0';

 	--Outputs
   signal Y_OUT1 : std_logic_vector(31 downto 0);
   signal Y_OUT2 : std_logic_vector(31 downto 0);

   constant CLOCK_period : time := 10 ns;
 
begin
 
	uut: TopLevelY port map (
          Y_RESULT => Y_RESULT,
          Y_OUT1 => Y_OUT1,
          Y_OUT2 => Y_OUT2,
          K => K,
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
        Y_RESULT <= "00010010001101000101011001111000";
		  K <= "001";
        wait for CLOCK_period;
        wait for CLOCK_period;
        assert (Y_OUT1 = "00010010001101000101011001111000") report "Test case 1. Out1 failed" severity error;
		  assert (Y_OUT2 = "01110110111001011101010011000100") report "Test case 1. Out2 failed" severity error;
        
		  K <= "010";
        wait for CLOCK_period;
        wait for CLOCK_period;
        assert (Y_OUT2 = "00111011011100101110101001100010") report "Test case 2 failed" severity error;

        RESET <= '1';
        wait for CLOCK_period;
        RESET <= '0';
        wait for CLOCK_period;
        wait for CLOCK_period;
        assert Y_OUT1 =	"00000000000000000000000000000000" report "Test case 3 failed" severity error;

        Y_RESULT <= "11110000111100001111000011110000";
		  K <= "011";
        wait for CLOCK_period;
        wait for CLOCK_period;
        assert (Y_OUT1 = "11110000111100001111000011110000") report "Test case 5 failed" severity error;
		  assert (Y_OUT2 = "00000001111000011110000111100010") report "Test case 6 failed" severity error;

       

    end process;
end;