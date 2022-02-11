LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;
 
ENTITY std_logic_Reg IS  
	PORT (R : IN std_logic;
			EN : std_logic;
				Clock, Resetn : IN  STD_LOGIC;   
					Q : OUT std_logic); 
END std_logic_Reg; 
 
ARCHITECTURE Behavior OF std_logic_Reg IS 

BEGIN  PROCESS (Clock, Resetn)  
	BEGIN   IF (Resetn = '0') THEN    
		Q <= '0';

	ELSIF (Clock'EVENT AND Clock = '1') THEN 
	  if (EN = '1')then
		Q <= R;
	END IF;	
  END IF;
END PROCESS; 

END Behavior;
