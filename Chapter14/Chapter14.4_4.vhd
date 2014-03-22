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
    signal counter : UNSIGNED(29 downto 0) := (others => '0');
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
        digit0 => std_logic_vector(counter(29 downto 26)),
        digit1 => std_logic_vector(counter(28 downto 25)),
        digit2 => std_logic_vector(counter(27 downto 24)),
        digit3 => std_logic_vector(counter(26 downto 23)),
        anodes => sdAN,
        sevenseg => sdSeg
    );
        
    
    clk_proc: process(clk)
    begin
        if rising_edge(clk) then

            counter <= counter + 1;

        end if;
    end process;

end Behavioral;

