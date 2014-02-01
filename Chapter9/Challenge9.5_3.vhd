library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IncrementWithOne is
    Port ( switches : in  STD_LOGIC_VECTOR(7 downto 0);
           LEDs     : out STD_LOGIC_VECTOR(7 downto 0)
         ); 
end IncrementWithOne;

architecture Behavioral of IncrementWithOne is
    signal x      : STD_LOGIC_VECTOR(7 downto 0);
    signal carry  : STD_LOGIC_VECTOR(7 downto 0);
    signal result : STD_LOGIC_VECTOR(7 downto 0);
begin
    -- Bit reversal for input/output
    LEDs <= result(0) & result(1) & result(2) & result(3) & result(4) & result(5) & result(6) & result(7);

    x(0) <= switches(7);
    x(1) <= switches(6);
    x(2) <= switches(5);
    x(3) <= switches(4);
    x(4) <= switches(3);
    x(5) <= switches(2);
    x(6) <= switches(1);
    x(7) <= switches(0);

    result(0) <= x(0) XOR '1';
    carry(0)  <= x(0) AND '1';

    result(1) <= x(1) XOR carry(0);
    carry(1)  <= x(1) AND carry(0);

    result(2) <= x(2) XOR carry(1);
    carry(2)  <= x(2) AND carry(1);

    result(3) <= x(3) XOR carry(2);
    carry(3)  <= x(3) AND carry(2);

    result(4) <= x(4) XOR carry(3);
    carry(4)  <= x(4) AND carry(3);

    result(5) <= x(5) XOR carry(4);
    carry(5)  <= x(5) AND carry(4);

    result(6) <= x(6) XOR carry(5);
    carry(6)  <= x(6) AND carry(5);

    result(7) <= x(7) XOR carry(6);
    carry(7)  <= x(7) AND carry(6);

end Behavioral;
