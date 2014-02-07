library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BinaryUpCounter is
        Port ( 
        LEDs     : out UNSIGNED(0 to 7);
        clk      : in  STD_LOGIC
    );
end BinaryUpCounter;

architecture Behavioral of BinaryUpCounter is
    signal counter : UNSIGNED(29 downto 0) := (others => '0');
begin
    clk_proc: process(clk)
    begin
        if rising_edge(clk) then
            counter <= counter+1;
        end if;

    end process;

    LEDs <= counter(29 downto 22);

end Behavioral;

