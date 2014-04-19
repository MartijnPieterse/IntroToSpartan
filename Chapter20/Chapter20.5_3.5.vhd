library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Communicate is
    port (
        clk    : in  std_logic;
        SWITCH : in unsigned(3 downto 0);
        JOY_SELECT : in std_logic;
        tx     : out std_logic
    );
end Communicate;

architecture behavioral of Communicate is

    signal tx_d      : unsigned(10 downto 0) := "11111111111";
    signal count     : unsigned(11 downto 0) := (others => '0');

begin

    tx <= tx_d(0);

    transmit: process(clk)
    begin
        if rising_edge(clk) then
            if count = 3332 then
                count <= (others => '0');
                tx_d <= '1' & tx_d(10 downto 1);
            else
                count <= count + 1;
            end if;

            if rising_edge(JOY_SELECT) then
                if tx_d = "11111111111" then
                    tx_d(9 downto 7) <= "010";
                    tx_d(6 downto 2) <= "00001" + ('0' & SWITCH(3 downto 0));
                    tx_d(1) <= '0';                                             -- Startbit
                end if;
            end if;
        end if;
    end process;

end behavioral;

