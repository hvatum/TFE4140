LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test_ab_latch IS
END test_ab_latch;
 
ARCHITECTURE behavior OF test_ab_latch IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ab_latch
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         Q : OUT  std_logic;
         QN : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := 'U';
   signal B : std_logic := 'U';

 	--Outputs
   signal Q : std_logic;
   signal QN : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ab_latch PORT MAP (
          A => A,
          B => B,
          Q => Q,
          QN => QN
        );

   -- Stimulus process
   stim_proc: process
   begin
		wait for 100 ns;
		A <= '1' ; B <= '0' ;
		wait for 10 ns ;
		A <= '0' ;
		wait for 10 ns ;
		B <= '1' ;
		wait for 10 ns ;
		B <= '0' ;
		wait for 10 ns ;
		B <= '1' ; A <= '1' ;
   end process;

END;
