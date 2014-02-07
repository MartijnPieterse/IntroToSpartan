library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SecondsCounter is
        Port ( 
        Switch   : in  STD_LOGIC;
        LEDs     : out UNSIGNED(0 to 7);
        clk      : in  STD_LOGIC
    );
end SecondsCounter;

architecture Behavioral of SecondsCounter is
    signal counter   : UNSIGNED(29 downto 0) := (others => '0');
    signal seconds   : UNSIGNED(7 downto 0) := (others => '0');
    signal direction : STD_LOGIC;
begin
    clk_proc: process(clk)
    begin
        if rising_edge(clk) then
            counter <= counter + 1;

            -- According to the docs the clock runs at 32Mhz. So this should be good.
            if counter = 32000000 then
                counter <= "000000000000000000000000000000";
                seconds <= seconds + 1;
            end if;
        end if;
    end process;

    LEDs <= seconds;

end Behavioral;

