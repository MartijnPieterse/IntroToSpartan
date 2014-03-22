library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SegmentDisplay is
        Port ( 
        switch   : in  UNSIGNED(0 to 3);
        sdAN     : out UNSIGNED(0 to 3);
        sdSeg    : out STD_LOGIC_VECTOR(0 to 6)
    );
end SegmentDisplay;

architecture Behavioral of SegmentDisplay is
    signal counter : UNSIGNED(1 downto 0) := (others => '0');
begin
    
    my_p: process(switch)
    begin
        CASE switch(0 to 3) IS
            WHEN "0000" =>
                sdSeg <= "0000001";
            WHEN "0001" =>
                sdSeg <= "1001111";
            WHEN "0010" =>
                sdSeg <= "0010010";
            WHEN "0011" =>
                sdSeg <= "0000110";
            WHEN "0100" =>
                sdSeg <= "1001100";
            WHEN "0101" =>
                sdSeg <= "0100100";
            WHEN "0110" =>
                sdSeg <= "0100000";
            WHEN "0111" =>
                sdSeg <= "0001111";
            WHEN "1000" =>
                sdSeg <= "0000000";
            WHEN "1001" =>
                sdSeg <= "0000100";
            WHEN "1010" =>
                sdSeg <= "0001000";
            WHEN "1011" =>
                sdSeg <= "1100000";
            WHEN "1100" =>
                sdSeg <= "0110001";
            WHEN "1101" =>
                sdSeg <= "1000010";
            WHEN "1110" =>
                sdSeg <= "0110000";
            WHEN "1111" =>
                sdSeg <= "0111000";
            WHEN OTHERS =>
                sdSeg <= "0110111";
        END CASE;
    end process;

    sdAN <= "0000";

end Behavioral;

