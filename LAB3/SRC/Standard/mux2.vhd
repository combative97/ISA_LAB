library ieee;
use ieee.std_logic_1164.all;

entity mux2 is GENERIC(N : INTEGER);
port
(
	A, B : in std_logic_vector(N-1 downto 0);
	S : in std_logic;
	Y : out std_logic_vector(N-1 downto 0)
);
end entity;

architecture beh of mux2 is

begin

mux_p : process(A,B,S) is

begin

case S is

when '0' => Y <= A;
when '1' => Y <= B;
when others => Y <= (others => '0');

end case;

end process;

end beh;
