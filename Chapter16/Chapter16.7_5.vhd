-- Copy from 7.4, 16 bit sample

library ieee;
use ieee.std_logic_1164.all;

entity Sample16 is
    Port ( clk   : in STD_LOGIC;
           audio : out STD_LOGIC
    );
end Sample16;

architecture Behavioral of Sample16 is
    COMPONENT freq44kHz
      PORT (
        clk : IN STD_LOGIC;
        outp : OUT STD_LOGIC_VECTOR(14 downto 0)
      );
    END COMPONENT;

    COMPONENT memory
      PORT (
        clka : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
      );
    END COMPONENT;

    COMPONENT dac16
      PORT (
        Clk         : in STD_LOGIC;
        Data        : in STD_LOGIC_VECTOR (15 downto 0);
        PulseStream : out STD_LOGIC
      );
    END COMPONENT;

    signal count   : STD_LOGIC_VECTOR(14 downto 0);
    signal snddata : STD_LOGIC_VECTOR(15 downto 0);
begin

    addr_counter : freq44kHz
      PORT MAP (
        clk => clk,
        outp => count
      );

    rom_memory: memory
      PORT MAP (
        clka => clk,
        addra => count,
        douta => snddata
      );

    dac: dac16
      PORT MAP (
        Clk => clk,
        Data => snddata,
        PulseStream => audio
      );

end Behavioral;
