library ieee;
use ieee.std_logic_1164.all;

entity led_test_strobe is
    port (
        clk : in  std_logic;
        led : out std_logic_vector(15 downto 0)
    );
end entity;

architecture rtl of led_test_strobe is
    signal cnt : integer range 0 to 99999999 := 0;
begin

    process (clk) is
    begin
        if rising_edge(clk) then
            if (cnt >= 49999999) then
                led(0) <= '1';
            else
                led(0) <= '0';
            end if;
            cnt <= cnt + 1;
        end if;
    end process;

    led(15 downto 1) <= '0';
    
end architecture;