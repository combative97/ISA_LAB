library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add is
port
(
	A,B: in std_logic_vector(63 downto 0);
	S : out std_logic_vector(63 downto 0)
);
end entity;

architecture beh of add is

signal sign_A,sign_B,sign_S : signed(63 downto 0);

begin

sign_S <= signed(A) + signed(B); 

S <= std_logic_vector(sign_S);

end beh;