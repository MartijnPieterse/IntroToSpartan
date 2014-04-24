library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Als WEn == 1, dan is er data.
-- Zolang we sturen is busy 1
-- clk = 32Mhz
-- protocol = 9600 8N1, lekker flexibel

entity UART_Transmitter is
    port (
        clk     : in  std_logic;
        tx      : out std_logic;
        WEn     : in  std_logic;
        data    : in  std_logic_vector(7 downto 0);
        busy    : out std_logic
    );
end UART_Transmitter;

architecture behavioral of UART_Transmitter is

    signal  tx_buffer : std_logic_vector(9 downto 0) := (others => '1');
    signal  tx_busy   : std_logic_vector(9 downto 0) := (others => '0');
    signal  counter   : unsigned(11 downto 0) := (others => '0');

begin
    tx <= tx_buffer(0);
    busy <= tx_busy(0);

    transmit: process(clk)
    begin
        if rising_edge(clk) then
            if tx_busy(0) = '1' then
                if counter = 3332 then
                    tx_buffer <= '1' & tx_buffer(9 downto 1);
                    tx_busy   <= '0' & tx_busy(9 downto 1);
                    counter <= (others => '0');
                else
                    counter <= counter + 1;
                end if;
            else
                if WEn = '1' then
                    tx_buffer(8 downto 1) <= data(7 downto 0);
                    tx_buffer(0) <= '0';
                    tx_busy <= (others => '1');
                    counter <= (others => '0'); -- hoeft misschien niet
                end if;
            end if;
        end if;
    end process;

end behavioral;
