library ieee;
use ieee.std_logic_1164.all;
use work.ascii_pkg.all;

package msg_pkg is

    constant NUM_MSGS : integer := 6;

    constant MSG0 : string := "Hello! " & LF & LF;
    constant MSG1 : string :=
        "  /$$$$$$$$ /$$       /$$                 /$$                 /$$      /$$             /$$                           /$$               /$$       /$$           " & LF &
        " |__  $$__/| $$      |__/                |__/                | $$$    /$$$            | $$                          | $$              | $$      | $$           " & LF &
        "    | $$   | $$$$$$$  /$$  /$$$$$$$       /$$  /$$$$$$$      | $$$$  /$$$$  /$$$$$$  /$$$$$$    /$$$$$$   /$$$$$$$ /$$$$$$    /$$$$$$ | $$$$$$$ | $$  /$$$$$$  " & LF &
        "    | $$   | $$__  $$| $$ /$$_____/      | $$ /$$_____/      | $$ $$/$$ $$ /$$__  $$|_  $$_/   |____  $$ /$$_____/|_  $$_/   |____  $$| $$__  $$| $$ /$$__  $$ " & LF &
        "    | $$   | $$  \ $$| $$|  $$$$$$       | $$|  $$$$$$       | $$  $$$| $$| $$$$$$$$  | $$      /$$$$$$$|  $$$$$$   | $$      /$$$$$$$| $$  \ $$| $$| $$$$$$$$ " & LF &
        "    | $$   | $$  | $$| $$ \____  $$      | $$ \____  $$      | $$\  $ | $$| $$_____/  | $$ /$$ /$$__  $$ \____  $$  | $$ /$$ /$$__  $$| $$  | $$| $$| $$_____/ " & LF &
        "    | $$   | $$  | $$| $$ /$$$$$$$/      | $$ /$$$$$$$/      | $$ \/  | $$|  $$$$$$$  |  $$$$/|  $$$$$$$ /$$$$$$$/  |  $$$$/|  $$$$$$$| $$$$$$$/| $$|  $$$$$$$ " & LF &
        "    |__/   |__/  |__/|__/|_______/       |__/|_______/       |__/     |__/ \_______/   \___/   \_______/|_______/    \___/   \_______/|_______/ |__/ \_______/ " & LF & LF;

    constant MSG2 : string :=
        "  _      _ _                          _    _____       _                   _ _          _  " & LF &
        " | |    (_) |                        | |  / ____|     | |                 (_) |        | | " & LF &
        " | |     _| | _____    __ _ _ __   __| | | (___  _   _| |__  ___  ___ _ __ _| |__   ___| | " & LF &
        " | |    | | |/ / _ \  / _` | '_ \ / _` |  \___ \| | | | '_ \/ __|/ __| '__| | '_ \ / _ \ | " & LF &
        " | |____| |   <  __/ | (_| | | | | (_| |  ____) | |_| | |_) \__ \ (__| |  | | |_) |  __/_| " & LF &
        " |______|_|_|\_\___|  \__,_|_| |_|\__,_| |_____/ \__,_|_.__/|___/\___|_|  |_|_.__/ \___(_) " & LF &
        "                                                                                           " & LF &
        "                                                                                           " & LF & LF;

    constant MSG3 : string := 
        "The FitnessGram Pacer Test is a multistage aerobic capacity test that progressively gets more difficult as it continues. " & LF &
        "The 20 meter pacer test will begin in 30 seconds. Line up at the start. "                                                  & LF &
        "The running speed starts slowly, but gets faster each minute after you hear this signal. "                                 & LF &
        "A single lap should be completed each time you hear this sound. "                                                          & LF &
        "Remember to run in a straight line, and run as long as possible. "                                                         & LF &
        "The second time you fail to complete a lap before the sound, your test is over. "                                          & LF &
        "The test will begin on the word start. On your mark, get ready, start."                                                    & LF & LF;

    constant MSG4 : string :=
        " .___                   ___.                                            .___             __  .__            __  .__                 .___               __                                             _____                      .__       .___           " & LF &
        " |   | _____    _____   \_ |__   ____   ____  ____   _____   ____     __| _/____ _____ _/  |_|  |__       _/  |_|  |__   ____     __| _/____   _______/  |________  ____ ___.__. ___________    _____/ ____\ __  _  _____________|  |    __| _/______     " & LF &
        " |   | \__  \  /     \   | __ \_/ __ \_/ ___\/  _ \ /     \_/ __ \   / __ |/ __ \\__  \\   __\  |  \      \   __\  |  \_/ __ \   / __ |/ __ \ /  ___/\   __\_  __ \/  _ <   |  |/ __ \_  __ \  /  _ \   __\  \ \/ \/ /  _ \_  __ \  |   / __ |/  ___/     " & LF &
        " |   |  / __ \|  Y Y  \  | \_\ \  ___/\  \__(  <_> )  Y Y  \  ___/  / /_/ \  ___/ / __ \|  | |   Y  \      |  | |   Y  \  ___/  / /_/ \  ___/ \___ \  |  |  |  | \(  <_> )___  \  ___/|  | \/ (  <_> )  |     \     (  <_> )  | \/  |__/ /_/ |\___ \      " & LF &
        " |___| (____  /__|_|  /  |___  /\___  >\___  >____/|__|_|  /\___  > \____ |\___  >____  /__| |___|  / /\   |__| |___|  /\___  > \____ |\___  >____  > |__|  |__|   \____// ____|\___  >__|     \____/|__|      \/\_/ \____/|__|  |____/\____ /____  > /\  " & LF &
        "            \/      \/       \/     \/     \/            \/     \/       \/    \/     \/          \/  )/             \/     \/       \/    \/     \/                     \/         \/                                                      \/    \/  \/  " & LF & LF;

    constant MSG5 : string :=
        "  __   __     ______     __     __        ______   __  __     __     ______        __     ______        ______   ______     _____        ______     ______     ______     __     __   __     ______    "    & LF &
        " /\ ""-.\ \   /\  __ \   /\ \  _ \ \      /\__  _\ /\ \_\ \   /\ \   /\  ___\      /\ \   /\  ___\      /\  == \ /\  __ \   /\  __-.     /\  == \   /\  __ \   /\  ___\   /\ \   /\ ""-.\ \   /\  ___\   "  & LF &
        " \ \ \-.  \  \ \ \/\ \  \ \ \/ "".\ \     \/_/\ \/ \ \  __ \  \ \ \  \ \___  \     \ \ \  \ \___  \     \ \  _-/ \ \ \/\ \  \ \ \/\ \    \ \  __<   \ \  __ \  \ \ \____  \ \ \  \ \ \-.  \  \ \ \__ \  "   & LF &
        "  \ \_\\""\_\  \ \_____\  \ \__/"".~\_\       \ \_\  \ \_\ \_\  \ \_\  \/\_____\     \ \_\  \/\_____\     \ \_\    \ \_____\  \ \____-     \ \_\ \_\  \ \_\ \_\  \ \_____\  \ \_\  \ \_\\""\_\  \ \_____\ " & LF &
        "   \/_/ \/_/   \/_____/   \/_/   \/_/        \/_/   \/_/\/_/   \/_/   \/_____/      \/_/   \/_____/      \/_/     \/_____/   \/____/      \/_/ /_/   \/_/\/_/   \/_____/   \/_/   \/_/ \/_/   \/_____/ "    & LF & LF;


    constant MSG_LENS : integer_vector(0 to NUM_MSGS-1) := (
        MSG0'length,
        MSG1'length,
        MSG2'length,
        MSG3'length,
        MSG4'length,
        MSG5'length
    );

    function get_msg(sel : integer; ptr : integer) return std_logic_vector;
    function msg_max(sel : integer) return integer;

end package;

package body msg_pkg is

    function get_msg(sel : integer; ptr : integer) return std_logic_vector is
    begin
        case sel is
            when 0      => return to_ascii(MSG0)(ptr+7 downto ptr);
            when 1      => return to_ascii(MSG1)(ptr+7 downto ptr);
            when 2      => return to_ascii(MSG2)(ptr+7 downto ptr);
            when 3      => return to_ascii(MSG3)(ptr+7 downto ptr);
            when 4      => return to_ascii(MSG4)(ptr+7 downto ptr);
            when 5      => return to_ascii(MSG5)(ptr+7 downto ptr);
            when others => return x"00";
        end case;
    end function;

    function msg_max(sel : integer) return integer is
    begin
        return MSG_LENS(sel) * 8 - 8;
    end function;

end package body;
