----------------------------------------------------------------------------------
-- Company:         Artisan Engineneering
-- Engineer:        Martijn Pieterse
-- 
-- Create Date:     05 April 2014
-- Design Name:     
-- Module Name:     blink
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:     Blink all LEDs 5 times when enabled has a rising edge.
--
-- Dependencies:    None
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity blink is
    Port ( 
        clk                 : in    STD_LOGIC;
        enable              : in    STD_LOGIC;
        leds                : out   STD_LOGIC_VECTOR(7 downto 0)
    );
end blink;

architecture Behavioral of blink is
    signal  go      : STD_LOGIC := '0';
    signal  counter : UNSIGNED(25 downto 0) := (others => '0');
    signal  count10 : UNSIGNED(21 downto 0) := (others => '0');
begin

    clk_proc: process(clk)
    begin
        if rising_edge(clk) then
            if enable = '1' then

                if counter /= 32000000 then
                    counter <= counter + 1;
                    count10 <= count10 + 1;

                    if count10 = 3200000 then
                        count10 <= "0000000000000000000000";
                        go <= not go;
                    end if;
                else
                    go <= '0';
                end if;
            else
                counter <= "00000000000000000000000000";
                count10 <= "0000000000000000000000";
                go <= '0';

            end if;

            if go = '1' then
                leds <= "11111111";
            else
                leds <= "00000000";
            end if;

        end if;

    end process;

end Behavioral;


