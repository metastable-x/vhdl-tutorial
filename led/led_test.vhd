library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity led_test is
    port (
        clk : in  std_logic;
        led : out std_logic_vector(15 downto 0)
    );
end entity;

architecture rtl of led_test is
    signal cnt : integer range 0 to 99999999 := 0;
    signal val : integer range 0 to 65535    := 0;
begin

    process (clk) is
    begin
        if rising_edge(clk) then
            if (cnt >= 24999999) then
                val <= val + 1;
                cnt <= 0;
            else
                cnt <= cnt + 1;
            end if;
            led <= std_logic_vector(to_unsigned(val, led'length));
        end if;
    end process;
    
end architecture;