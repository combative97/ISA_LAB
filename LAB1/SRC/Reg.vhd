LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;
 
ENTITY Reg IS  GENERIC ( N : integer);  
	PORT (R : IN signed (N-1 DOWNTO 0);
			EN : std_logic;
				Clock, Resetn : IN  STD_LOGIC;   
					Q : OUT signed(N-1 DOWNTO 0)); 
END Reg; 
 
ARCHITECTURE Behavior OF Reg IS 

BEGIN  PROCESS (Clock, Resetn)  
	BEGIN   IF (Resetn = '0') THEN    
		Q <= (OTHERS => '0');

	ELSIF (Clock'EVENT AND Clock = '1') THEN 
	  if (EN = '1')then
		Q <= R;
	END IF;	
  END IF;
END PROCESS; 

END Behavior;