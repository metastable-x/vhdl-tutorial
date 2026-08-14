library ieee;
use ieee.std_logic_1164.all;
use work.uart_pkg.all;

entity uart_rx is
    generic(
        PARITY : string := "NONE" -- "NONE", "EVEN", "ODD", "MARK", or "SPACE"
    );
    port (
        clk  : in  std_logic;
        rst  : in  std_logic;
        rx   : in  std_logic;
        dout : out std_logic_vector(7 downto 0);
        stb  : out std_logic;
        err  : out std_logic
    );
end entity;

architecture rtl of uart_rx is
    signal rx_state : uart_state_t := idle;

    signal msg     : std_logic_vector(7 downto 0) := (others => '0');
    signal msg_err : std_logic := '0';

    signal cnt : integer range 0 to CLKS_PER_BIT-1 := 0;
    signal idx : integer range 0 to 7 := 0;
begin

    process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                dout     <= (others => '0');
                msg      <= (others => '0');
                msg_err  <= '0';
                cnt      <= 0;
                idx      <= 0;
                stb      <= '0';
                err      <= '0';
                rx_state <= idle;
            else
                case rx_state is
                    when idle =>
                        stb     <= '0';
                        err     <= '0';
                        msg     <= (others => '0');
                        msg_err <= '0';
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
                                idx <= 0;
                                if (PARITY = "NONE") then
                                    rx_state <= stop;
                                else
                                    rx_state <= par;
                                end if;
                            else
                                idx <= idx + 1;
                            end if;
                        else
                            cnt <= cnt + 1;
                        end if;

                    when par =>
                        if (cnt = CLKS_PER_BIT-1) then
                            cnt <= 0;
                            if (rx /= parity_calc(msg, PARITY)) then
                                msg_err <= '1';
                            end if;
                            rx_state <= stop;
                        else
                            cnt <= cnt + 1;
                        end if;

                    when stop =>
                        if (cnt = CLKS_PER_BIT-1) then
                            cnt <= 0;
                            if (msg_err = '0') then
                                dout <= msg;
                                stb  <= '1';
                            else
                                err <= '1';
                            end if;
                            rx_state <= idle;
                        else
                            cnt <= cnt + 1;
                        end if;
                end case;
            end if;
        end if;
    end process;
end architecture;
