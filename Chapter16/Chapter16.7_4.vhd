-- Copy from 7.2, use switches to set volume.

library ieee;
use ieee.std_logic_1164.all;

entity Volume is
    Port ( clk   : in STD_LOGIC;
           switches : in STD_LOGIC_VECTOR(7 downto 0);
           audio : out STD_LOGIC
    );
end Volume;

architecture Behavioral of Volume is
    COMPONENT freq11kHz
      PORT (
        clk : IN STD_LOGIC;
        outp : OUT STD_LOGIC_VECTOR(15 downto 0)
      );
    END COMPONENT;

    COMPONENT memory
      PORT (
        clka : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
    END COMPONENT;

    COMPONENT dac16
      PORT (
        Clk         : in STD_LOGIC;
        Data        : in STD_LOGIC_VECTOR (15 downto 0);
        PulseStream : out STD_LOGIC
      );
    END COMPONENT;


    signal count   : STD_LOGIC_VECTOR(15 downto 0);
    signal snddata : STD_LOGIC_VECTOR(7 downto 0);
    signal sndwd   : STD_LOGIC_VECTOR(15 downto 0);
begin

    addr_counter : freq11kHz
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

    process (snddata, switches)
    begin
        case switches(2 downto 0) is
            when "000" =>
                sndwd <= snddata & "00000000";
            when "001" =>
                sndwd <= "0" & snddata & "0000000";
            when "010" =>
                sndwd <= "00" & snddata & "000000";
            when "011" =>
                sndwd <= "000" & snddata & "00000";
            when "100" =>
                sndwd <= "0000" & snddata & "0000";
            when "101" =>
                sndwd <= "00000" & snddata & "000";
            when "110" =>
                sndwd <= "000000" & snddata & "00";
            when "111" =>
                sndwd <= "0000000" & snddata & "0";
            when others =>
                sndwd <= "00000000" & snddata;
        end case;
    end process;

    dac: dac16
      PORT MAP (
        Clk => clk,
        Data => sndwd,
        PulseStream => audio
      );

end Behavioral;
