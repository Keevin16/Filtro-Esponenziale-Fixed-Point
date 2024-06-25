----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity Memory_tb is
end Memory_tb;

architecture behavior of Memory_tb is 

    component MEMORY
        port(
            CLOCK : in  std_logic;
            RESET : in  std_logic;
            Y : in  std_logic_vector(31 downto 0);
            Q : out  std_logic_vector(31 downto 0)
        );
    end component;
    
    signal CLOCK : std_logic := '0';
    signal RESET : std_logic := '0';
    signal Y : std_logic_vector(31 downto 0) := (others => '0');
    signal Q : std_logic_vector(31 downto 0);

    constant CLOCK_period : time := 10 ns;

begin

    uut: MEMORY PORT MAP (
        CLOCK => CLOCK,
        RESET => RESET,
        Y => Y,
        Q => Q
    );

    CLOCK_process: process
    begin
        while True loop
            CLOCK <= '0';
            wait for CLOCK_period / 2;
            CLOCK <= '1';
            wait for CLOCK_period / 2;
        end loop;
    end process;

    stim_proc: process
    begin    
        -- Apply first input and wait for a clock period
        Y <= "10001000011001100111110011110101";
        wait for CLOCK_period;
        wait for CLOCK_period;
        assert Q = Y report "Test 1 failed" severity error;
        
        -- Apply reset and check if output is cleared
        wait for CLOCK_period;
        Y <= "01010101010101010101010101010101";library ieee;
use ieee.std_logic_1164.all;

entity Memory_tb is
end Memory_tb;

architecture behavior of Memory_tb is 

    component MEMORY
        port(
            CLOCK : in  std_logic;
            RESET : in  std_logic;
            Y : in  std_logic_vector(31 downto 0);
            Q : out  std_logic_vector(31 downto 0)
        );
    end component;
    
    signal CLOCK : std_logic := '0';
    signal RESET : std_logic := '0';
    signal Y : std_logic_vector(31 downto 0) := (others => '0');
    signal Q : std_logic_vector(31 downto 0);
    signal ZERO_VECTOR : std_logic_vector(31 downto 0) := (others => '0');

    constant CLOCK_period : time := 10 ns;

begin

    uut: MEMORY PORT MAP (
        CLOCK => CLOCK,
        RESET => RESET,
        Y => Y,
        Q => Q
    );

    CLOCK_process: process
    begin
        while True loop
            CLOCK <= '0';
            wait for CLOCK_period / 2;
            CLOCK <= '1';
            wait for CLOCK_period / 2;
        end loop;
    end process;

    stim_proc: process
    begin    
        -- Apply first input and wait for a clock period
        Y <= "10001000011001100111110011110101";
        wait for CLOCK_period;
        wait for CLOCK_period;
        assert Q = Y report "Test 1 failed" severity error;
        
        -- Apply reset and check if output is cleared
        wait for CLOCK_period;
        Y <= "01010101010101010101010101010101";
        RESET <= '1';
        wait for CLOCK_period;
        RESET <= '0';
        wait for CLOCK_period;
        assert Q = ZERO_VECTOR report "Test 2 failed" severity error;
        
        -- Apply second input and wait for a clock period
        wait for CLOCK_period;
        Y <= "00110011001100110011001100110011";
        wait for CLOCK_period;
        wait for CLOCK_period;
        assert Q = Y report "Test 3 failed" severity error;
        
        -- Apply reset and check if output is cleared again
        wait for CLOCK_period;
        Y <= "11110000111100001111000011110000";
        wait for CLOCK_period;
        RESET <= '1';
        wait for CLOCK_period;
        RESET <= '0';
        wait for CLOCK_period;
        assert Q = ZERO_VECTOR report "Test 4 failed" severity error;

        wait;
    end process;

end behavior;
