library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Communicate is
    port (
        clk    : in  std_logic;
        SWITCH : in std_logic_vector(3 downto 0);
        tx     : out std_logic
    );
end Communicate;

architecture behavioral of Communicate is

    signal tx_d      : unsigned(15 downto 0) := "1111111010000010"; -- A 0100 0001
    signal char      : unsigned(7 downto 0) := "01000001";
    signal charcount : unsigned(4 downto 0) := "00000";
    signal count     : unsigned(11 downto 0) := (others => '0');

begin

    tx <= tx_d(0);

    char(3 downto 0) <= unsigned(SWITCH(3 downto 0));

    transmit: process(clk)
    begin
        if rising_edge(clk) then
            if count = 3332 then
                count <= (others => '0');
                tx_d <= '1' & tx_d(15 downto 1);
                charcount <= charcount + 1;

                if charcount = 15 then
                    charcount <= (others => '0');
                    tx_d(15 downto 13) <= "010";
                    tx_d(12 downto 8) <= "00001" + ('0' & char(3 downto 0));
                    tx_d(7) <= '0';
                end if;
            else
                count <= count + 1;
            end if;
        end if;
    end process;

end behavioral;

