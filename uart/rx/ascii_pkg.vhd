library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ascii_pkg is
    function to_ascii(c : character) return std_logic_vector;

    function to_ascii(s : string) return std_logic_vector;

end package;

package body ascii_pkg is
    function to_ascii(c : character) return std_logic_vector is
    begin
        return std_logic_vector(to_unsigned(character'pos(c), 8));
    end function;

    function to_ascii(s : string) return std_logic_vector is
        variable result : std_logic_vector(s'length * 8 - 1 downto 0);
    begin
        for i in s'range loop
            result((s'length - (i - s'low) - 1) * 8 + 7 downto (s'length - (i - s'low) - 1) * 8) := to_ascii(s(i));
        end loop;
        return result;
    end function;

end package body;
