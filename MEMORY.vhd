library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEMORY is
    port (
        CLOCK, RESET : in std_logic;
        Y : in std_logic_vector(31 downto 0);
        Q : out std_logic_vector(31 downto 0)
    );
end MEMORY;

architecture behavior of MEMORY is
    signal FF_D:std_logic_vector(31 downto 0);
    
    component FLIP_FLOP_D
        port (
            D, CLOCK: in std_logic;
            Q : out std_logic
        );
    end component;
    
begin
    process(CLOCK, RESET) begin
        if RESET = '1' then
            FF_D <= (others => '0');
        elsif rising_edge(CLOCK) then
            FF_D <= Y;     
        end if;
    end process;
    
    FFs: for I in 0 to 31 generate
        FLIP_FLOP_D_INSTANCE: FLIP_FLOP_D
            port map(
                D => FF_D(I),
                CLOCK => CLOCK,
                Q => Q(I)
            );
    end generate;
    
end behavior;
