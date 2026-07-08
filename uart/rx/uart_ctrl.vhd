library ieee;
use ieee.std_logic_1164.all;
use work.ascii_pkg.all;
use work.msg_pkg.all;

entity uart_ctrl is
    port (
        clk      : in  std_logic;
        rst      : in  std_logic;

        send_stb : in  std_logic;
        tx_sel   : in  integer range 0 to NUM_MSGS-1;

        rx_in   : in  std_logic_vector(7 downto 0);
        rx_stb  : in  std_logic;

        tx_busy : in  std_logic;
        tx_out  : out std_logic_vector(7 downto 0);
        tx_stb  : out std_logic
    );
end entity;

architecture rtl of uart_ctrl is
    type ctrl_state_t is (idle, shift, busy);
    signal ctrl_state : ctrl_state_t := idle;

    signal tx_ptr    : integer   := ptr_max(0);
    signal tx_cont   : std_logic := '0';
    signal tx_busy_i : std_logic := '0';

    signal tx_sel_i : integer range 0 to NUM_MSGS-1;

begin

    process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                tx_busy_i  <= '0';
                tx_cont    <= '0';
                tx_ptr     <= ptr_max(0);
                tx_stb     <= '0';
                tx_out     <= (others => '0');
                tx_sel_i  <= tx_sel;
                ctrl_state <= idle;
            else
                tx_stb    <= '0';
                tx_busy_i <= tx_busy;
                tx_sel_i <= tx_sel;

                case ctrl_state is
                    when idle =>
                        if (tx_sel_i /= tx_sel) then
                            tx_ptr     <= ptr_max(tx_sel);
                        elsif (send_stb = '1' or tx_cont = '1') then
                            tx_out     <= get_msg(tx_sel, tx_ptr);
                            tx_stb     <= '1';
                            ctrl_state <= shift;
                        elsif (tx_busy = '0' and rx_stb = '1') then
                            tx_out <= rx_in;
                            tx_stb <= '1';
                        end if;

                    when shift =>
                        if (tx_ptr > 0) then
                            tx_ptr <= tx_ptr - 8;
                        else
                            tx_ptr <= ptr_max(tx_sel);
                        end if;
                        ctrl_state <= busy;

                    when busy =>
                        if (tx_busy = '0' and tx_busy_i = '1') then
                            if (tx_ptr = ptr_max(tx_sel)) then
                                tx_cont <= '0';
                            else
                                tx_cont <= '1';

                            end if;
                            ctrl_state <= idle;
                        end if;
                end case;
            end if;
        end if;
    end process;
end architecture;