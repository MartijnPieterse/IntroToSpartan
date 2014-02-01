library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UnsignedAddition is
    Port ( switches : in  STD_LOGIC_VECTOR(7 downto 0);
           LEDs     : out STD_LOGIC_VECTOR(7 downto 0)
         ); 
end UnsignedAddition;

architecture Behavioral of UnsignedAddition is
    signal x      : UNSIGNED(3 downto 0);
    signal y      : UNSIGNED(3 downto 0);
    signal carry  : UNSIGNED(3 downto 0);
    signal result : UNSIGNED(4 downto 0);
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

    -- Do the work.
    result(4 downto 0) <= ('0' & x) + y;

    -- Withough adding a '0' to x:
    --  * This will only add 4 bits and the carry is gone.
    --  * Also result must be 4 bits too, but then the build complains about result(4) used, but not set.
    -- result(3 downto 0) <= x + y;
end Behavioral;
