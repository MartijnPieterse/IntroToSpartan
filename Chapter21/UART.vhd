library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UART is
    port (
        clk      : in  std_logic;
        rx       : in  std_logic;
        tx       : out std_logic;
        WEn      : in std_logic;
        data_in  : in std_logic_vector(7 downto 0);
        DAv      : out std_logic;
        data_out : out std_logic_vector(7 downto 0)
    );
end UART;

architecture behavioral of UART is

    component UART_Transmitter
    port(
        clk     : in  std_logic;
        tx      : out std_logic;
        WEn     : in  std_logic;
        data    : in  std_logic_vector(7 downto 0);
        busy    : out std_logic
    );
    end component;

    component UART_Receiver
    port(
        clk     : in  std_logic;
        rx      : in  std_logic;
        DAv     : out std_logic;
        data    : out std_logic_vector(7 downto 0)
    );
    end component;

begin

    inst_uart_transmitter: UART_Transmitter port map (
        clk => clk,
        tx => tx,
        WEn => WEn,
        data => data_in);

    inst_uart_receiver: UART_Receiver port map (
        clk => clk,
        rx => rx,
        DAv => DAv,
        data => data_out);

end behavioral;
