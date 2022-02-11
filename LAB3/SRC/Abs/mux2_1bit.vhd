library ieee;
use ieee.std_logic_1164.all;

entity mux2_1bit is
port
(
	A, B : in std_logic;
	S : in std_logic;
	Y : out std_logic
);
end entity;

architecture beh of mux2_1bit is

begin

mux_p : process(A,B,S) is

begin

case S is

when '0' => Y <= A;
when '1' => Y <= B;
when others => Y <= '0';

end case;

end process;

end beh;