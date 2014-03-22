----------------------------------------------------------------------------------
-- Company:         Artisan Engineneering
-- Engineer:        Martijn Pieterse
-- 
-- Create Date:     22 March 2014
-- Design Name:     
-- Module Name:     sevensegdisplay - Behavioral 
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

entity sevensegdisplay is
    Port ( 
        clk                 : in    STD_LOGIC;
        digit0              : in    STD_LOGIC_VECTOR(3 downto 0);
        digit1              : in    STD_LOGIC_VECTOR(3 downto 0);
        digit2              : in    STD_LOGIC_VECTOR(3 downto 0);
        digit3              : in    STD_LOGIC_VECTOR(3 downto 0);
        anodes              : out   STD_LOGIC_VECTOR(3 downto 0);
        sevenseg            : out   STD_LOGIC_VECTOR(6 downto 0);
        dp                  : out   STD_LOGIC
    );
end sevensegdisplay;

architecture Behavioral of sevensegdisplay is
    signal clockdiv     : UNSIGNED(29 downto 0) := (others => '0');
    signal activedigit  : UNSIGNED(1 downto 0) := (others => '0');
    signal swp          : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
begin

    clk_proc: process(clk)
    begin
        if rising_edge(clk) then

            CASE activedigit(1 downto 0) IS
                WHEN "00" =>
                    anodes <= "0111";
                    swp <= digit0;
                WHEN "01" =>
                    anodes <= "1011";
                    swp <= digit1;
                WHEN "10" =>
                    anodes <= "1101";
                    swp <= digit2;
                WHEN "11" =>
                    anodes <= "1110";
                    swp <= digit3;
                WHEN OTHERS =>
                    anodes <= "1111";
            END CASE;

            CASE swp(3 downto 0) IS
                WHEN "0000" =>
                    sevenseg <= "0000001";
                WHEN "0001" =>
                    sevenseg <= "1001111";
                WHEN "0010" =>
                    sevenseg <= "0010010";
                WHEN "0011" =>
                    sevenseg <= "0000110";
                WHEN "0100" =>
                    sevenseg <= "1001100";
                WHEN "0101" =>
                    sevenseg <= "0100100";
                WHEN "0110" =>
                    sevenseg <= "0100000";
                WHEN "0111" =>
                    sevenseg <= "0001111";
                WHEN "1000" =>
                    sevenseg <= "0000000";
                WHEN "1001" =>
                    sevenseg <= "0000100";
                WHEN "1010" =>
                    sevenseg <= "0001000";
                WHEN "1011" =>
                    sevenseg <= "1100000";
                WHEN "1100" =>
                    sevenseg <= "0110001";
                WHEN "1101" =>
                    sevenseg <= "1000010";
                WHEN "1110" =>
                    sevenseg <= "0110000";
                WHEN "1111" =>
                    sevenseg <= "0111000";
                WHEN OTHERS =>
                    sevenseg <= "0110110";
            END CASE;

            clockdiv <= clockdiv + 1;

            if clockdiv = 32000 then
                clockdiv <= "000000000000000000000000000000";
                activedigit <= activedigit + 1;
            end if;

        end if;

    end process;

    dp <= '0';
end Behavioral;

