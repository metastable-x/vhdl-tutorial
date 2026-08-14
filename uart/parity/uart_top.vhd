library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.msg_pkg.all;
use work.uart_pkg.all;

entity uart_top is
    port (
        clk  : in  std_logic;
        rst  : in  std_logic;
        send : in  std_logic;
        sel  : in  std_logic;
        rx   : in  std_logic;
        tx   : out std_logic;
        led  : out std_logic_vector(15 downto 0);
        seg  : out std_logic_vector(6 downto 0);
        an   : out std_logic_vector(3 downto 0);
        dp   : out std_logic
    );
end entity;

architecture rtl of uart_top is

    constant PARITY : string := "EVEN"; -- "NONE", "EVEN", "ODD", "MARK", or "SPACE"

    signal rx_stb     : std_logic := '0';
    signal rx_data    : std_logic_vector(7 downto 0) := (others => '0');
    signal rx_err     : std_logic := '0';
    signal rx_err_cnt : unsigned(15 downto 0) := (others => '0');

    signal tx_stb  : std_logic := '0';
    signal tx_busy : std_logic := '0';
    signal tx_data : std_logic_vector(7 downto 0) := (others => '0');
    signal tx_sel  : integer range 0 to NUM_MSGS-1 := 0;

    signal send_db   : std_logic := '0';
    signal send_stb  : std_logic := '0';
    signal send_prev : std_logic := '0';

    signal sel_db   : std_logic := '0';
    signal sel_stb  : std_logic := '0';
    signal sel_prev : std_logic := '0';

    signal seg_data : std_logic_vector(13 downto 0) := (others => '0');

begin

    rx_uart : entity work.uart_rx
    generic map (
        PARITY => PARITY
    )
    port map (
        clk  => clk,
        rst  => rst,
        rx   => rx,
        dout => rx_data,
        stb  => rx_stb,
        err  => rx_err
    );

    tx_uart : entity work.uart_tx
    generic map (
        PARITY => PARITY
    )
    port map (
        clk  => clk,
        rst  => rst,
        din  => tx_data,
        stb  => tx_stb,
        busy => tx_busy,
        tx   => tx
    );

    ctrl_uart : entity work.uart_ctrl
    port map (
        clk      => clk,
        rst      => rst,
        send_stb => send_stb,
        tx_sel   => tx_sel,
        rx_in    => rx_data,
        rx_stb   => rx_stb,
        tx_busy  => tx_busy,
        tx_out   => tx_data,
        tx_stb   => tx_stb
    );

    send_debouncer : entity work.btn_debounce
    port map (
        clk    => clk,
        rst    => rst,
        btn    => send,
        btn_db => send_db
    );

    sel_debouncer : entity work.btn_debounce
    port map (
        clk    => clk,
        rst    => rst,
        btn    => sel,
        btn_db => sel_db
    );

    seg_drive : entity work.seg_driver
    port map (
        clk     => clk,
        rst     => rst,
        data_in => seg_data,
        seg     => seg,
        an      => an,
        dp      => dp
    );

    edge_detect : process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                send_prev <= '0';
                sel_prev  <= '0';
            else
                send_prev <= send_db;
                sel_prev  <= sel_db;
            end if;
        end if;
    end process;

    send_stb <= send_db and (not send_prev);
    sel_stb  <= sel_db and (not sel_prev);

    tx_selector : process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                tx_sel <= 0;
            elsif (sel_stb = '1') then
                if (tx_sel = NUM_MSGS-1) then
                    tx_sel <= 0;
                else
                    tx_sel <= tx_sel + 1;
                end if;
            end if;
        end if;
    end process;

    err_counter : process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                rx_err_cnt <= (others => '0');
            elsif (rx_err = '1') then
                rx_err_cnt <= rx_err_cnt + 1;
            end if;
        end if;
    end process;

    led      <= std_logic_vector(rx_err_cnt);
    seg_data <= std_logic_vector(to_unsigned(tx_sel, seg_data'length));

end architecture;
