library ieee;
use ieee.std_logic_1164.all;

entity led_test_sweep is
    port (
        clk : in  std_logic;
        led : out std_logic_vector(15 downto 0)
    );
end entity;

architecture rtl of led_test_sweep is
    signal cnt   : integer range 0 to 99999999 := 0;
    signal dir   : integer := 1;
    signal idx   : integer := 0;
begin

    process (clk) is
    begin
        if rising_edge(clk) then
            if (cnt >= 4999999) then
                if (idx = 14) then
                    dir <= -1;
                elsif (idx = 1) then
                    dir <= 1;
                end if;
                
                idx <= idx + dir;
                cnt <= 0;
            else
                cnt <= cnt + 1;
            end if;
            led      <= (others => '0');
            led(idx) <= '1';
        end if;
    end process;
    
end architecture;