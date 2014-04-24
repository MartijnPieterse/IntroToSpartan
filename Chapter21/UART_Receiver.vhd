library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UART_Receiver is
    port (
        clk     : in  std_logic;
        rx      : in  std_logic;
        DAv     : out std_logic;
        data    : out std_logic_vector(7 downto 0)
    );
end UART_Receiver;


architecture behavioral of UART_Receiver is

    signal  rx_buffer   : std_logic_vector(39 downto 0) := (others => '1');
    signal  counter     : unsigned(9 downto 0) := (others => '0');
    signal  valid       : std_logic := '0';
    signal  value       : std_logic_vector(7 downto 0) := (others => '0');
    signal  avail       : std_logic := '0';

begin

    data <= value;
    DAv <= avail;

    receive: process(clk)
    begin
        if rising_edge(clk) then
            if counter = 833 then
                rx_buffer <= rx & rx_buffer(39 downto 1);
                counter <= (others => '0');

                avail <= '0';

                valid <=  rx_buffer(38) and rx_buffer(37) and 
                         (rx_buffer(34) xnor rx_buffer(33)) and
                         (rx_buffer(30) xnor rx_buffer(29)) and
                         (rx_buffer(26) xnor rx_buffer(25)) and
                         (rx_buffer(22) xnor rx_buffer(21)) and
                         (rx_buffer(18) xnor rx_buffer(17)) and
                         (rx_buffer(14) xnor rx_buffer(13)) and
                         (rx_buffer(10) xnor rx_buffer(9)) and
                         (rx_buffer(6) xnor rx_buffer(5)) and
                         (not rx_buffer(2) and not rx_buffer(1));
            else
                counter <= counter + 1;
            end if;

            if valid = '1' then
                value <= rx_buffer(34) & rx_buffer(30) & rx_buffer(26) & rx_buffer(22) & 
                         rx_buffer(18) & rx_buffer(14) & rx_buffer(10) & rx_buffer(6);

                valid <= '0';
                rx_buffer <= (others => '1');

                avail <= '1';
            end if;
        end if;
    end process;

end behavioral;
