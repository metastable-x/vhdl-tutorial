library ieee;
use ieee.std_logic_1164.all;

entity uart_rx is
    generic(
        CLK_FREQ  : integer := 100000000;
        BAUD      : integer := 115200
    );
    port (
        clk   : in  std_logic;
        rst   : in  std_logic;
        rx    : in  std_logic;
        dout  : out std_logic_vector(7 downto 0);
        stb   : out std_logic
    );
end entity;

architecture rtl of uart_rx is
    constant CLKS_PER_BIT : integer := CLK_FREQ / BAUD;

    type rx_state_t is (idle, start, data, stop);

    signal rx_state : rx_state_t := idle;

    signal msg : std_logic_vector(7 downto 0) := (others => '0');

    signal cnt : integer range 0 to CLKS_PER_BIT-1 := 0;
    signal idx : integer range 0 to 7 := 0;
begin

    process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                dout     <= (others => '0');
                msg      <= (others => '0');
                cnt      <= 0;
                idx      <= 0;
                stb      <= '0';
                rx_state <= idle;
            else
                case rx_state is
                    when idle =>
                        stb <= '0';
                        msg <= (others => '0');
                        if (rx = '0') then
                            rx_state <= start;
                        end if;

                    when start =>
                        if (cnt = CLKS_PER_BIT/2) then
                            cnt <= 0;
                            if (rx = '0') then
                                rx_state <= data;
                            else
                                rx_state <= idle;
                            end if;
                        else
                            cnt <= cnt + 1;
                        end if;

                    when data =>
                        if (cnt = CLKS_PER_BIT-1) then
                            cnt      <= 0;
                            msg(idx) <= rx;
                            if (idx = 7) then
                                idx      <= 0;
                                rx_state <= stop;
                            else
                                idx <= idx + 1;
                            end if;
                        else
                            cnt <= cnt + 1;
                        end if;

                    when stop =>
                        if (cnt = CLKS_PER_BIT-1) then
                            cnt  <= 0;
                            dout <= msg;
                            stb  <= '1';
                            rx_state <= idle;
                        else
                            cnt <= cnt + 1;
                        end if;
                end case;
            end if;
        end if;
    end process;
end architecture;
