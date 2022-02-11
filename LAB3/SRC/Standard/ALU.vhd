library ieee;
use ieee.std_logic_1164.all;

entity ALU is
port
(
	data1, data2 : in std_logic_vector(63 downto 0);
	alu_ctrl : in std_logic_vector (3 downto 0);
	out_data : out std_logic_vector (63 downto 0);
	zero_flag : out std_logic
);
end entity;

architecture beh of ALU is

component add is
port
(
	A,B: in std_logic_vector(63 downto 0);
	S : out std_logic_vector(63 downto 0)
);
end component;

component slt_cmp is
port
(
	A, B : in std_logic_vector(63 downto 0);
	slt : out std_logic_vector(63 downto 0)
);
end component;

component b_shifter is
      port (
            shift   : in  std_logic_vector(4 downto 0);
            input   : in  std_logic_vector (63 downto 0);
            output  : out std_logic_vector (63 downto 0) );
end component;

component mux2_1bit is
port
(
	A, B: in std_logic;
	S : in std_logic;
	Y : out std_logic
);
end component;

component mux8 is
port
(
	A, B, C, D, E, F, G, H : in std_logic_vector(63 downto 0);
	S : in std_logic_vector(2 downto 0);
	Y : out std_logic_vector(63 downto 0)
);
end component;

signal out_add, out_bshft, out_and, out_xor, out_slt, out_alu: std_logic_vector(63 downto 0);

begin

compare_slt : slt_cmp port map(data1, data2, out_slt);
adder : add port map(data1, data2, out_add);
barrel_shifter : b_shifter port map(data2(4 downto 0), data1, out_bshft);

out_and <= data1 and data2;
out_xor <= data1 xor data2;

mux_alu : mux8 port map(out_and, out_xor, out_add, out_bshft, out_slt, x"0000000000000000", x"0000000000000000", x"0000000000000000", alu_ctrl(2 downto 0), out_alu);

out_data <= out_alu;

zero_flag_process : process(out_alu)

	begin

		if (out_alu = x"0000000000000000") then zero_flag <= '1'; else zero_flag <= '0'; end if;
end process;

end beh;

