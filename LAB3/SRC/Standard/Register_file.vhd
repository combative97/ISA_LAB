library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_file is
    port(
        clock, rst_n: in std_logic;
        RegWrite: in std_logic;
        ReadRegister1: in std_logic_vector(4 downto 0);
        ReadRegister2: in std_logic_vector(4 downto 0);
        WriteRegister: in std_logic_vector(4 downto 0);
        WriteData: in std_logic_vector(63 downto 0);
        ReadData1: out std_logic_vector(63 downto 0);
        ReadData2: out std_logic_vector(63 downto 0)
        );
end Register_file;

architecture beh of Register_file is 

    type RegArray is array(0 to 31) of std_logic_vector(63 downto 0);
    signal reg : RegArray;
    
    begin
        
    
    mem : process(rst_n, ReadRegister1, ReadRegister2, clock, RegWrite, WriteRegister, WriteData) is
    begin 
        
   if(rst_n = '0') then reg <= (others=>(others=>'0')); ReadData1<=(others=>'0'); ReadData2<=(others=>'0');
   
   else
	
	if((ReadRegister1 = WriteRegister) and (RegWrite = '1')) then ReadData1 <= WriteData;
	else ReadData1<=reg(to_integer(unsigned(ReadRegister1))); end if;

	if((ReadRegister2 = WriteRegister) and (RegWrite = '1')) then ReadData2 <= WriteData;
	else ReadData2<=reg(to_integer(unsigned(ReadRegister2))); end if;

	if(clock'event and clock = '1') then
		if(RegWrite = '1') then 
			reg(to_integer(unsigned(WriteRegister)))<=WriteData;
		end if;
	end if;
	
	end if;

    end process;
    
    end beh;