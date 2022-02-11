library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_mem is

	PORT( address, data_in : in std_logic_vector(63 downto 0);
		data_out : out std_logic_vector(63 downto 0);
			wr_en, rd_en : std_logic);
end entity;

architecture beh of data_mem is

type mem is array (0 to 7) of std_logic_vector(63 downto 0);
signal tmp_sig : unsigned(63 downto 0); 

signal ram : mem := (
	x"000000000000000A",
	x"FFFFFFFFFFFFFFD1",
	x"0000000000000016",
	x"FFFFFFFFFFFFFFFD",
	x"000000000000000F",
	x"000000000000001B",
	x"FFFFFFFFFFFFFFFC",
	x"0000000000000000");

begin

addr_process : process (address)
variable tmp_var : unsigned(63 downto 0);
begin
if (address = x"000000001001001C") then tmp_sig <= x"0000000000000007";
else
tmp_var := unsigned(address) - x"0000000010010000";
tmp_sig <= "00" & tmp_var (63 downto 2);
end if;
end process;

mem_process : process(tmp_sig)
begin
		if(wr_en='1') then
			ram(to_integer(tmp_sig)) <= data_in;
		
		elsif(rd_en='1') then
			data_out <= ram(to_integer(tmp_sig));
		end if;
end process;

end beh;
		
