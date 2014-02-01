library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullSubtract4Bits is
    Port ( switches : in  STD_LOGIC_VECTOR(7 downto 0);
           LEDs     : out STD_LOGIC_VECTOR(7 downto 0)
         ); 
end FullSubtract4Bits;

architecture Behavioral of FullSubtract4Bits is
    signal x      : STD_LOGIC_VECTOR(3 downto 0);
    signal y      : STD_LOGIC_VECTOR(3 downto 0);
    signal carry  : STD_LOGIC_VECTOR(3 downto 0);
    signal result : STD_LOGIC_VECTOR(4 downto 0);
begin
    -- Bit reversal for input/output
    LEDs <= result(0) & result(1) & result(2) & result(3) & result(4) & "000";

    x(0) <= switches(3);
    x(1) <= switches(2);
    x(2) <= switches(1);
    x(3) <= switches(0);

    y(0) <= switches(7);
    y(1) <= switches(6);
    y(2) <= switches(5);
    y(3) <= switches(4);

    -- result(4) is used as the sign, 1 means negative.
    -- result = x - y

    result(0) <= x(0) XOR y(0);
    carry(0)  <= NOT x(0) AND y(0);

    result(1) <= x(1) XOR y(1) XOR carry(0);
    carry(1)  <= (NOT x(1) AND y(1)) OR carry(0);

    result(2) <= x(2) XOR y(2) XOR carry(1);
    carry(2)  <= (NOT x(2) AND y(2)) OR carry(1);

    result(3) <= x(3) XOR y(3) XOR carry(2);
    carry(3)  <= (NOT x(3) AND y(3)) OR carry(2);

    result(4) <= carry(3);
end Behavioral;
