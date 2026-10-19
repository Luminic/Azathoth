library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mul is port (
    a: in std_logic_vector(31 downto 0);
    b: in std_logic_vector(31 downto 0);
    p: out std_logic_vector(31 downto 0));
end mul;

architecture struct of mul is
begin
    p <= std_logic_vector(unsigned(a)*unsigned(b));
end struct;