library ieee;
use ieee.std_logic_1164.all;

entity dff_tb is
end entity;

architecture tb of dff_tb is
    signal clk : std_logic := '0';
    signal d   : std_logic := '0';
    signal q   : std_logic;
begin

    clk <= not clk after 5 ns;

    dff : entity work.dff
    port map(
        clk => clk,
        d   => d,
        q   => q
    );

    process is 
    begin
        wait for 20 ns;
        d <= '1';
        wait for 80 ns;
        d <= '0';
        wait;
    end process;

end architecture;
