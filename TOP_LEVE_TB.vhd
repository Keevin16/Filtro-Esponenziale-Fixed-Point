library ieee;
use ieee.std_logic_1164.all;

entity TOP_LEVEL_TB is
end TOP_LEVEL_TB;

architecture behavior of TOP_LEVEL_TB is

    component TOP_LEVEL
        generic(
            WIDTH: Integer := 32
        );
        port(
            X      : in  std_logic_vector (WIDTH-1 downto 0);
            K      : in  std_logic_vector (2 downto 0);
            Y      : out std_logic_vector (WIDTH-1 downto 0);
            CLOCK  : in  std_logic;
            INIT   : in  std_logic
        );
    end component;

    signal X_TEST      : std_logic_vector(31 downto 0) ;
    signal K_TEST      : std_logic_vector(2 downto 0) ;
    signal CLOCK  	  : std_logic := '0';
    signal INIT  		  : std_logic := '0';

    signal Y_TEST      : std_logic_vector(31 downto 0):=(others => '0');

    -- Clock period definitions
    constant CLOCK_period : time := 20 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: TOP_LEVEL
        port map (
            X      => X_TEST,
            K      => K_TEST,
            Y      => Y_TEST,
            CLOCK  => CLOCK,
            INIT  => INIT
        );

    -- Clock process definitions
    CLOCK_process :process
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
        -- Apply Reset
        INIT <= '1';
        wait for CLOCK_period;
				assert Y_TEST = "00000000000000000000000000000000" 
						report "failed!!!!" severity error;
        INIT <= '0';
        wait for CLOCK_period;

        -- Test case 1
        X_TEST <= "00000000000000000001111000011111";
        K_TEST <= "111";
        wait for CLOCK_period;
        assert Y_TEST = "00000000001111000011111000000000"  -- 3948032
            report "Iteration 1 failed" severity error;

        -- Test case 2
        wait for CLOCK_period;
        assert Y_TEST = "00000000011110000000001110000100"  -- 7865220
            report "Iteration 2 failed" severity error;

        -- Test case 3
        wait for CLOCK_period;
        assert Y_TEST = "00000000101100110101000101111101"  -- 11751805
            report "Iteration 3 failed" severity error;

        -- Test case 4
        wait for CLOCK_period;
        assert Y_TEST = "00000000111011100010100011011000"  -- 15608026
            report "Iteration 4 failed" severity error;

        -- Test case 5
        wait for CLOCK_period;
        assert Y_TEST = "00000001001010001000101010001000"  -- 19434120
            report "Iteration 5 failed" severity error;

        -- Test case 6
        wait for CLOCK_period;
        assert Y_TEST = "00000001011000100111011101110011"  -- 23230323
            report "Iteration 6 failed" severity error;

        -- Test case 7
        wait for CLOCK_period;
        assert Y_TEST = "00000001100110111111000010000100"  -- 26996868
            report "Iteration 7 failed" severity error;

        -- End of simulation
        wait;
    end process;

end behavior;
