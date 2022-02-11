library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
port
(
	A, B, C, D : in std_logic_vector(63 downto 0);
	S : in std_logic_vector(1 downto 0);
	Y : out std_logic_vector(63 downto 0)
);
end entity;

architecture beh of mux4 is

begin

mux_p : process(A,B,C,D,S) is

begin

case S is

when "00" => Y <= A;
when "01" => Y <= B;
when "10" => Y <= C;
when "11" => Y <= D;
when others => Y <= (OTHERS => '0');

end case;

end process;

end beh;