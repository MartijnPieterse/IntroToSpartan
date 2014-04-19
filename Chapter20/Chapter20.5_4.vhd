library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Communicate is
    port (
        clk    : in  std_logic;
        SWITCH : in unsigned(7 downto 0);
        JOY_SELECT : in std_logic;
        tx     : out std_logic
    );
end Communicate;

-- 0 == 0011 0000
-- 1 == 0011 0001
-- \n == 0000 1010

architecture behavioral of Communicate is

    signal pinchar   : unsigned(6 downto 0) := "0011000";
    signal tx_d      : unsigned(89 downto 0) := (others => '1');
    signal count     : unsigned(11 downto 0) := (others => '0');
    signal bits      : unsigned(6 downto 0) := (others => '0');
    signal once      : std_logic := '0';
    signal pressed   : std_logic := '0';

begin
    tx <= tx_d(0);

    transmit: process(clk)
    begin
        if rising_edge(clk) then

            -- Note: This causes problems with switch-bouncing... will not solve this now.
            --       Probably some unit has to be made that samples the switch with 32MHz,
            --       but outputs with like 1kHz or something. Then taking the average 
            --       or anything could solve this problem. (TODO :-) )
            if JOY_SELECT = '0' then
                if once = '0' then
                    once <= '1';
                    pressed <= '1';
                end if;
            else
                once <= '0';
            end if;



            if count = 3332 then
                count <= (others => '0');
                tx_d <= '1' & tx_d(89 downto 1);
                if bits /= 0 then
                    bits <= bits - 1;
                end if;

                if pressed = '1' then
                    if bits = 0 then
                        tx_d(8 downto 2) <= pinchar;
                        tx_d(1) <= SWITCH(0);
                        tx_d(0) <= '0';

                        tx_d(18 downto 12) <= pinchar;
                        tx_d(11) <= SWITCH(1);
                        tx_d(10) <= '0';

                        tx_d(28 downto 22) <= pinchar;
                        tx_d(21) <= SWITCH(2);
                        tx_d(20) <= '0';

                        tx_d(38 downto 32) <= pinchar;
                        tx_d(31) <= SWITCH(3);
                        tx_d(30) <= '0';

                        tx_d(48 downto 42) <= pinchar;
                        tx_d(41) <= SWITCH(4);
                        tx_d(40) <= '0';

                        tx_d(58 downto 52) <= pinchar;
                        tx_d(51) <= SWITCH(5);
                        tx_d(50) <= '0';

                        tx_d(68 downto 62) <= pinchar;
                        tx_d(61) <= SWITCH(6);
                        tx_d(60) <= '0';

                        tx_d(78 downto 72) <= pinchar;
                        tx_d(71) <= SWITCH(7);
                        tx_d(70) <= '0';

                        tx_d(88 downto 81) <= "00001010";
                        tx_d(80) <= '0';

                        pressed <= '0';
                        bits <= to_unsigned(90, 7);
                    end if;
                end if;
            else
                count <= count + 1;
            end if;
        end if;
    end process;

end behavioral;

