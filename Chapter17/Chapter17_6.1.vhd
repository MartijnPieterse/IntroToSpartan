library ieee;
use ieee.std_logic_1164.all;

entity CombinationLock is
    Port ( clk      : in STD_LOGIC;
           switches : in STD_LOGIC_VECTOR (7 downto 0);
           LEDs     : out STD_LOGIC_VECTOR (7 downto 0);
           sdSeg    : out STD_LOGIC_VECTOR (0 to 6);
           sdAN     : out STD_LOGIC_VECTOR (3 downto 0)
    );
end CombinationLock;

architecture Behavioral of CombinationLock is
    component sevensegdisplay
        port (
            clk                 : in    STD_LOGIC;
            digit0              : in    STD_LOGIC_VECTOR(3 downto 0);
            digit1              : in    STD_LOGIC_VECTOR(3 downto 0);
            digit2              : in    STD_LOGIC_VECTOR(3 downto 0);
            digit3              : in    STD_LOGIC_VECTOR(3 downto 0);
            anodes              : out   STD_LOGIC_VECTOR(3 downto 0);
            sevenseg            : out   STD_LOGIC_VECTOR(6 downto 0);
            dp                  : out   STD_LOGIC
        );        
    end component;

    component blink
        port (
            clk     : in STD_LOGIC;
            enable  : in STD_LOGIC;
            leds    : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;


    constant state_error        : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    constant state_start        : STD_LOGIC_VECTOR(3 downto 0) := "0001";
    constant state_one_right    : STD_LOGIC_VECTOR(3 downto 0) := "0010";
    constant state_two_right    : STD_LOGIC_VECTOR(3 downto 0) := "0011";
    constant state_three_right  : STD_LOGIC_VECTOR(3 downto 0) := "0100";
    constant state_open         : STD_LOGIC_VECTOR(3 downto 0) := "1000";

    signal state : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal dummy : STD_LOGIC;
    signal startblink : STD_LOGIC := '0';
begin

    process (clk, switches)
    begin
        if rising_edge(clk) then
            case state is
                when state_error =>
                    startblink <= '1';
                    case switches is
                        when "00000000" => state <= state_start;
                        when others     => state <= state_error;
                    end case;
                when state_start =>
                    startblink <= '0';
                    case switches is
                        when "00000000" => state <= state_start;
                        when "01000000" => state <= state_one_right;
                        when others     => state <= state_error;
                    end case;
                when state_one_right =>
                    case switches is
                        when "01000000" => state <= state_one_right;
                        when "01100000" => state <= state_two_right;
                        when others     => state <= state_error;
                    end case;
                when state_two_right =>
                    case switches is
                        when "01100000" => state <= state_two_right;
                        when "01110000" => state <= state_three_right;
                        when others     => state <= state_error;
                    end case;
                when state_three_right =>
                    case switches is
                        when "01110000" => state <= state_three_right;
                        when "01111000" => state <= state_open;
                        when others     => state <= state_error;
                    end case;
                when state_open =>
                    case switches is
                        when "01111000" => 
                            state <= state_open;
                        when others     => 
                            state <= state_error;
                    end case;
                when others => state <= state_error;
            end case;
        end if;
    end process;

    sevenseg : sevensegdisplay
    port map (
        clk => clk,
        digit0 => state,
        digit1 => "000" & startblink,
        digit2 => "0000",
        digit3 => "0000",
        anodes => sdAN,
        sevenseg => sdSeg,
        dp => dummy
    );

    blinker: blink
    port map (
        clk => clk,
        enable => startblink,
        leds => LEDs
    );


end Behavioral;
