library ieee;
use ieee.std_logic_1164.all;

entity led_test_single is
    port (
        clk : in  std_logic;
        led : out std_logic_vector(15 downto 0)
    );
end entity;

architecture rtl of led_test_single is
begin
    led <= (0 => '1', others => '0');
    
end architecture;
