-- Max speed is 2.134 for "-3"
-- Max speed is 2.477 for "-2"

-- Aim for 500MHz
--  Split at 15:15:
--      2[ns] could not be met. 2.025 is OK, giving 493.827Mhz. 
--      It could go to 2.022[ns] or 494.559Mhz

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GetMaxSpeed is
        Port ( 
        LEDs     : out UNSIGNED(0 to 7);
        clk      : in  STD_LOGIC
    );
end GetMaxSpeed;

architecture Behavioral of GetMaxSpeed is
    signal counter     : UNSIGNED(29 downto 0) := (others => '0');
    signal incHighNext : UNSIGNED(0 downto 0) := (others => '0');
begin
    clk_proc: process(clk)
    begin
        if rising_edge(clk) then
            counter(29 downto 15) <= counter(29 downto 15) + incHighNext;

            if counter(14 downto 0) = "111111111111110" then
                incHighNext <= "1";
            else
                incHighNext <= "0";
            end if;

            counter(14 downto 0) <= counter(14 downto 0) + 1;
        end if;

    end process;

    LEDs <= counter(29 downto 22);

end Behavioral;

