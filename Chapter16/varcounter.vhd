library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Base 

entity varcounter is
    Port ( 
        Clk         : in STD_LOGIC;
        var         : in STD_LOGIC_VECTOR (7 downto 0);
        outp        : out STD_LOGIC_VECTOR (9 downto 0)
    );
end varcounter;

architecture Behavioral of varcounter is
    signal val : STD_LOGIC_VECTOR (22 downto 0);
begin

    outp <= val(22 downto 13);

    process (Clk, val)
    begin
        if rising_edge(Clk) then
            val <= val + 256 + var;
        end if;
    end process;
end Behavioral;
