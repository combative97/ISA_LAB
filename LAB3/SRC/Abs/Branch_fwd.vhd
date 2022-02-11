library ieee;
use ieee.std_logic_1164.all;

entity Branch_fwd is
    port (
        ifid_rs1 : in std_logic_vector(4 downto 0);
        ifid_rs2 : in std_logic_vector(4 downto 0);
        idex_rd : in std_logic_vector(4 downto 0);
        exmem_rd : in std_logic_vector(4 downto 0);
        idex_regwrite, exmem_regwrite : in std_logic;
        forwarda : out std_logic_vector(1 downto 0);
        forwardb : out std_logic_vector(1 downto 0)
        );
end Branch_fwd;

architecture beh of Branch_fwd is 

    begin

	forward : process(ifid_rs1, ifid_rs2, idex_regwrite, idex_rd, exmem_regwrite, exmem_rd)

			begin

				if (idex_regwrite='1' and idex_rd/="00000" and idex_rd=ifid_rs1) then forwarda<="01";
				elsif (exmem_regwrite='1' and exmem_rd/="00000" and exmem_rd=ifid_rs1) then forwarda<="10";
				else forwarda <= "00";
				end if;

				if (idex_regwrite='1' and idex_rd/="00000" and idex_rd=ifid_rs2) then forwardb<="01";
				elsif (exmem_regwrite='1' and exmem_rd/="00000" and exmem_rd=ifid_rs2) then  forwardb<="10";
				else forwardb<="00";
				end if;
			end process;
end beh;