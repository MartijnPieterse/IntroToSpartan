library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SerialReceiver is
    port (
        clk     : in  std_logic;
        rx      : in  std_logic;
        sdAN    : out std_logic_vector(3 downto 0);
        sdSeg   : out std_logic_vector(6 downto 0)
    );
end SerialReceiver;

architecture behavioral of SerialReceiver is
    signal  down38400   : unsigned(9 downto 0) := (others => '0');
    signal  rx_buffer   : unsigned(39 downto 0) := (others => '1');
    signal  valid_value : std_logic := '0';
    signal  value       : std_logic_vector(7 downto 0) := (others => '0');
    signal  dp          : std_logic := '0';

    component sevensegdisplay
    port(
        clk                 : in    std_logic;
        digit0              : in    std_logic_vector(3 downto 0);
        digit1              : in    std_logic_vector(3 downto 0);
        digit2              : in    std_logic_vector(3 downto 0);
        digit3              : in    std_logic_vector(3 downto 0);
        anodes              : out   std_logic_vector(3 downto 0);
        sevenseg            : out   std_logic_vector(6 downto 0);
        dp                  : out   std_logic
    );
    end component;

begin

    -- Downsample to 38400
    proc_rx: process(clk)
    begin
        if rising_edge(clk) then
            if down38400 = 833 then
                -- Sample
                rx_buffer <= rx & rx_buffer(39 downto 1);
                down38400 <= to_unsigned(0, 10);

                valid_value <=  rx_buffer(38) and rx_buffer(37) and 
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
                down38400 <= down38400 + 1;
            end if;

            if valid_value = '1' then
                value <= rx_buffer(34) & rx_buffer(30) & rx_buffer(26) & rx_buffer(22) & 
                         rx_buffer(18) & rx_buffer(14) & rx_buffer(10) & rx_buffer(6);

                valid_value <= '0';
                rx_buffer <= (others => '1');
            end if;

        end if;
    end process;

    inst_sevenseg: sevensegdisplay port map (
        clk => clk,
        digit0 => "0000",
        digit1 => "0000",
        digit2 => value(7 downto 4),
        digit3 => value(3 downto 0),
        anodes => sdAN,
        sevenseg => sdSeg,
        dp => dp);

end behavioral;
