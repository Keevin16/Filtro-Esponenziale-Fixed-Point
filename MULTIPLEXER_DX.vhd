library ieee;
use ieee.std_logic_1164.all;

entity MULTIPLEXER_SX is
    Port ( 
        X     : in std_logic_vector 	(31 downto 0);
        K     : in std_logic_vector 	(2 downto  0);
        Y     : out std_logic_vector 	(31 downto 0)
    );
end MULTIPLEXER_SX;

architecture behavior of MULTIPLEXER_SX is 

signal MSB : std_logic;
begin 
	MSB <= X(31);

    process(X, K, MSB) begin
        case K is
            when "000" =>		Y <=  X;
            when "001" =>		Y <=  MSB & 													X(31 downto 1);
            when "010" =>		Y <= (MSB & MSB) & 											X(31 downto 2);
            when "011" =>		Y <= (MSB & MSB & MSB) &	 								X(31 downto 3);
            when "100" =>		Y <= (MSB & MSB & MSB & MSB) &							X(31 downto 4);
            when "101" =>		Y <= (MSB & MSB & MSB & MSB & MSB) &  					X(31 downto 5);
            when "110" =>		Y <= (MSB & MSB & MSB & MSB & MSB & MSB) & 			X(31 downto 6);
            when "111" =>		Y <= (MSB & MSB & MSB & MSB & MSB & MSB & MSB) &	X(31 downto 7);
            when others =>		Y <= (others => '0');
        end case;
    end process;
end behavior;	