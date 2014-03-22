library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SegmentDisplay2 is
        Port ( 
        switch1  : in  UNSIGNED(0 to 3);
        switch2  : in  UNSIGNED(0 to 3);
        sdAN     : out UNSIGNED(0 to 3);
        sdSeg    : out STD_LOGIC_VECTOR(0 to 6);
        clk      : in  STD_LOGIC
    );
end SegmentDisplay2;

architecture Behavioral of SegmentDisplay2 is
    signal counter : UNSIGNED(29 downto 0) := (others => '0');
    signal clockdiv : UNSIGNED(29 downto 0) := (others => '0');
    signal w       : UNSIGNED(0 to 1) := (others => '0');
    signal swp     : UNSIGNED(0 to 3) := (others => '0');
begin
    
    clk_proc: process(clk)
    begin
        if rising_edge(clk) then

            counter <= counter + 1;

            clockdiv <= clockdiv + 1;

            if clockdiv = 32000 then
                clockdiv <= "000000000000000000000000000000";
                w <= w + 1;
            end if;


            CASE w(0 to 1) IS
                WHEN "00" =>
                    swp <= counter(29 downto 26);
                    sdAN <= "0111";
                WHEN "01" =>
                    swp <= counter(25 downto 22);
                    sdAN <= "1011";
                WHEN "10" =>
                    swp <= counter(21 downto 18);
                    sdAN <= "1101";
                WHEN "11" =>
                    swp <= counter(17 downto 14);
                    sdAN <= "1110";
                WHEN OTHERS =>
                    sdAN <= "1111";
            END CASE;


            CASE swp(0 to 3) IS
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
                    sdSeg <= "0110110";
            END CASE;

        end if;
    end process;

end Behavioral;

