library ieee;
use ieee.std_logic_1164.all;

entity fifo is
    generic (
        FIFO_DEPTH : integer := 8;
        DATA_WIDTH : integer := 14
    );
    port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        wr_stb  : in  std_logic;
        wr_data : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        rd_stb  : in  std_logic;
        rd_data : out std_logic_vector(DATA_WIDTH-1 downto 0);
        full    : out std_logic;
        empty   : out std_logic
    );
end entity;

architecture rtl of fifo is
    type mem is array (0 to FIFO_DEPTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);

    signal buf : mem := (others => (others => '0'));
    
    signal wr_ptr  : integer range 0 to FIFO_DEPTH-1 := 0;
    signal rd_ptr  : integer range 0 to FIFO_DEPTH-1 := 0;
    signal cnt     : integer range 0 to FIFO_DEPTH   := 0;

    signal full_i  : std_logic := '0';
    signal empty_i : std_logic := '1';
    
begin

    full_i  <= '1' when cnt = FIFO_DEPTH else '0';
    empty_i <= '1' when cnt = 0 else '0';
    
    full  <= full_i;
    empty <= empty_i;

    process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                wr_ptr  <= 0;
                rd_ptr  <= 0;
                cnt     <= 0;
                buf     <= (others => (others => '0'));
                rd_data <= (others => '0');
            else
                if (wr_stb = '1' and full_i = '0') then
                    buf(wr_ptr) <= wr_data;
                    if (wr_ptr = FIFO_DEPTH-1) then
                        wr_ptr <= 0;
                    else
                        wr_ptr <= wr_ptr + 1;
                    end if;
                end if;
                
                if (rd_stb = '1' and empty_i = '0') then
                    rd_data <= buf(rd_ptr);
                    if (rd_ptr = FIFO_DEPTH-1) then
                        rd_ptr <= 0;
                    else
                        rd_ptr <= rd_ptr + 1;
                    end if;
                end if;
                
                if (wr_stb = '1' and full_i = '0') and (rd_stb = '0' or empty_i = '1') then
                    cnt <= cnt + 1;
                elsif (rd_stb = '1' and empty_i = '0') and (wr_stb = '0' or full_i = '1') then
                    cnt <= cnt - 1;
                end if;
            end if;
        end if;
    end process;

end architecture;