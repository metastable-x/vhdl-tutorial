library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seg_driver is
    port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        data_in : in  std_logic_vector(13 downto 0);
        seg     : out std_logic_vector(6 downto 0);
        an      : out std_logic_vector(3 downto 0);
        dp      : out std_logic
    );
end entity;

architecture rtl of seg_driver is
    type svn_seg is array (0 to 9) of std_logic_vector (6 downto 0);
    type int_array is array (natural range <>) of integer;
    type digit_lut_type is array (0 to 9999) of int_array(0 to 3);

    constant seg_val : svn_seg := (
        0 => B"1000000",
        1 => B"1111001",
        2 => B"0100100",
        3 => B"0110000",
        4 => B"0011001",
        5 => B"0010010",
        6 => B"0000010",
        7 => B"1111000",
        8 => B"0000000",
        9 => B"0010000"
    );

    signal val_arr : int_array(0 to 3) := (others => 0);
    signal val     : integer := 0;
    signal cnt     : integer := 0;
    signal idx     : integer := 0;

    function generate_digit_lut return digit_lut_type is
        variable lut : digit_lut_type;
        variable temp : integer;
    begin
        for i in 0 to 9999 loop
            temp := i;
            lut(i)(0) := temp mod 10;
            temp := temp / 10;
            lut(i)(1) := temp mod 10;
            temp := temp / 10;
            lut(i)(2) := temp mod 10;
            temp := temp / 10;
            lut(i)(3) := temp mod 10;
        end loop;
        return lut;
    end function;

    constant digit_lut : digit_lut_type := generate_digit_lut;

begin

    data_sat : process (clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                val <= 0;
            else
                if (unsigned(data_in) > 9999) then
                    val <= 9999;
                else
                    val <= to_integer(unsigned(data_in));
                end if;
            end if;
        end if;
    end process;

    digit_spliter : process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                val_arr <= (others => 0);
            else
                val_arr <= digit_lut(val);
            end if;
        end if;
    end process;

    an_shift : process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                cnt  <= 0;
                idx  <= 0;
            else
                if (cnt = 99999) then 
                    cnt  <= 0;
                    if (idx = 3) then
                        idx <= 0;
                    else
                        idx <= idx + 1;
                    end if;
                else
                    cnt <= cnt + 1;
                end if;
            end if;
        end if;
    end process;

    seg_display : process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                an  <= B"0000";
                seg <= seg_val(0);
            else
                case idx is
                    when 0 =>
                        an  <= B"1110"; 
                        seg <= seg_val(val_arr(0));
                    when 1 => 
                        an  <= B"1101"; 
                        seg <= seg_val(val_arr(1));
                    when 2 =>
                        an  <= B"1011";
                        seg <= seg_val(val_arr(2));
                    when 3 =>
                        an  <= B"0111";
                        seg <= seg_val(val_arr(3));
                    when others =>
                        an  <= B"0000";
                        seg <= seg_val(0);
                end case;
            end if;
        end if;
    end process;

    dp <= '1';

end architecture;
