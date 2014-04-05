library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dac16 is
    Port ( 
        Clk         : in STD_LOGIC;
        Data        : in STD_LOGIC_VECTOR (15 downto 0);
        PulseStream : out STD_LOGIC
    );
end dac16;

architecture Behavioral of dac16 is
    signal sum : STD_LOGIC_VECTOR (16 downto 0);
begin
    PulseStream <= sum(16);
    process (Clk, sum)
    begin
        if rising_edge(Clk) then
            sum <= ("0" & sum(15 downto 0)) + ("0" &data);
        end if;
    end process;
end Behavioral;
