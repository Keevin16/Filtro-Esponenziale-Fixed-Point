-------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity MEMORY_TB is
end MEMORY_TB;

architecture behavior of MEMORY_TB is 

    component MEMORY
        port(
            CLOCK : in	std_logic;
            RESET : in  std_logic;
            Y : in  std_logic_vector(31 downto 0);
            Q : out  std_logic_vector(31 downto 0)
        );
    end component;

    -- Inputs
    signal CLOCK : std_logic := '0';
    signal RESET : std_logic := '0';
    signal Y : std_logic_vector(31 downto 0) := (others => '0');

    -- Outputs
    signal Q : std_logic_vector(31 downto 0);

    constant CLOCK_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: MEMORY
        port map (
            CLOCK => CLOCK,
            RESET => RESET,
            Y => Y,
            Q => Q
        );

    -- Clock process definitions
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
        Y <= "00010010001101000101011001111000";
        wait for CLOCK_period;
        assert (Q = Y) report "Test case 1 failed" severity error;

        -- Test Reset
        Y <= "10000111011001010100001100100001";
        RESET <= '1';
        wait for CLOCK_period;
        assert Q = "00000000000000000000000000000000" report "Test case 2 failed" severity error;

		  RESET <= '0';
		  wait for CLOCK_period;
		  
        Y <= "10101010101110111100110011011101";
        wait for CLOCK_period;
        assert (Q = Y) report "Test case 3 failed" severity error;

        wait for CLOCK_period;
        assert (Q = "10101010101110111100110011011101") report "Test case 3 failed" severity error;

		  Y <= "10101010101110111100110011011101";
		  RESET <= '1';
		  wait for CLOCK_period;
		  wait for CLOCK_period;
		  assert Q = "00000000000000000000000000000000" report "Test case 4 failed" severity error;
		  
		  wait;
    end process;

END behavior;
