library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 32Mhz clock in, 11kHz counter out.
-- 32000000 / 11000 = 2909.09090909...
-- Counter of 16 bits.
-- Increase output when counter == 2909 (will be a frequency of 11.000344kHz, close enough)

entity freq11kHz is
    Port ( 
        Clk         : in STD_LOGIC;
        outp        : out STD_LOGIC_VECTOR (15 downto 0)
    );
end freq11kHz;

architecture Behavioral of freq11kHz is
    signal val : UNSIGNED (11 downto 0);
    signal f11 : UNSIGNED (15 downto 0);
begin

    outp <= STD_LOGIC_VECTOR(f11);

    process (Clk, val)
    begin
        if rising_edge(Clk) then
            val <= val + 1;
            if val = 2909 then
                val <= "000000000000";
                f11 <= f11 + 1;
            end if;
        end if;
    end process;
end Behavioral;
