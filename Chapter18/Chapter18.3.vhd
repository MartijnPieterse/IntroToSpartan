library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Clock is
        Port ( 
        sdAN     : out STD_LOGIC_VECTOR(0 to 3);
        sdSeg    : out STD_LOGIC_VECTOR(0 to 6);
        clk      : in  STD_LOGIC
    );
end Clock;

architecture Behavioral of Clock is
    signal bcd1 : UNSIGNED(3 downto 0) := "0100"; -- 4
    signal bcd2 : UNSIGNED(3 downto 0) := "0101"; -- 5
    signal bcd3 : UNSIGNED(3 downto 0) := "1001"; -- 9
    signal bcd4 : UNSIGNED(3 downto 0) := "0011"; -- 3 (32:54)
    signal clockdiv : UNSIGNED(19 downto 0) := (others => '0');
    signal clk_2mhz : STD_LOGIC;
    signal clk_1mhz : STD_LOGIC;

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

    COMPONENT my_dcm
    PORT(
        CLK_IN1                 : in    STD_LOGIC;
        CLK_OUT1            : out   STD_LOGIC;
        CLK_OUT2            : out   STD_LOGIC
    );
    END COMPONENT;

begin

    Inst_dcm: my_dcm PORT MAP(
        CLK_IN1 => clk,
        CLK_OUT1 => clk_2mhz,
        CLK_OUT2 => clk_1mhz
    );

    Inst_sevensegdisplay: sevensegdisplay PORT MAP(
        clk => clk_1mhz,
        digit0 => std_logic_vector(bcd4),
        digit1 => std_logic_vector(bcd3),
        digit2 => std_logic_vector(bcd2),
        digit3 => std_logic_vector(bcd1),
        anodes => sdAN,
        sevenseg => sdSeg
    );
    
    clk_proc: process(clk_2mhz)
    begin
        if rising_edge(clk_2mhz) then

            clockdiv <= clockdiv + 1;

            if clockdiv = 1000000 then
                clockdiv <= "00000000000000000000";


                if bcd1 = 9 then
                    bcd1 <= "0000";

                    if bcd2 = 5 then
                        bcd2 <= "0000";

                        if bcd3 = 9 then
                            bcd3 <= "0000";

                            if bcd4 = 5 then
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

