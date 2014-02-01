library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VariousOperations is
    Port ( switch_1 : in STD_LOGIC;
           switch_2 : in STD_LOGIC;
           LED_0    : out STD_LOGIC;
           LED_1    : out STD_LOGIC;
           LED_2    : out STD_LOGIC;
           LED_3    : out STD_LOGIC;
           LED_4    : out STD_LOGIC;
           LED_5    : out STD_LOGIC;
           LED_6    : out STD_LOGIC);
end VariousOperations;

architecture Behavioral of VariousOperations is
begin
    LED_0 <= switch_1 AND switch_2;
    LED_1 <= switch_1 OR  switch_2;
    LED_2 <= switch_1 NAND switch_2;
    LED_3 <= NOT(switch_1 AND switch_2);
    LED_4 <= NOT(switch_1) OR NOT(switch_2);
    LED_5 <= NOT(switch_1);
    LED_6 <= switch_1 XOR switch_2;
end Behavioral;
