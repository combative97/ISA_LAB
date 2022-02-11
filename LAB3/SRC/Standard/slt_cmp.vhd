library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity slt_cmp is
port
(
	A, B : in std_logic_vector(63 downto 0);
	slt : out std_logic_vector(63 downto 0)
);
end entity;

architecture beh of slt_cmp is

signal sign_a, sign_b : signed(63 downto 0);

begin

sign_a <= signed(A);
sign_b <= signed(B);

slt_process : process (sign_a, sign_b) 

begin

if (sign_a < sign_b) then slt <= x"0000000000000001";
else slt <= (others => '0');

end if;
end process;

end beh;