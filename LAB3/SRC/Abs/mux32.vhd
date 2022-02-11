library ieee;
use ieee.std_logic_1164.all;

entity mux32 is
port(
	in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16 : in std_logic_vector(63 downto 0);
	in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31,in32 : in std_logic_vector(63 downto 0);
	sel : in std_logic_vector(4 downto 0);
	out_mux : out std_logic_vector(63 downto 0)
);
end entity;

architecture beh of mux32 is

begin

with sel select

out_mux <= 
in1 when "00000",
in2 when "00001",
in3 when "00010",
in4 when "00011",
in5 when "00100",
in6 when "00101",
in7 when "00110",
in8 when "00111",
in9 when "01000",
in10 when "01001",
in11 when "01010",
in12 when "01011",
in13 when "01100",
in14 when "01101",
in15 when "01110",
in16 when "01111",
in17 when "10000",
in18 when "10001",
in19 when "10010",
in20 when "10011",
in21 when "10100",
in22 when "10101",
in23 when "10110",
in24 when "10111",
in25 when "11000",
in26 when "11001",
in27 when "11010",
in28 when "11011",
in29 when "11100",
in30 when "11101",
in31 when "11110",
in32 when "11111",
in1 when others;

end beh;
