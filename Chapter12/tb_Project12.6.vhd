-- Originally created with the ISE.
-- But it needed some changes.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY tb_Example12_3 IS
END tb_Example12_3;
 
ARCHITECTURE behavior OF tb_Example12_3 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BinaryUpCounter
    PORT(
         SwitchOn : IN STD_LOGIC;
         SwitchReset : IN STD_LOGIC;
         LEDs : OUT  UNSIGNED(0 to 7);
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal SwitchOn : std_logic := '0';
   signal SwitchReset : std_logic := '0';

 	--Outputs
   signal LEDs : UNSIGNED(0 to 7);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BinaryUpCounter PORT MAP (
          SwitchOn => SwitchOn,
          SwitchReset => SwitchReset,
          LEDs => LEDs,
          clk => clk
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
      wait for 5 ns;
      SwitchOn <= '1';

      wait for clk_period*10;
      SwitchOn <= '0';

      wait for clk_period*10;
      SwitchReset <= '1';

      wait;
   end process;

END;
