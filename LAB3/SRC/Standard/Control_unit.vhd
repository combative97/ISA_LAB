library ieee;
use ieee.std_logic_1164.all;

entity Control_unit is
	PORT(
		Op_code:in std_logic_vector(6 downto 0);
		Code:out std_logic_vector(12 downto 0)
);
end entity Control_unit;

Architecture RTL of Control_unit is
begin

--Code<="10000000";
process(OP_code)
begin

Code(0)<='0';--BRANCH
Code(1)<='0';--MEM_READ
Code(3 downto 2)<="00";--MEM_TO_REG
Code(5 downto 4)<="10";--ALU_OP
Code(6)<='0';--MEM_WRITE
Code(8 downto 7)<="00";--ALUSrc1
code(10 downto 9) <= "01";--ALUSrc2
Code(11)<='1';--REG_WRITE
Code(12)<='0';--JUMP


case Op_code is

		--I-Type
	when "0110111" => --LUI
		Code(5 downto 4)<="11";--ALU_OP
		Code(8 downto 7) <= "01";--ALUSrc1
		Code(10 downto 9) <= "10";--ALUSrc2

	when "0010111" => --AUIPC
		Code(5 downto 4)<="11";--ALU_OP
		Code(8 downto 7) <= "10";--ALUSrc1
		Code(10 downto 9) <= "10";--ALUSrc2

	when "0010011" => --ADDI/ANDI/SRAI
		Code(5 downto 4)<="11";--ALU_OP

		--U_Type
	when "1101111" => --JAL
		Code(12)<='1';--JUMP
		Code(3 downto 2) <= "01"; --MEM_TO_REG
		Code(5 downto 4)<="01";--ALU_OP

	when "1100011" => --BEQ
		Code(0)<='1';--BRANCH
		Code(5 downto 4)<="01";--ALU_OP
		Code(11)<='0';--REG_WRITE

	when "0000011" => --LW
		Code(1)<='1';--MEM_READ
		Code(3 downto 2)<="10";--MEM_TO_REG
		Code(5 downto 4)<="00";--ALU_OP

	when "0100011" => --SW
		Code(5 downto 4)<="00";--ALU_OP
		Code(6)<='1';--MEM_WRITE
		Code(11)<='0';--REG_WRITE
		
		--R-type
	when "0110011" => --ADD/XOR/SLT
		Code(5 downto 4)<="10";--ALU_OP
		Code(10 downto 9) <= "00"; --ALUSrc2

	when others =>
			Code(0)<='0';--BRANCH
			Code(1)<='0';--MEM_READ
			Code(3 downto 2)<="00";--MEM_TO_REG
			Code(5 downto 4)<="10";--ALU_OP
			Code(6)<='0';--MEM_WRITE
			Code(8 downto 7)<="00";--ALUSrc1
			code(10 downto 9) <= "01";--ALUSrc2
			Code(11)<='1';--REG_WRITE
			Code(12)<='0';--JUMP


end case;
end process;
end RTL;
