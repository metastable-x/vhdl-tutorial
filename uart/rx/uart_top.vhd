library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.msg_pkg.all;

entity uart_top is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        btn : in  std_logic;
        sel : in  std_logic;
        rx  : in  std_logic;
        tx  : out std_logic;
        seg : out std_logic_vector(6 downto 0);
        an  : out std_logic_vector(3 downto 0);
        dp  : out std_logic
    );
end entity;

architecture rtl of uart_top is

    signal rx_stb  : std_logic := '0';
    signal rx_data : std_logic_vector(7 downto 0) := (others => '0');

    signal tx_stb  : std_logic := '0';
    signal tx_busy : std_logic := '0';
    signal tx_data : std_logic_vector(7 downto 0) := (others => '0');

    signal btn_db   : std_logic := '0';
    signal btn_stb  : std_logic := '0';
    signal btn_prev : std_logic := '0';

    signal sel_db   : std_logic := '0';
    signal sel_stb  : std_logic := '0';
    signal sel_prev : std_logic := '0';

    signal msg_sel  : integer range 0 to NUM_MSGS-1 := 0;
    signal seg_data : std_logic_vector(13 downto 0) := (others => '0');

begin

    rx_uart : entity work.uart_rx
    port map (
        clk  => clk,
        rst  => rst,
        rx   => rx,
        dout => rx_data,
        stb  => rx_stb
    );

    tx_uart : entity work.uart_tx
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
        clk     => clk,
        rst     => rst,
        btn_stb => btn_stb,
        msg_sel => msg_sel,
        rx_in   => rx_data,
        rx_stb  => rx_stb,
        tx_busy => tx_busy,
        tx_out  => tx_data,
        tx_stb  => tx_stb
    );

    btn_debouncer : entity work.btn_debounce
    port map (
        clk    => clk,
        rst    => rst,
        btn    => btn,
        btn_db => btn_db
    );

    sel_debouncer : entity work.btn_debounce
    port map (
        clk    => clk,
        rst    => rst,
        btn    => sel,
        btn_db => sel_db
    );

    seg_drv : entity work.seg_driver
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
                btn_prev <= '0';
                sel_prev <= '0';
            else
                btn_prev <= btn_db;
                sel_prev <= sel_db;
            end if;
        end if;
    end process;

    btn_stb <= btn_db and (not btn_prev);
    sel_stb <= sel_db and (not sel_prev);

    sel_msg : process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                msg_sel <= 0;
            elsif (sel_stb = '1') then
                if (msg_sel = NUM_MSGS-1) then
                    msg_sel <= 0;
                else
                    msg_sel <= msg_sel + 1;
                end if;
            end if;
        end if;
    end process;

    seg_data <= std_logic_vector(to_unsigned(msg_sel, 14));

end architecture;
