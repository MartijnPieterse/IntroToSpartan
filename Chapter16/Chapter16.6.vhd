library ieee;
use ieee.std_logic_1164.all;

entity Sound is
    Port ( clk   : in STD_LOGIC;
           LEDs  : out STD_LOGIC_VECTOR (7 downto 0);
           audio : out STD_LOGIC
    );
end Sound;

architecture Behavioral of Sound is
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

    COMPONENT dac8
      PORT (
        Clk         : in STD_LOGIC;
        Data        : in STD_LOGIC_VECTOR (7 downto 0);
        PulseStream : out STD_LOGIC
      );
    END COMPONENT;


    signal count   : STD_LOGIC_VECTOR(29 downto 0);
    signal snddata : STD_LOGIC_VECTOR(7 downto 0);
begin

    addr_counter : counter30
      PORT MAP (
        clk => clk,
        q => count
      );

    -- The sine contains 1024 values
    -- The desired frequence is 1000Hz
    -- The clock = 32MHz
    -- 32000000 / 1000 = 32000
    -- Closest value is 32767, thus we use bits (14 downto 5)
    --
    -- Highest frequence possible is 31250Hz.
    rom_memory: memory
      PORT MAP (
        clka => clk,
        addra => count(14 downto 5),
        douta => snddata
      );

    dac: dac8
      PORT MAP (
        Clk => clk,
        Data => snddata,
        PulseStream => audio
      );

    -- This does not really show anything. :-)
    LEDs <= snddata;

end Behavioral;
