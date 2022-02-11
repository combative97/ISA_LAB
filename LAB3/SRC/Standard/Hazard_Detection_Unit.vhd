library ieee;
use ieee.std_logic_1164.all;

entity Hazard_Detection_Unit is
	PORT(rs1, rs2, rd_old : in std_logic_vector(4 downto 0);
		ID_EX_MemRead, branch_bit, jump_bit : in std_logic;
		PC_Write, IF_ID_Write, Flush_Pipe:out std_logic;
		control_zero : out std_logic);
end entity;

architecture RTL of Hazard_Detection_Unit is

begin

Hazard: process(rs1, rs2, rd_old, ID_EX_MemRead, branch_bit, jump_bit)

begin

if ((rs1=rd_old or rs2=rd_old) and ID_EX_MemRead = '1') then --read after write bubble
	PC_Write<='0';
	IF_ID_Write <= '0';
	control_zero <= '1';
	Flush_pipe <= '0';

elsif(branch_bit = '1') then --BEQ
	Flush_Pipe<='1';
	PC_Write <= '1';
	IF_ID_Write <= '1';
	control_zero <= '0';

elsif(jump_bit = '1') then --JAL
	Flush_Pipe<='1';
	PC_Write <= '1';
	IF_ID_Write <= '1';
	control_zero <= '0';

else
	PC_Write <= '1';
	IF_ID_Write <= '1';
	Flush_Pipe <= '0';
	control_zero <= '0';

end if;

end process Hazard;

end RTL;
