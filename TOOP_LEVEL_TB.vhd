--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:26:12 06/25/2024
-- Design Name:   
-- Module Name:   /home/dracarys/Desktop/Filtro-Esponenziale-Fixed-Point/TOOP_LEVEL_TB.vhd
-- Project Name:  Filtro-Fixed-Point
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TOP_LEVEL
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TOOP_LEVEL_TB IS
END TOOP_LEVEL_TB;
 
ARCHITECTURE behavior OF TOOP_LEVEL_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOP_LEVEL
    PORT(
         X : IN  std_logic_vector(31 downto 0);
         K : IN  std_logic_vector(2 downto 0);
         CLOCK : IN  std_logic;
         RESET : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(31 downto 0) := (others => '0');
   signal K : std_logic_vector(2 downto 0) := (others => '0');
   signal CLOCK : std_logic := '0';
   signal RESET : std_logic := '0';

   -- Clock period definitions
   constant CLOCK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TOP_LEVEL PORT MAP (
          X => X,
          K => K,
          CLOCK => CLOCK,
          RESET => RESET
        );

   -- Clock process definitions
   CLOCK_process :process
   begin
		CLOCK <= '0';
		wait for CLOCK_period/2;
		CLOCK <= '1';
		wait for CLOCK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLOCK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
