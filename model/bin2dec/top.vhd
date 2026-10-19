library ieee;
use ieee.std_logic_1164.all;

entity top is port (
    CLK100MHZ: in std_logic;
    SW: in std_logic_vector(15 downto 0);
    LED: out std_logic_vector(15 downto 0);
    CA, AN: out std_logic_vector(7 downto 0));
end top;

architecture struct of top is
    signal nibbles: std_logic_vector(31 downto 0);
begin

nibbles<=x"0000"&SW;

LED<=SW;

seven_seg_controller: entity work.seven_seg_control port map (
    clk=>CLK100MHZ,
    nibbles=>nibbles,
    AN=>AN,
    CA=>CA
);

end struct;