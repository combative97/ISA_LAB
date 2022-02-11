LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
 
ENTITY instr_Reg IS  
	PORT (R : IN std_logic_vector (31 DOWNTO 0);
			EN : std_logic;
				Clock, Resetn, Flush : IN  STD_LOGIC;   
					Q : OUT std_logic_vector(31 DOWNTO 0)); 
END instr_Reg; 
 
ARCHITECTURE Behavior OF instr_Reg IS 

BEGIN  PROCESS (Clock, Resetn, Flush)  
	BEGIN   
	IF (Resetn = '0') THEN Q <= (OTHERS => '0');

	ELSIF (Clock'EVENT AND Clock = '1') THEN 
		IF (Flush = '1') THEN Q <= x"00000013";
	  	elsif (EN = '1')then
			Q <= R;
	END IF;	
  END IF;
END PROCESS; 

END Behavior;