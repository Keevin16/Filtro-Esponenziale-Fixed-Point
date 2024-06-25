library ieee;
use ieee.std_logic_1164.all;

entity MULTIPLEXER_DX is
   Port ( 
       CLOCK : in std_logic;
       RESET : in std_logic;
       X     : in std_logic_vector 	(31 downto 0);
       K     : in std_logic_vector 	(2 downto 0);
       Y     : out std_logic_vector	(31 downto 0)
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
                   Y <= '0' & 		X(31 downto 1);
              when "010" =>
                   Y <= "00" & 		X(31 downto 2);
               when "011" =>
                   Y <= "000" & 		X(31 downto 3);
               when "100" =>
                   Y <= "0000" & 	X(31 downto 4);
               when "101" =>
                   Y <= "00000" & 	X(31 downto 5);
               when "110" =>
                   Y <= "000000" & 	X(31 downto 6);
               when "111" =>
                   Y <= "0000000" & X(31 downto 7);
               when others =>
                   Y <= (others => '0'); 
           end case;
       end if;
   end process;
end behavior;