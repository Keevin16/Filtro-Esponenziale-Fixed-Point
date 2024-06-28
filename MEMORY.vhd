-------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity MEMORY is
	generic(
		WIDTH : Integer :=32
	);
   port (
        CLOCK, RESET : in std_logic;
        Y : in std_logic_vector(WIDTH-1 downto 0);
        Q : out std_logic_vector(WIDTH-1 downto 0)
   );
end MEMORY;

architecture behavior of MEMORY is
    signal FF_D:std_logic_vector(WIDTH-1 downto 0);
    
    component FLIP_FLOP_D
        port (
            D, CLOCK: in std_logic;
            Q : out std_logic
        );
    end component;
    
begin
   FFs: for I in 0 to WIDTH-1 generate
        FF_D_Instance: FLIP_FLOP_D
            port map(
                D => FF_D(I),
                CLOCK => CLOCK,
                Q => Q(I)
            );
    end generate;   
	process(CLOCK, RESET) begin
        
		  if RESET = '1' then
            FF_D <= (others => '0');
		 
		  elsif rising_edge(CLOCK) then
            FF_D <= Y;     
        end if;
    end process;
   
    
end behavior;