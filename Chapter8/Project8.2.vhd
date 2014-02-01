library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IntroducingBuses is
    Port ( switches : in STD_LOGIC_VECTOR(7 downto 0);
           LEDs     : out STD_LOGIC_VECTOR(7 downto 0));
end IntroducingBuses;


architecture Behavioral of IntroducingBuses is
begin
    LEDs(7 downto 4) <= switches(7 downto 4) OR switches(3 downto 0);
    LEDs(3 downto 0) <= switches(7 downto 4) AND switches(3 downto 0);
end Behavioral;
