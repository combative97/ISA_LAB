library ieee;
use ieee.std_logic_1164.all;

entity mux8 is
port
(
	A, B, C, D, E, F, G, H : in std_logic_vector(63 downto 0);
	S : in std_logic_vector(2 downto 0);
	Y : out std_logic_vector(63 downto 0)
);
end entity;

architecture beh of mux8 is

begin

mux_p : process(A,B,C,D,E,F,G,H,S) is

begin

case S is

when "000" => Y <= A;
when "001" => Y <= B;
when "010" => Y <= C;
when "011" => Y <= D;
when "100" => Y <= E;
when "101" => Y <= F;
when "110" => Y <= G;
when "111" => Y <= H;
when others => Y <= (OTHERS => '0');

end case;

end process;

end beh;
