library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Communicate is
    port (
        clk : in  std_logic;
        tx  : out std_logic
    );
end Communicate;

architecture behavioral of Communicate is

    signal z :      std_logic_vector(15 downto 0) := "1111010110100111"; -- Z
    --signal z :      std_logic_vector(31 downto 0) := "11111100001010011111110101101001";  -- Z\n
    signal count :  unsigned(11 downto 0) := (others => '0');

begin

    tx <= z(0);

    transmit: process(clk)
    begin
        if rising_edge(clk) then
            if count = 3332 then
                count <= (others => '0');
                z <= z(0) & z(31 downto 1);
            else
                count <= count + 1;
            end if;
        end if;
    end process;

end behavioral;

