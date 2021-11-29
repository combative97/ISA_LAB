Library IEEE; 
use IEEE.std_logic_1164.all;
Entity HA is
 
port( A,B : IN std_logic; 
     S,C : OUT std_logic); 
end entity;

Architecture bhe of HA is 
begin
S <= A xor B; 
C <= A and B;

end bhe;
