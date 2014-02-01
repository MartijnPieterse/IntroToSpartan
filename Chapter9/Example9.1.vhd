-- Because i number the switches as the are specified, and numbered on the board
-- this file is somewhat different than in the book.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    Port ( switches : in  STD_LOGIC_VECTOR(7 downto 0);
           LEDs     : out STD_LOGIC_VECTOR(7 downto 0)
         ); 
end FullAdder;

architecture Behavioral of FullAdder is
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

    result(0) <= x(0) XOR y(0);
    carry(0)  <= x(0) AND y(0);

    result(1) <= x(1) XOR y(1) XOR carry(0);
    carry(1)  <= (x(1) AND y(1)) OR (carry(0) AND x(1)) OR (carry(0) AND y(1));

end Behavioral;
