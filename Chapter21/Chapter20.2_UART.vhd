library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UART is
    port (
        clk           : in  std_logic;
        rx            : in  std_logic;
        tx            : out std_logic;
        rx_data_avail : out std_logic;
        rxd           : out std_logic_vector(7 downto 0);
        tx_ready      : out std_logic;
        txd           : in  std_logic_vector(7 downto 0);
    );
end UART;


