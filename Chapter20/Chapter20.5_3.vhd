library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Communicate is
    port (
        clk    : in  std_logic;
        SWITCH : in unsigned(3 downto 0);
        tx     : out std_logic
    );
end Communicate;

architecture behavioral of Communicate is

    signal tx_d      : unsigned(9 downto 0) := "1111111111";
    signal char      : unsigned(4 downto 0) := "10000";        -- Copy of previous state of the switches.
    signal count     : unsigned(11 downto 0) := (others => '0');

begin

    tx <= tx_d(0);

    transmit: process(clk)
    begin
        if rising_edge(clk) then
            if count = 3332 then
                count <= (others => '0');
                tx_d <= '1' & tx_d(9 downto 1);

                if tx_d = "1111111111" then
                    if char(4 downto 0) /= ('0' & SWITCH(3 downto 0)) then
                        char(4 downto 0) <= ('0' & SWITCH(3 downto 0));
                        tx_d(8 downto 6) <= "010";
                        tx_d(5 downto 1) <= "00001" + ('0' & SWITCH(3 downto 0));
                        tx_d(0) <= '0';                                             -- Startbit
                    end if;
                end if;
            else
                count <= count + 1;
            end if;
        end if;
    end process;

end behavioral;

