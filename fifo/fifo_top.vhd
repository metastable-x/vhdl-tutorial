library ieee;
use ieee.std_logic_1164.all;

entity fifo_top is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        sw  : in  std_logic_vector(13 downto 0);
        rd  : in  std_logic;
        wr  : in  std_logic;
        led : out std_logic_vector(15 downto 0);
        seg : out std_logic_vector(6 downto 0);
        dp  : out std_logic;
        an  : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of fifo_top is
    constant FIFO_DEPTH : integer := 16;
    
    signal rd_db   : std_logic;
    signal wr_db   : std_logic;
    signal rd_prev : std_logic := '0';
    signal wr_prev : std_logic := '0';

    signal wr_en   : std_logic;
    signal rd_en   : std_logic;
    signal rd_data : std_logic_vector(13 downto 0) := (others => '0');
    signal full    : std_logic;
    signal empty   : std_logic;
    
begin

    rd_debouncer : entity work.btn_debounce
        port map (
            clk    => clk,
            rst    => rst,
            btn    => rd,
            btn_db => rd_db
        );
    
    wr_debouncer : entity work.btn_debounce
        port map (
            clk    => clk,
            rst    => rst,
            btn    => wr,
            btn_db => wr_db
        );
    
    edge_detect : process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                rd_prev <= '0';
                wr_prev <= '0';
            else
                rd_prev <= rd_db;
                wr_prev <= wr_db;
            end if;
        end if;
    end process;
    
    wr_en <= rd_db and (not rd_prev);
    rd_en <= wr_db and (not wr_prev);
    
    fifo_inst : entity work.fifo
        generic map (
            FIFO_DEPTH => FIFO_DEPTH
        )
        port map (
            clk     => clk,
            rst     => rst,
            wr_en   => wr_en,
            wr_data => sw,
            rd_en   => rd_en,
            rd_data => rd_data,
            full    => full,
            empty   => empty
        );
    
    seg_inst : entity work.seg_driver
        port map (
            clk     => clk,
            rst     => rst,
            data_in => rd_data,
            seg     => seg,
            dp      => dp,
            an      => an
        );
    
    led(13 downto 0) <= sw;
    led(14)          <= full;
    led(15)          <= empty;

end architecture;