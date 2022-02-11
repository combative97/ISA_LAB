library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_MEM is
    port(
        address : in  std_logic_vector(63 downto 0);
        dout    : out std_logic_vector(31 downto 0)
    );
end entity Instruction_MEM;

architecture RTL of Instruction_MEM is
type MEMORY_16_4 is array (0 to 21) of std_logic_vector(31 downto 0);
constant my_Rom : MEMORY_16_4 := (
"00000000011100000000100000010011",
"00001111110000010000001000010111",
"11111111110000100000001000010011",
"00001111110000010000001010010111",
"00000001000000101000001010010011",
"01000000000000000000011010110111",
"11111111111101101000011010010011",
"00000010000010000000100001100011",
"00000000000000100010010000000011",
"01000001111101000101010010010011",
"00000000100101000100010100110011",
"00000000000101001111010010010011",
"00000000100101010000010100110011",
"00000000010000100000001000010011",
"11111111111110000000100000010011",
"00000000110101010010010110110011",
"11111100000001011000111011100011",
"00000000000001010000011010110011",
"11111101010111111111000011101111",
"00000000110100101010000000100011",
"00000000000000000000000011101111",
"00000000000000000000000000010011"
);

begin

main :process(address)
variable tmp: unsigned (63 downto 0);
begin
tmp:=unsigned(address)-x"0000000000400000";

--if(tmp > x"0000000000000054") then tmp := x"0000000000000054"; end if;

tmp := "00" & tmp(63 downto 2);
dout <= my_rom(to_integer(tmp));
end process main;

end architecture RTL;
