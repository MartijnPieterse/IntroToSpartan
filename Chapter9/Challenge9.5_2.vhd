library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AddWithNand is
    Port ( switches : in  STD_LOGIC_VECTOR(7 downto 0);
           LEDs     : out STD_LOGIC_VECTOR(7 downto 0)
         ); 
end AddWithNand;

architecture Behavioral of AddWithNand is
    signal x      : STD_LOGIC_VECTOR(3 downto 0);
    signal y      : STD_LOGIC_VECTOR(3 downto 0);
    signal l1     : STD_LOGIC_VECTOR(3 downto 0);
    signal l2     : STD_LOGIC_VECTOR(7 downto 0);
    signal l3     : STD_LOGIC_VECTOR(3 downto 0);
    signal l4     : STD_LOGIC_VECTOR(2 downto 0);
    signal l5     : STD_LOGIC_VECTOR(8 downto 0);
    signal l6     : STD_LOGIC_VECTOR(2 downto 0);
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

    -- Implement addition using only NAND
    -- Solution taken from 
    ---  http://codegolf.stackexchange.com/questions/10845/build-an-adding-machine-using-nand-logic-gates


    l1(0) <= x(0) NAND y(0);
    l1(1) <= x(1) NAND y(1);
    l1(2) <= x(2) NAND y(2);
    l1(3) <= x(3) NAND y(3);

    l2(0) <= x(0) NAND l1(0);
    l2(1) <= y(0) NAND l1(0);
    l2(2) <= x(1) NAND l1(1);
    l2(3) <= y(1) NAND l1(1);
    l2(4) <= x(2) NAND l1(2);
    l2(5) <= y(2) NAND l1(2);
    l2(6) <= x(3) NAND l1(3);
    l2(7) <= y(3) NAND l1(3);

    l3(0) <= l2(0) NAND l2(1);
    l3(1) <= l2(2) NAND l2(3);
    l3(2) <= l2(4) NAND l2(5);
    l3(3) <= l2(6) NAND l2(7);

    l4(0) <= l5(0) NAND l3(1);
    l4(1) <= l5(3) NAND l3(2);
    l4(2) <= l5(6) NAND l3(3);

    l5(0) <= l1(0) NAND l1(0);
    l5(1) <= l4(0) NAND l5(0);
    l5(2) <= l4(0) NAND l3(1);
    l5(3) <= l4(0) NAND l1(1);
    l5(4) <= l4(1) NAND l5(3);
    l5(5) <= l4(1) NAND l3(2);
    l5(6) <= l4(1) NAND l1(2);
    l5(7) <= l4(2) NAND l5(6);
    l5(8) <= l4(2) NAND l3(3);

    l6(0) <= l5(1) NAND l5(2);
    l6(1) <= l5(4) NAND l5(5);
    l6(2) <= l5(7) NAND l5(8);

    result(0) <= l3(0);
    result(1) <= l6(0);
    result(2) <= l6(1);
    result(3) <= l6(2);
    result(4) <= l4(2) NAND l1(3);

end Behavioral;
