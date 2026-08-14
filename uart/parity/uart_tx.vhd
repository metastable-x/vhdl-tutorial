library ieee;
use ieee.std_logic_1164.all;
use work.uart_pkg.all;

entity uart_tx is
    generic(
        PARITY : string := "NONE" -- "NONE", "EVEN", "ODD", "MARK", or "SPACE"
    );
    port (
        clk  : in  std_logic;
        rst  : in  std_logic;
        din  : in  std_logic_vector(7 downto 0);
        stb  : in  std_logic;
        busy : out std_logic;
        tx   : out std_logic
    );
end entity;

architecture rtl of uart_tx is
    signal tx_state : uart_state_t := idle;
    signal tx_par   : std_logic    := '0';

    signal msg : std_logic_vector(7 downto 0) := (others => '0');

    signal cnt : integer range 0 to CLKS_PER_BIT-1 := 0;
    signal idx : integer range 0 to 7              := 0;
begin

    process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                msg      <= (others => '0');
                tx_par   <= '0';
                busy     <= '0';
                tx       <= '1';
                cnt      <= 0;
                idx      <= 0;
                tx_state <= idle;
            else
                case tx_state is
                    when idle =>
                        tx <= '1';
                        if (stb = '1') then
                            msg      <= din;
                            tx_par   <= parity_calc(din, PARITY);
                            busy     <= '1';
                            tx_state <= start;
                        end if;

                    when start =>
                        tx <= '0';
                        if (cnt = CLKS_PER_BIT-1) then
                            cnt      <= 0;
                            tx_state <= data;
                        else
                            cnt <= cnt + 1;
                        end if;

                    when data =>
                        tx <= msg(idx);
                        if (cnt = CLKS_PER_BIT-1) then
                            cnt <= 0;
                            if (idx = 7) then
                                idx <= 0;
                                if (PARITY = "NONE") then
                                    tx_state <= stop;
                                else
                                    tx_state <= par;
                                end if;
                            else
                                idx <= idx + 1;
                            end if;
                        else
                            cnt <= cnt + 1;
                        end if;

                    when par =>
                        tx <= tx_par;
                        if (cnt = CLKS_PER_BIT-1) then
                            cnt      <= 0;
                            tx_state <= stop;
                        else
                            cnt <= cnt + 1;
                        end if;

                    when stop =>
                        tx <= '1';
                        if (cnt = CLKS_PER_BIT-1) then
                            cnt      <= 0;
                            busy     <= '0';
                            tx_state <= idle;
                        else
                            cnt <= cnt + 1;
                        end if;
                end case;
            end if;
        end if;
    end process;
end architecture;
