LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MBE_32 is PORT
(
	A, X : IN std_logic_vector (31 downto 0);
		P : OUT std_logic_vector (63 downto 0)
);
END ENTITY;

ARCHITECTURE beh OF MBE_32 IS
	
COMPONENT Dadda_tree is PORT
(
	partial_p17_0,partial_p17_1,partial_p17_2,partial_p17_3,partial_p17_4,partial_p17_5,partial_p17_6,partial_p17_7,partial_p17_8,partial_p17_9,partial_p17_10,partial_p17_11,partial_p17_12,partial_p17_13,partial_p17_14,partial_p17_15,partial_p17_16 : IN std_logic_vector(63 downto 0);
	P : OUT std_logic_vector(63 downto 0)
);
END COMPONENT;

COMPONENT Pj_gen IS
PORT (
	A, X : IN std_logic_vector (31 downto 0);
	P0,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16 : OUT std_logic_vector (63 downto 0)
);
END COMPONENT;

signal P0,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16 : std_logic_vector (63 downto 0);

begin

P_gen : Pj_gen port map(A,X,P0,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16);

Dadda : Dadda_tree port map(P0,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16,P);

end beh; 