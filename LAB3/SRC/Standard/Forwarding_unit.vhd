library ieee;
use ieee.std_logic_1164.all;

entity Forwarding_unit is
    port (
        idex_rs1 : in std_logic_vector(4 downto 0);
        idex_rs2 : in std_logic_vector(4 downto 0);
        exmem_rd : in std_logic_vector(4 downto 0);
        memwb_rd : in std_logic_vector(4 downto 0);
        exmem_regwrite, memwb_regwrite : in std_logic;
        forwarda : out std_logic_vector(1 downto 0);
        forwardb : out std_logic_vector(1 downto 0)
        );
end Forwarding_unit;

architecture beh of Forwarding_unit is 

    begin
        
--        EX_HAZARD : process(exmem_regwrite, idex_rs1, idex_rs2, exmem_rd)
--                    begin
--                        if (exmem_regwrite='1' and exmem_rd/="00000" and exmem_rd=idex_rs1) then forwarda<="01";
--                            else  forwarda<="00";    
--                        end if;
--                        if (exmem_regwrite='1' and exmem_rd/="00000" and exmem_rd=idex_rs2) then forwardb<="01";
--                            else if (imm_bit = '0') then forwardb<="00"; else forwardb<="11"; end if;
--                        end if;
--                        
--                      end process;
--                      
--        MEM_HAZARD : process(memwb_regwrite, idex_rs1, idex_rs2, memwb_rd)
--                    begin
--                        if (memwb_regwrite='1' and memwb_rd/="00000" and memwb_rd=idex_rs1) then forwarda<="10";
--                            else forwarda<="00"; 
--                        end if;
--                        if (memwb_regwrite='1' and memwb_rd/="00000" and exmem_rd=idex_rs2) then  forwardb<="10";
--                            else if (imm_bit = '0') then forwardb<="00"; else forwardb<="11"; end if; 
--                        end if;
--                        
--                      end process;


	forward : process(idex_rs1, idex_rs2, exmem_regwrite, exmem_rd, memwb_regwrite, memwb_rd)

			begin

				if (exmem_regwrite='1' and exmem_rd/="00000" and exmem_rd=idex_rs1) then forwarda<="01";
				elsif (memwb_regwrite='1' and memwb_rd/="00000" and memwb_rd=idex_rs1) then forwarda<="10";
				else forwarda <= "00";
				end if;

				if (exmem_regwrite='1' and exmem_rd/="00000" and exmem_rd=idex_rs2) then forwardb<="01";
				elsif (memwb_regwrite='1' and memwb_rd/="00000" and memwb_rd=idex_rs2) then  forwardb<="10";
				else forwardb<="00";
				end if;
			end process;
				
    end beh;
                        
