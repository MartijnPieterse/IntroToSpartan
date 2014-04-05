library ieee;
use ieee.std_logic_1164.all;

entity Waveform is
    Port ( clk   : in STD_LOGIC;
           switches : in STD_LOGIC_VECTOR (1 downto 0);
           audio : out STD_LOGIC
    );
end Waveform;

architecture Behavioral of Waveform is
    COMPONENT counter30
      PORT (
        clk : IN STD_LOGIC;
        q : OUT STD_LOGIC_VECTOR(29 downto 0)
      );
    END COMPONENT;

    COMPONENT memory
      PORT (
        clka : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
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

    rom_memory: memory
      PORT MAP (
        clka => clk,
        addra => switches & count(14 downto 5),
        douta => snddata
      );

    dac: dac8
      PORT MAP (
        Clk => clk,
        Data => snddata,
        PulseStream => audio
      );

end Behavioral;
