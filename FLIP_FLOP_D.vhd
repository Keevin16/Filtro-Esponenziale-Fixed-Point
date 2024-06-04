----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FLIP_FLOP_D is
    port (
        D, CLOCK : in std_logic;
        Q : out std_logic
    );
end FLIP_FLOP_D;

architecture BEHAVIOR of FLIP_FLOP_D is begin
    process(CLOCK) begin
        if rising_edge(CLOCK) then
            Q <= D;
        end if;
    end process;
end BEHAVIOR;
