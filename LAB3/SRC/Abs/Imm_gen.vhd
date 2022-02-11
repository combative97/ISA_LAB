library ieee;
use ieee.std_logic_1164.all;

entity Imm_gen is
port
(
	instr : in std_logic_vector (31 downto 0);
	imm : out std_logic_vector (63 downto 0)
);
end entity;

architecture beh of Imm_gen is

signal opcode : std_logic_vector (6 downto 0);

begin

opcode <= instr (6 downto 0);

imm_process : process(instr,opcode) is

begin

case opcode is

when "0110111" => imm(63 downto 20) <= (others => instr(31)); imm(19 downto 0) <= instr(31 downto 12); --LUI
when "0010111" => imm(63 downto 20) <= (others => instr(31)); imm(19 downto 0) <= instr(31 downto 12); --AUIPC
when "1101111" => imm(63 downto 20) <= (others => instr(31)); imm(19) <= instr(31); imm(18 downto 11) <= instr(19 downto 12); imm(10) <= instr(20); imm(9 downto 0) <= instr(30 downto 21); --JAL
when "1100011" => imm(63 downto 12 ) <= (others => instr(31)); imm(11) <= instr(31); imm(10) <= instr(7); imm(9 downto 4) <= instr(30 downto 25); imm(3 downto 0) <= instr(11 downto 8); --BEQ
when "0000011" => imm(63 downto 12) <= (others => instr(31)); imm(11 downto 0) <= instr(31 downto 20); --LW
when "0100011" => imm(63 downto 12) <= (others => instr(31)); imm(11 downto 5) <= instr(31 downto 25); imm(4 downto 0) <= instr(11 downto 7); --SW
when "0010011" => imm(63 downto 12) <= (others => instr(31)); imm(11 downto 0) <= instr(31 downto 20); --I-Type
when others => imm <= (others => '0');

end case;

end process;

end beh;