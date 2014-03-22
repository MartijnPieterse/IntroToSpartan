library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SegmentDisplay2 is
        Port ( 
        sdAN     : out STD_LOGIC_VECTOR(0 to 3);
        sdSeg    : out STD_LOGIC_VECTOR(0 to 6);
        clk      : in  STD_LOGIC
    );
end SegmentDisplay2;

architecture Behavioral of SegmentDisplay2 is
    signal bcd1 : UNSIGNED(3 downto 0) := (others => '0');
    signal bcd2 : UNSIGNED(3 downto 0) := (others => '0');
    signal bcd3 : UNSIGNED(3 downto 0) := (others => '0');
    signal bcd4 : UNSIGNED(3 downto 0) := (others => '0');
    signal clockdiv : UNSIGNED(29 downto 0) := (others => '0');

    COMPONENT sevensegdisplay
    PORT(
        clk                 : in    STD_LOGIC;
        digit0              : in    STD_LOGIC_VECTOR(3 downto 0);
        digit1              : in    STD_LOGIC_VECTOR(3 downto 0);
        digit2              : in    STD_LOGIC_VECTOR(3 downto 0);
        digit3              : in    STD_LOGIC_VECTOR(3 downto 0);
        anodes              : out   STD_LOGIC_VECTOR(3 downto 0);
        sevenseg            : out   STD_LOGIC_VECTOR(6 downto 0);
        dp                  : out   STD_LOGIC
    );
    END COMPONENT;


begin

    Inst_sevensegdisplay: sevensegdisplay PORT MAP(
        clk => clk,
        digit0 => std_logic_vector(bcd4),
        digit1 => std_logic_vector(bcd3),
        digit2 => std_logic_vector(bcd2),
        digit3 => std_logic_vector(bcd1),
        anodes => sdAN,
        sevenseg => sdSeg
    );
    
    clk_proc: process(clk)
    begin
        if rising_edge(clk) then

            clockdiv <= clockdiv + 1;

            if clockdiv = 800000 then
                clockdiv <= "000000000000000000000000000000";


                if bcd1 = 9 then
                    bcd1 <= "0000";

                    if bcd2 = 9 then
                        bcd2 <= "0000";

                        if bcd3 = 9 then
                            bcd3 <= "0000";

                            if bcd4 = 9 then
                                bcd4 <= "0000";
                            else
                                bcd4 <= bcd4 + 1;
                            end if;
                        else
                            bcd3 <= bcd3 + 1;
                        end if;
                    else
                        bcd2 <= bcd2 + 1;
                    end if;
                else
                    bcd1 <= bcd1 + 1;
                end if;
            end if;

        end if;
    end process;

end Behavioral;

