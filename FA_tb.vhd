library ieee;
use ieee.std_logic_1164.all;

entity FA_Testbench is
end entity FA_Testbench;

architecture behavior of FA_Testbench is 
    -- Dichiarazione dei segnali di ingresso e uscita
    signal X, Y, CIN   : std_logic;
    signal SUM_expected, COUT_expected : std_logic;

    -- Costanti per il periodo del clock e la durata del test
    constant CLOCK_PERIOD : time := 10 ns;
    constant TEST_DURATION : time := 100 ns;

    -- Componente under test
    component FA
        port (
            X    : in  std_logic;  
            Y    : in  std_logic;  
            CIN  : in  std_logic;  
            SUM  : out std_logic;  
            COUT : out std_logic   
        );
    end component;

begin

    -- Processo di generazione del clock
    clock_process : process
    begin
        while true loop
            wait for CLOCK_PERIOD / 2;
            X <= not X; -- Inverte X ad ogni semiperiodo di clock
        end loop;
    end process;

    -- Stimulus process
    stimulus_proc : process
    begin
        -- Inizializzazione
        X <= '0';
        Y <= '0';
        CIN <= '0';

        -- Test case 1: X = '0', Y = '0', CIN = '0'
        wait for TEST_DURATION;
        assert (SUM_expected = '0' and COUT_expected = '0') report "Test case 1 failed" severity error;

        -- Test case 2: X = '1', Y = '0', CIN = '0'
        X <= '1';
        wait for TEST_DURATION;
        assert (SUM_expected = '1' and COUT_expected = '0') report "Test case 2 failed" severity error;

        -- Test case 3: X = '0', Y = '1', CIN = '0'
        X <= '0';
        Y <= '1';
        wait for TEST_DURATION;
        assert (SUM_expected = '1' and COUT_expected = '0') report "Test case 3 failed" severity error;

        -- Test case 4: X = '1', Y = '1', CIN = '0'
        X <= '1';
        wait for TEST_DURATION;
        assert (SUM_expected = '0' and COUT_expected = '1') report "Test case 4 failed" severity error;

    end process;

end behavior;
