library ieee;
use ieee.std_logic_1164.all;

entity uart_ctrl is
    port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        btn_stb : in  std_logic;
        tx_busy : in  std_logic;
        tx_out  : out std_logic_vector(7 downto 0);
        tx_stb  : out std_logic
    );
end entity;

architecture rtl of uart_ctrl is
    constant msg_ascii : std_logic_vector(55 downto 0) := X"68656C6C6F2120"; -- Reads "hello! " when converted from ascii
    
    constant MSG_MAX : integer := msg_ascii'length - 8;

    signal tx_ptr    : integer range 0 to MSG_MAX := MSG_MAX;
    signal tx_busy_i : std_logic := '0';
    signal tx_cont   : std_logic := '0';

    type ctrl_state_t is (idle, shift, busy);
    signal ctrl_state : ctrl_state_t := idle;

begin
    
    process (clk) is 
    begin
        if rising_edge(clk) then 
            if (rst = '1') then
                tx_busy_i  <= '0';
                tx_cont    <= '0';
                tx_stb     <= '0';
                tx_out     <= (others => '0');
                tx_ptr     <= MSG_MAX;
                ctrl_state <= idle;
            else
                tx_busy_i <= tx_busy;
                tx_stb    <= '0';

                case ctrl_state is 
                    when idle =>
                        if (btn_stb = '1' or tx_cont = '1') then
                            tx_out     <= msg_ascii(tx_ptr + 7 downto tx_ptr);
                            tx_stb     <= '1';
                            ctrl_state <= shift;
                        end if;

                    when shift =>
                        if (tx_ptr > 0) then 
                            tx_ptr <= tx_ptr - 8;
                        else
                            tx_ptr <= MSG_MAX;
                        end if;
                        ctrl_state <= busy;

                    when busy =>
                        if (tx_busy = '0' and tx_busy_i = '1') then  
                            if (tx_ptr = MSG_MAX) then 
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
