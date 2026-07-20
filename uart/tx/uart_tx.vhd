library ieee;
use ieee.std_logic_1164.all;

entity uart_tx is
    generic(
        CLK_FREQ  : integer := 100000000;
        BAUD      : integer := 115200
    );
    port (
        clk   : in  std_logic;
        rst   : in  std_logic;
        din   : in  std_logic_vector(7 downto 0);
        stb   : in  std_logic;
        busy  : out std_logic;
        tx    : out std_logic
    );
end entity;

architecture rtl of uart_tx is
    constant CLKS_PER_BIT : integer := CLK_FREQ / BAUD;

    type tx_state_t is (idle, start, data, stop);
    
    signal tx_state : tx_state_t := idle;

    signal msg : std_logic_vector(7 downto 0) := (others => '0');

    signal cnt : integer range 0 to CLKS_PER_BIT-1 := 0;
    signal idx : integer range 0 to 7 := 0;
begin

    process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                msg      <= (others => '0');
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
                                idx      <= 0;
                                tx_state <= stop;
                            else
                                idx <= idx + 1;
                            end if;
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
