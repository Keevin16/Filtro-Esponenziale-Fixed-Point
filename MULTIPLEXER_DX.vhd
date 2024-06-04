library ieee;
use ieee.std_logic_1164.all;

entity MULTIPLEXER_SX is
    Port ( 
        CLOCK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        X     : in STD_LOGIC_VECTOR 	(31 downto 0);
        K     : in STD_LOGIC_VECTOR 	(2 downto  0) ;
        Y     : out STD_LOGIC_VECTOR 	(31 downto 0)
    );
end MULTIPLEXER_SX;

architecture behavior of MULTIPLEXER_SX is begin
	process(CLOCK, RESET) begin
	 
			if RESET = '1' then
				Y <= (others => '0');
    
			elsif rising_edge(CLOCK) then 
				case K is
					when "000" =>
                   Y <= X;
               when "001" =>
                   Y <= X(1 to 31) & '0';
               when "010" =>
                   Y <= X(2 to 31) & "00";
               when "011" =>
                   Y <= X(3 to 31) & "000";
               when "100" =>
                   Y <= X(4 to 31) & "0000";
               when "101" =>
                   Y <= X(5 to 31) & "00000";
               when "110" =>
                   Y <= X(6 to 31) & "000000";
               when "111" =>
                   Y <= X(7 to 31) & "0000000";
                when others =>
                   Y <= (others => '0'); 
				end case;
        end if;
    end process;
end behavior;	