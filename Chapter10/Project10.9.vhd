library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BinaryUpDownCounter is
        Port ( 
        Switch   : in  STD_LOGIC;
        LEDs     : out UNSIGNED(0 to 7);
        clk      : in  STD_LOGIC
    );
end BinaryUpDownCounter;

architecture Behavioral of BinaryUpDownCounter is
    signal counter   : UNSIGNED(29 downto 0) := (others => '0');
    signal direction : STD_LOGIC;
begin
    clk_proc: process(clk)
    begin
        if rising_edge(clk) then
            direction <= '1';
            if Switch = '0' then
                direction <= '0';
            end if;

            if direction = '1' then
                counter <= counter + 1;
            else
                counter <= counter - 1;
            end if;
        end if;

    end process;

    LEDs <= counter(29 downto 22);

end Behavioral;

