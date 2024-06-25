library ieee;
use ieee.std_logic_1164.all;

entity PA_tb is
end PA_tb;

architecture behavior of PA_tb is

    component PA
        generic(
            WIDTH: Integer := 32
        );
        port(
            X : in  std_logic_vector (WIDTH - 1 downto 0);
            S : out std_logic_vector (WIDTH - 1 downto 0)
        );
    end component;

    signal X_TEST : std_logic_vector(31 downto 0):= (others => '0');
    signal S_TEST : std_logic_vector(31 downto 0);

begin

    uut: PA port map(
        X => X_TEST,
        S => S_TEST
    );

    stim_proc: process
    begin
        X_TEST <= "01010101010101010101010101010101";
        wait for 10 ns;
        assert (S_TEST= "01010101010101010101010101010110") report "Test 1 failed" severity error;

        X_TEST <= "00000000111111111111111111111111";
        wait for 10 ns;
        assert (S_TEST = "00000001000000000000000000000000") report "Test 2 failed" severity error;

        X_TEST <= "11110000111100001111000011110000";
        wait for 10 ns;
        assert (S_TEST = "11110000111100001111000011110001") report "Test 3 failed" severity error;

		  X_TEST <= "01011010110011111101100010010111";
        wait for 10 ns;
        assert (S_TEST = "01011010110011111101100010011000") report "Test 4 failed" severity error;


        wait;
    end process;

end behavior;
