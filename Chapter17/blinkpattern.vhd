----------------------------------------------------------------------------------
-- Company:         Artisan Engineering
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

entity blinkpattern is
    Port ( 
        clk                 : in    STD_LOGIC;
        enable              : in    STD_LOGIC;
        leds                : out   STD_LOGIC_VECTOR(7 downto 0)
    );
end blinkpattern;

architecture Behavioral of blinkpattern is
    component memory
    port (
        clka  : in  STD_LOGIC;
        addra : in  STD_LOGIC_VECTOR(7 downto 0);
        douta : out STD_LOGIC_VECTOR(7 downto 0)
    );
    end component;


    signal  counter : UNSIGNED(24 downto 0) := (others => '0');
    signal  count10 : UNSIGNED(17 downto 0) := (others => '0');
    signal  a       : UNSIGNED(7 downto 0) := (others => '0');
begin

    clk_proc: process(clk)
    begin
        if rising_edge(clk) then
            if enable = '1' then

                if counter /= 32000000 then
                    counter <= counter + 1;
                    count10 <= count10 + 1;

                    if count10 = 125000 then
                        count10 <= "000000000000000000";
                        a <= a + 1;
                    end if;
                end if;
            else
                counter <= "0000000000000000000000000";
                count10 <= "000000000000000000";
                a <= "00000000";
            end if;

        end if;
    end process;

    mempat: memory
    port map (
        clka => clk,
        addra => std_logic_vector(a),
        douta => leds
    );

end Behavioral;


