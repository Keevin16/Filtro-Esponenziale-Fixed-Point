library ieee;
use ieee.std_logic_1164.all;

entity MULTIPLEXER_SX is
    Port ( 
        X     : in STD_LOGIC_VECTOR 	(31 downto 0);
        K     : in STD_LOGIC_VECTOR 	(2 downto  0) ;
        Y     : out STD_LOGIC_VECTOR 	(31 downto 0)
    );
end MULTIPLEXER_SX;

architecture behavior of MULTIPLEXER_SX is begin
    process(X, K) 
    begin
        case K is
            when "000" =>		Y <= X;
            when "001" =>		Y <= '0' & 				X(31 downto 1);
            when "010" =>		Y <= "00" & 			X(31 downto 2);
            when "011" =>		Y <= "000" &	 		X(31 downto 3);
            when "100" =>		Y <= "0000" & 			X(31 downto 4);
            when "101" =>		Y <= "00000" & 		X(31 downto 5);
            when "110" =>		Y <= "000000" & 		X(31 downto 6);
            when "111" =>		Y <= "0000000" & 		X(31 downto 7);
            when others =>		Y <= (others => '0');
        end case;
    end process;
end behavior;	