library ieee;
use ieee.std_logic_1164.all;

entity btn_debounce is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        btn    : in  std_logic;
        btn_db : out std_logic
    );
end entity;

architecture rtl of btn_debounce is
    type db_state is (IDLE, PRESSED);   

    constant CNT_MAX : integer := 999999;

    signal state : db_state := IDLE;

    signal cnt : integer range 0 to CNT_MAX := 0;

begin

    process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                state  <= IDLE;
                cnt    <= 0;
                btn_db <= '0';
            else
                case state is
                    when IDLE =>
                        btn_db <= '0';
                        if (btn = '1') then
                            if (cnt = CNT_MAX) then
                                state  <= PRESSED;
                                btn_db <= '1';
                                cnt    <= 0;
                            else
                                cnt <= cnt + 1;
                            end if;
                        else
                            cnt <= 0;
                        end if;

                    when PRESSED =>
                        btn_db <= '1';
                        if (btn = '0') then
                            if (cnt = CNT_MAX) then
                                state  <= IDLE;
                                btn_db <= '0';
                                cnt    <= 0;
                            else
                                cnt <= cnt + 1;
                            end if;
                        else
                            cnt <= 0;
                        end if;
                end case;
            end if;
        end if;
    end process;

end architecture;