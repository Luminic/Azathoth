library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_seg_control is port (
    clk: in std_logic;
    nibbles: in std_logic_vector(31 downto 0);
    AN: out std_logic_vector(7 downto 0);
    CA: out std_logic_vector(7 downto 0));
end seven_seg_control;

architecture struct of seven_seg_control is
    signal digit: unsigned(2 downto 0) := "000";
    signal clk_div: unsigned(19 downto 0) := (others => '0');
    signal current_nibble: std_logic_vector(3 downto 0);
    signal seg, sel: std_logic_vector(7 downto 0);
    signal sel_on: std_logic_vector(7 downto 0);
begin

CA<=seg;
AN<=sel;

clk_div_proc: process (clk) is
begin
    if rising_edge(clk) then
        if clk_div = x"1869F" then --divide from 100MHz to 1KHz
            clk_div <= (others => '0');
        else
            clk_div <= clk_div+1;
        end if;
    end if;
end process;

increment_digit_proc: process (clk) is
begin
    if rising_edge(clk) then
        if clk_div = x"00000" then
            digit <= digit+1;
        end if;
    end if;
end process;

--select active anode
--sel<=(to_integer(digit)=>'0', others=>'1');
set_selection: process (digit) is
    variable temp: std_logic_vector(7 downto 0);
begin
    temp := (others=>'1');
    temp(to_integer(digit)) := '0';
    sel<=temp;
end process;

--select value to decode based on current digit
current_nibble<=nibbles(4*to_integer(digit)+3 downto 4*to_integer(digit));

seg(0)<='1';
set_segments: process (current_nibble, digit, sel_on) is
begin
    if sel_on(to_integer(digit))='1' then
        case current_nibble is
            when "0000" => seg(7 downto 1) <= "0000001";
            when "0001" => seg(7 downto 1) <= "1001111";
            when "0010" => seg(7 downto 1) <= "0010010";
            when "0011" => seg(7 downto 1) <= "0000110";
            when "0100" => seg(7 downto 1) <= "1001100";
            when "0101" => seg(7 downto 1) <= "0100100";
            when "0110" => seg(7 downto 1) <= "0100000";
            when "0111" => seg(7 downto 1) <= "0001111";
            when "1000" => seg(7 downto 1) <= "0000000";
            when "1001" => seg(7 downto 1) <= "0000100";
            when "1010" => seg(7 downto 1) <= "0001000";
            when "1011" => seg(7 downto 1) <= "1100000";
            when "1100" => seg(7 downto 1) <= "0110001";
            when "1101" => seg(7 downto 1) <= "1000010";
            when "1110" => seg(7 downto 1) <= "0110000";
            when "1111" => seg(7 downto 1) <= "0111000";
        end case;
    else
        seg(7 downto 1) <= (others => '1');
    end if;
end process;

sel_on(7) <= '1' when nibbles(31 downto 28)/=x"0" else '0';
propogate_off: for i in 6 downto 1 generate
    sel_on(i)<='1' when (sel_on(i+1)='1' or nibbles(4*i+3 downto 4*i)/=x"0") else '0';
end generate;
sel_on(0) <= '1';

end struct;