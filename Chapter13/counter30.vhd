----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:00:27 02/12/2014 
-- Design Name: 
-- Module Name:    counter30 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter30 is
    Port ( clk : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (29 downto 0));
end counter30;

architecture Behavioral of counter30 is
    signal counter     : UNSIGNED(29 downto 0) := (others => '0');
begin
    clk_proc: process(clk)
    begin
        if rising_edge(clk) then
            if enable = '1' then
                counter(29 downto 0) <= counter(29 downto 0) + 1;
            end if;
        end if;

    end process;
    
    count <= std_logic_vector(counter);

end Behavioral;

