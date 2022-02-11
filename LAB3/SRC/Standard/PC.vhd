LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
 
ENTITY PC IS  
	PORT (R : IN std_logic_vector (63 DOWNTO 0);
			EN : std_logic;
				Clock, Resetn : IN  STD_LOGIC;   
					Q : OUT std_logic_vector(63 DOWNTO 0)); 
END PC; 
 
ARCHITECTURE Behavior OF PC IS 

BEGIN  PROCESS (Clock, Resetn)  
	BEGIN   IF (Resetn = '0') THEN    
		Q <= x"0000000000400000";

	ELSIF (Clock'EVENT AND Clock = '1') THEN 
	  if (EN = '1')then
		Q <= R;
	END IF;	
  END IF;
END PROCESS; 

END Behavior;