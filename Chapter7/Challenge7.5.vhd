library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OperatorsFromOthers is
    Port ( switch_0 : in STD_LOGIC;
           switch_1 : in STD_LOGIC;
           LED_0    : out STD_LOGIC;
           LED_1    : out STD_LOGIC;
           LED_2    : out STD_LOGIC;
           LED_3    : out STD_LOGIC;
           LED_4    : out STD_LOGIC;
           LED_5    : out STD_LOGIC;
           LED_6    : out STD_LOGIC;
           LED_7    : out STD_LOGIC);
end OperatorsFromOthers;

architecture Behavioral of OperatorsFromOthers is
begin
    -- LED 0: Will be on when switch 0 is off, and switch 1 is ON
    LED_0 <= NOT(switch_0) AND switch_1;

    -- LED 1: The AND operator
    LED_1 <= switch_0 AND switch_1;

    -- LED 2: The AND operator made from OR and NOT
    LED_2 <= NOT ( (NOT switch_0) OR (NOT switch_1) );

    -- LED 3: The OR operator
    LED_3 <= switch_0 OR switch_1;

    -- LED 4: The OR operator made from only NOR
    LED_4 <= (switch_0 NOR switch_1) NOR (switch_0 NOR switch_1);

    -- LED 5: XOR using only AND, OR and NOT.
    LED_5 <= (switch_0 OR switch_1) AND NOT (switch_0 AND switch_1);

    -- LED 6: AND using only XOR ---> Not possible!
    LED_6 <= '1';

    -- LED 7: OR using only XOR  ---> Not possible!
    LED_7 <= '0';
end Behavioral;
