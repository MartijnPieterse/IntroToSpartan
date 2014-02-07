-- Max speed is 2.134 for "-3"
-- Max speed is 2.477 for "-2"

-- Aim for 500MHz
--  Split at 15:15:
--      2[ns] could not be met. 2.025 is OK, giving 493.827Mhz. 
--      It could go to 2.022[ns] or 494.559Mhz
--  Split at 14:16
--      2.020[ns].
--      This should not be better? I don't know...
--  Split at 16:14
--      2.102[ns]??
--
-- Largest counter at 100Mhz is 315 bits.
-- I did not attempt to break it up in 2 or 4 or more parts.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LargestCounter is
        Port ( 
        LEDs     : out UNSIGNED(0 to 7);
        clk      : in  STD_LOGIC
    );
end LargestCounter;

architecture Behavioral of LargestCounter is
    signal counter     : UNSIGNED(315 downto 0) := (others => '0');
begin
    clk_proc: process(clk)
    begin
        if rising_edge(clk) then
            counter(315 downto 0) <= counter(315 downto 0) + 1;
        end if;

    end process;

    LEDs <= counter(315 downto 308);

end Behavioral;

