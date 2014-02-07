library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SwitchOnCounter is
        Port ( 
        SwitchOn    : in  STD_LOGIC;
        SwitchReset : in  STD_LOGIC;
        LEDs        : out UNSIGNED(0 to 7);
        clk         : in  STD_LOGIC
    );
end SwitchOnCounter;

architecture Behavioral of SwitchOnCounter is
    signal counter   : UNSIGNED(24 downto 0) := (others => '0');    -- 32000000 fits in 25 bits.
    signal seconds   : UNSIGNED(7 downto 0) := (others => '0');
    signal direction : STD_LOGIC;
begin
    clk_proc: process(clk)
    begin
        if rising_edge(clk) then
            if SwitchOn = '1' then
                counter <= counter + 1;
            end if;

            if SwitchReset = '1' then
                counter <= "0000000000000000000000000";
                seconds <= "00000000";
            end if;

            -- According to the docs the clock runs at 32Mhz. So this should be good.
            if counter = 32000000 then
                counter <= "0000000000000000000000000";
                seconds <= seconds + 1;
            end if;
        end if;
    end process;

    LEDs <= seconds;

end Behavioral;

