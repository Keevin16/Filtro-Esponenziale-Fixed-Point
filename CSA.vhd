library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CSA is
    port(
        A : in std_logic_vector 	(31 downto 0);
        B : in std_logic_vector 	(31 downto 0);
        C : in std_logic_vector 	(31 downto 0);
        Z : out std_logic_vector (31 downto 0)
    );
end CSA;

architecture Behavioral of CSA is
    signal CS  : std_logic_vector (31 downto 0);
    signal T   : std_logic_vector (31 downto 0);
    signal C_IN: std_logic_vector (32 downto 0); 

    component FA is 
        port(
            X     : in  std_logic;  
            Y     : in  std_logic;  
            CIN   : in  std_logic;  
            S     : out std_logic;  
            COUT  : out std_logic 
        );
    end component;

begin
    carrySave : for K in 0 to 31 generate
        carrySaveInstance : FA
            port map(
                X => A(K),
                Y => B(K),
                CIN => C(K),
                COUT => CS(K),
                S => T(K)
            );
    end generate carrySave;
    
    fullAdder : for I in 0 to 30 generate
        faInstance : FA
            port map(
                X => CS(I),
                Y => T(I+1),
                CIN => C_IN(I),
                COUT => C_IN(I+1),
                S => Z(I+1)
            );
    end generate fullAdder;
    
    lastFa : FA
        port map(
            X => CS(31),
            Y => '0',
            CIN => C_IN(31),
            S => Z(31),
            COUT => open
        );

    C_IN(0) <= '0';
    Z(0) <= T(0);

end Behavioral;