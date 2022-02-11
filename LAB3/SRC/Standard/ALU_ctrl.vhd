library ieee;
use ieee.std_logic_1164.all;

entity ALU_ctrl is
port
(
	func3 : in std_logic_vector (2 downto 0);
	func7 : in std_logic;
	AluOP : in std_logic_vector(1 downto 0);
	AluCtrl : out std_logic_vector (3 downto 0)
);
end entity;

architecture beh of ALU_ctrl is

signal tmp_code : std_logic_vector(3 downto 0); --tmp aluctrl

begin

PLA : process(func3,AluOP) is

begin

tmp_code <= "0010"; --initialize with add

case AluOP is

when "00" => if (func3 = "010") then tmp_code <= "0010"; end if;
when "01" => if (func3 = "000") then tmp_code <= "1000"; end if;
when "10" => if (func3 = "000") then tmp_code <= "0010"; elsif (func3 = "010") then tmp_code <= "0100"; elsif (func3 = "100") then tmp_code <= "0001"; end if;
when "11" => if (func3 = "000") then tmp_code <= "0010"; elsif (func3 = "111") then tmp_code <= "0000"; elsif (func3 = "101") then tmp_code <= "0011"; end if;
when others => tmp_code <= "0010";

end case;

end process;

AluCtrl <= tmp_code;

end beh;


