library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AndOrOperation is
    Port ( switch_1 : in STD_LOGIC;
           switch_2 : in STD_LOGIC;
           LED_0    : out STD_LOGIC;
           LED_1    : out STD_LOGIC);
end AndOrOperation;

architecture Behavioral of AndOrOperation is
begin
    LED_0 <= switch_1 AND switch_2;
    LED_1 <= switch_1 OR  switch_2;
end Behavioral;
