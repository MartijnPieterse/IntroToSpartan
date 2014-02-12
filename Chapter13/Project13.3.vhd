library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity UseModule is
        Port ( 
        SwitchC1 : in  STD_LOGIC;
        SwitchC2 : in  STD_LOGIC;
        LEDs     : out STD_LOGIC_VECTOR(0 to 7);
        clk      : in  STD_LOGIC
    );
end UseModule;

architecture Behavioral of UseModule is
    signal counter1  : STD_LOGIC_VECTOR(29 downto 0) := (others => '0');
    signal counter2  : STD_LOGIC_VECTOR(29 downto 0) := (others => '0');

    COMPONENT counter30
    PORT(
        clk : IN std_logic;
        enable : IN std_logic;          
        count : OUT std_logic_vector(29 downto 0)
    );
    END COMPONENT;

begin
    Inst_counter30_1: counter30 PORT MAP(
        clk => clk,
        enable => SwitchC1,
        count => counter1
    );
    Inst_counter30_2: counter30 PORT MAP(
        clk => clk,
        enable => SwitchC2,
        count => counter2
    );

    LEDs(0 to 3) <= counter1(29 downto 26);
    LEDS(4 to 7) <= counter2(29 downto 26);

end Behavioral;
