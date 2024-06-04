library ieee;
use ieee.std_logic_1164.all;

entity MULTIPLEXER_DX is
    Port ( 
        CLOCK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        X     : in STD_LOGIC_VECTOR (31 downto 0);
        K     : in STD_LOGIC_VECTOR (2 downto 0);
        Y     : out STD_LOGIC_VECTOR (31 downto 0)
    );
end MULTIPLEXER_DX;

architecture behavior of MULTIPLEXER_DX is begin
	process(CLOCK, RESET) begin
	 
			if RESET = '1' then
				Y <= (others => '0');
    
			elsif rising_edge(CLOCK) then 

            case K is
                when "000" =>
                    Y <= X;
                when "001" =>
                    Y <= '0' & X(0 to 30);
                when "010" =>
                    Y <= "00" & X(0 to 29);
                when "011" =>
                    Y <= "000" & X(0 to 28);
                when "100" =>
                    Y <= "0000" & X(0 to 27);
                when "101" =>
                    Y <= "00000" & X(0 to 26);
                when "110" =>
                    Y <= "000000" & X(0 to 25);
                when "111" =>
                    Y <= "0000000" & X(0 to 24);
                when others =>
                    Y <= (others => '0'); 
            end case;
        end if;
    end process;
end behavior;