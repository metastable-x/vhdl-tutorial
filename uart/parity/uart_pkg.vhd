library ieee;
use ieee.std_logic_1164.all;

package uart_pkg is

    constant CLK_FREQ : integer := 100000000;
    constant BAUD     : integer := 115200;

    constant CLKS_PER_BIT : integer := CLK_FREQ / BAUD;

    type uart_state_t is (idle, start, data, par, stop);

    function parity_calc(msg : std_logic_vector; parity : string) return std_logic; 
    -- PARITY : "NONE", "EVEN", "ODD", "MARK", or "SPACE"

end package;

package body uart_pkg is

    function parity_calc(msg : std_logic_vector; parity : string) return std_logic is
        variable p : std_logic := '0';
    begin
        if (parity = "MARK") then
            return '1';
        elsif (parity = "SPACE") then
            return '0';
        else
            for i in msg'range loop
                p := p xor msg(i);
            end loop;
            if (parity = "ODD") then
                p := not p;
            end if;
            return p;
        end if;
    end function;

end package body;
