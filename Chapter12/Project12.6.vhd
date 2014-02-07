library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BinaryUpCounter is
        Port ( 
        SwitchOn    : in  STD_LOGIC;
        SwitchReset : in  STD_LOGIC;
        LEDs     : out UNSIGNED(0 to 7);
        clk      : in  STD_LOGIC
    );
end BinaryUpCounter;

architecture Behavioral of BinaryUpCounter is
    signal counter : UNSIGNED(7 downto 0) := (others => '0');
    signal seconds : UNSIGNED(7 downto 0) := (others => '0');
begin
    clk_proc: process(clk)
    begin
        if rising_edge(clk) then
            if SwitchOn = '1' then
                counter <= counter + 1;
            end if;

            if SwitchReset = '1' then
                counter <= "00000000";
            end if;
            
            if counter = 133 then
                counter <= "00000000";
                seconds <= seconds + 1;
            end if;
        end if;

    end process;

    LEDs <= counter(7 downto 0);

end Behavioral;

