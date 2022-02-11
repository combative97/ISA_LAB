library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ABS_unit is
port(
	data : in std_logic_vector(63 downto 0);
	abs_value : out std_logic_vector(63 downto 0)
);
end entity;

architecture beh of ABS_unit is

signal abs_num : signed(63 downto 0);

begin

abs_p : process(data)

begin
	if(data(63) = '1') then 
		abs_num <= signed(not(data)) + x"0000000000000001";
	else
		abs_num <= signed(data);
	end if;

end process;

abs_value <= std_logic_vector(abs_num);

end beh;
