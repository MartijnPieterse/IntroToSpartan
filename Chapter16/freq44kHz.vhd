library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 32Mhz clock in, 11kHz counter out.
-- 32000000 / 44100 = 725.62
-- Counter of 10 bits.
-- Increase output when counter == 725 (will be a frequency of 11.000344kHz, close enough)

entity freq44kHz is
    Port ( 
        Clk         : in STD_LOGIC;
        outp        : out STD_LOGIC_VECTOR (14 downto 0)
    );
end freq44kHz;

architecture Behavioral of freq44kHz is
    signal val : UNSIGNED (9 downto 0);
    signal f11 : UNSIGNED (14 downto 0);
begin

    outp <= STD_LOGIC_VECTOR(f11);

    process (Clk, val)
    begin
        if rising_edge(Clk) then
            val <= val + 1;
            if val = 725 then
                val <= "0000000000";
                f11 <= f11 + 1;
            end if;
        end if;
    end process;
end Behavioral;
