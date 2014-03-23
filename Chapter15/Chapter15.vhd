library ieee;
use ieee.std_logic_1164.all;

entity FlashyLights is
    Port ( clk  : in STD_LOGIC;
           LEDs : out STD_LOGIC_VECTOR (7 downto 0)
    );
end FlashyLights;

architecture Behavioral of FlashyLights is
    COMPONENT counter30
      PORT (
        clk : IN STD_LOGIC;
        q : OUT STD_LOGIC_VECTOR(29 DOWNTO 0)
      );
    END COMPONENT;

    COMPONENT memory
      PORT (
        clka : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
    END COMPONENT;

    signal count : STD_LOGIC_VECTOR(29 downto 0);
begin

    addr_counter : counter30
      PORT MAP (
        clk => clk,
        q => count
      );

    rom_memory: memory
      PORT MAP (
        clka => clk,
        addra => count(29 downto 20),
        douta => LEDs
      );
end Behavioral;
