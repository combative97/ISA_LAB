library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity eq_cmp is
port
(
	A, B : in std_logic_vector(63 downto 0);
	eq : out std_logic
);
end entity;

architecture beh of eq_cmp is

signal sign_a, sign_b : signed(63 downto 0);

begin

sign_a <= signed(A);
sign_b <= signed(B);

eq_process : process (sign_a, sign_b) 

begin

if (sign_a = sign_b) then eq <= '1';
else eq <= '0';

end if;
end process;

end beh;

