library ieee;
use ieee.std_logic_1164.all;

entity uart_top is
    port (
        clk   : in  std_logic;
        rst   : in  std_logic;
        btn   : in  std_logic;
        rx    : in  std_logic;
        tx    : out std_logic
    );
end entity;

architecture rtl of uart_top is
    signal tx_stb  : std_logic := '0';
    signal tx_busy : std_logic := '0';
    signal tx_data : std_logic_vector(7 downto 0) := (others => '0');

    signal btn_db   : std_logic := '0';
    signal btn_stb  : std_logic := '0';
    signal btn_prev : std_logic := '0';
begin

    btn_debouncer : entity work.btn_debounce
    port map (
        clk    => clk,
        rst    => rst,
        btn    => btn,
        btn_db => btn_db
    );

    edge_detect : process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                btn_prev <= '0';
            else
                btn_prev <= btn_db;
            end if;
        end if;
    end process;
    
    btn_stb <= btn_db and (not btn_prev);

    tx_uart : entity work.uart_tx
    port map (
        clk   => clk, 
        rst   => rst, 
        din   => tx_data, 
        stb   => tx_stb,
        busy  => tx_busy, 
        tx    => tx
    );    
    
    ctrl_uart : entity work.uart_ctrl
    port map (
        clk     => clk,
        rst     => rst,
        btn_stb => btn_stb,
        tx_busy => tx_busy,
        tx_out  => tx_data,
        tx_stb  => tx_stb
    );

end architecture;