library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGASignal is
    port (
        sdAN    : out std_logic_vector(3 downto 0);
        sdSeg   : out std_logic_vector(6 downto 0);
        clk     : in  std_logic;
        hSync   : out std_logic;
        vSync   : out std_logic;
        VGARed  : out std_logic_vector(2 downto 0);
        VGAGreen: out std_logic_vector(2 downto 0);
        VGABlue : out std_logic_vector(2 downto 1)
    );
end VGASignal;

architecture behavioral of VGASignal is
    signal bcd1 : unsigned(3 downto 0) := "1010";
    signal bcd2 : unsigned(3 downto 0) := "1011";
    signal bcd3 : unsigned(3 downto 0) := "1100";
    signal bcd4 : unsigned(3 downto 0) := "1101"; 
    signal dp   : std_logic := '0';
    signal clk_32mhz : std_logic := '0';
    signal clk_25mhz : std_logic := '0';
    signal hcount : unsigned(9 downto 0) := (others => '0');
    signal vcount : unsigned(9 downto 0) := (others => '0');

    component sevensegdisplay
    port(
        clk                 : in    std_logic;
        digit0              : in    std_logic_vector(3 downto 0);
        digit1              : in    std_logic_vector(3 downto 0);
        digit2              : in    std_logic_vector(3 downto 0);
        digit3              : in    std_logic_vector(3 downto 0);
        anodes              : out   std_logic_vector(3 downto 0);
        sevenseg            : out   std_logic_vector(6 downto 0);
        dp                  : out   std_logic
    );
    end component;

    component vga_clk
    port(
      CLK_IN1           : in     std_logic;
      CLK_OUT1          : out    std_logic
    );
    end component;

begin

    inst_sevensegdisplay: sevensegdisplay port map (
        clk => clk_25mhz,
        digit0 => std_logic_vector(bcd1),
        digit1 => std_logic_vector(bcd2),
        digit2 => std_logic_vector(bcd3),
        digit3 => std_logic_vector(bcd4),
        anodes => sdAN,
        sevenseg => sdSeg,
        dp => dp);

    inst_vga_clk: vga_clk port map (
        CLK_IN1 => clk,
        CLK_OUT1 => clk_25mhz);

    bcd1 <= vcount(9 downto 6);
    

    vga_proc: process(clk_25mhz)
    begin
        if rising_edge(clk_25mhz)
        then
            if hcount = 799 then
                hcount <= to_unsigned(0, 10);

                if vcount = 524 then
                    vcount <= to_unsigned(0, 10);
                else
                    vcount <= vcount + 1;
                end if;
            else
                hcount <= hcount + 1;
            end if;

            if vcount(9 downto 1) = 245 then
                vSync <= '0';
            else
                vSync <= '1';
            end if;

            if hcount >= 656 and hcount < 752 then
                hSync <= '0';
            else
                hSync <= '1';
            end if;

            if hcount < 640 and vcount < 480 then
                VGARed <= std_logic_vector(hcount(6 downto 4));
                VGAGreen <= std_logic_vector(vcount(7 downto 5));
                VGABlue <= hcount(0) & vcount(0);
            else
                VGARed <= "000";
                VGAGreen <= "000";
                VGABlue <= "00";
            end if;


        end if;
    end process;

end behavioral;
