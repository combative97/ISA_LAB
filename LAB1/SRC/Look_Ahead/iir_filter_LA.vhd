LIBRARY IEEE;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.all;

entity iir_filter_LA is
	port(DIN,a1,b0,b1 : IN signed(7 downto 0);
		a1_2 : IN signed (9 downto 0);
			VIN,RST_n,CLK : IN std_logic;
				VOUT : OUT std_logic;
					DOUT : OUT signed(7 downto 0));
end entity;

architecture behav of iir_filter_LA is

	COMPONENT Reg IS  GENERIC ( N : integer);
	PORT (R : IN signed (N-1 DOWNTO 0);
			EN : std_logic;
				Clock, Resetn : IN  STD_LOGIC;   
					Q : OUT signed(N-1 DOWNTO 0)); 
	END COMPONENT;

	COMPONENT std_logic_Reg IS  
	PORT (R : IN std_logic;
			EN : std_logic;
				Clock, Resetn : IN  STD_LOGIC;   
					Q : OUT std_logic); 
	END COMPONENT;

	signal din_reg,dout_reg,b0_8reg,b1_8reg,a1_8reg : signed(7 downto 0);
	signal a1_reg, b0_reg, b1_reg : signed (6 downto 0);
	signal a1_2_reg : signed (9 downto 0);
	signal in_mul_a1, in_mul_b1, in_mul_a1_2 : signed (8 downto 0);
	signal out_mul_a1, out_mul_b0, out_mul_b1 : signed (15 downto 0);
	signal x_n, xa1, out_sum1 : signed (8 downto 0);
	signal in_sum2_a, in_sum2_b, out_sum2 : signed (8 downto 0);
	signal out_mul_a1_2 : signed (18 downto 0);
	signal in_sum3_a, in_sum3_b, out_sum3 : signed (8 downto 0);
	signal out_en, vout_data, vout_data_pipe1, vout_data_pipe2, vout_data_pipe3, vout_data_pipe4 : std_logic;

	signal xa1_reg, x_n_reg, out_sum1_reg : signed (8 downto 0);
	signal in_sum2_b_reg, out_sum2_reg : signed (8 downto 0);
	signal in_mul_b1_reg : signed (8 downto 0); 
	signal in_sum3_a_reg, in_sum3_b_reg : signed (8 downto 0);
	
	


	begin

	a1_reg <= a1_8reg (6 downto 0);
	b0_reg <= b0_8reg(6 downto 0);
	b1_reg <= b1_8reg(6 downto 0);
	x_n <= din_reg(7) & din_reg; --estendo per evitare overflow dovuto alla somma
	out_mul_a1 <= a1_reg*in_mul_a1;
	xa1 <= out_mul_a1(15) & out_mul_a1(15 downto 8);
	out_sum1 <= x_n_reg-xa1_reg;
	in_sum2_a <= out_sum1_reg;
	in_sum2_b <= out_mul_a1_2(18) & out_mul_a1_2(18) & out_mul_a1_2(18) & out_mul_a1_2(18) & out_mul_a1_2(18) & out_mul_a1_2(18) &out_mul_a1_2(18 downto 16);
	out_sum2 <= in_sum2_a+in_sum2_b_reg;
	out_mul_a1_2 <= a1_2_reg*in_mul_a1_2;
	out_mul_b0 <= out_sum2_reg*b0_reg;
	out_mul_b1 <= in_mul_b1_reg*b1_reg;
	in_sum3_a <= out_mul_b0(15) & out_mul_b0(15 downto 8);
	in_sum3_b <= out_mul_b1(15) & out_mul_b1(15 downto 8);
	out_sum3 <= in_sum3_a_reg+in_sum3_b_reg;
	dout_reg <= out_sum3(7 downto 0);

	out_en <= vout_data_pipe4;

	Reg_a1 : REG generic map (N=>8) port map (R=>a1, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>a1_8reg);
	Reg_a1_2 : REG generic map (N=>10) port map (R=>a1_2, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>a1_2_reg);
	Reg_b0 : REG generic map (N=>8) port map (R=>b0, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>b0_8reg);
	Reg_b1 : REG generic map (N=>8) port map (R=>b1, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>b1_8reg);
	in_reg : Reg generic map (N=>8) port map(R=>DIN, EN=>VIN, Clock=>CLK, Resetn=>RST_n, Q=>din_reg);
	reg_mul_a1 : Reg generic map (N=>9) port map(R=>x_n, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>in_mul_a1);
	w1_reg : Reg generic map (N=>9) port map(R=>out_sum2, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>in_mul_b1);
	w2_reg : Reg generic map (N=>9) port map(R=>in_mul_b1, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>in_mul_a1_2);
	out_reg : Reg generic map (N=>8) port map(R=>dout_reg, EN=>out_en, Clock=>CLK, Resetn=>RST_n, Q=>DOUT);

	Reg_vout_pipe1 : std_logic_Reg port map (R=>vout_data, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>vout_data_pipe1);
	Reg_vout_pipe2 : std_logic_Reg port map (R=>vout_data_pipe1, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>vout_data_pipe2);
	Reg_vout_pipe3 : std_logic_Reg port map (R=>vout_data_pipe2, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>vout_data_pipe3);
	Reg_vout_pipe4 : std_logic_Reg port map (R=>vout_data_pipe3, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>vout_data_pipe4);
	Reg_vout : std_logic_Reg port map (R=>vout_data_pipe4, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>VOUT);

	xa1_pipe : Reg generic map (N=>9) port map (R=>xa1, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>xa1_reg);
	x_n_pipe : Reg generic map (N=>9) port map (R=>x_n, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>x_n_reg);
	sum1_pipe : Reg generic map (N=>9) port map (R=>out_sum1, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>out_sum1_reg);
	sum2_pipe : Reg generic map (N=>9) port map (R=>in_sum2_b, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>in_sum2_b_reg);
	mul_b0_pipe : Reg generic map (N=>9) port map (R=>out_sum2, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>out_sum2_reg);
	mul_b1_pipe : Reg generic map (N=>9) port map (R=>in_mul_b1, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>in_mul_b1_reg);
	sum3_a_pipe : Reg generic map (N=>9) port map (R=>in_sum3_a, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>in_sum3_a_reg);
	sum3_b_pipe : Reg generic map (N=>9) port map (R=>in_sum3_b, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>in_sum3_b_reg);

	validation : process(CLK, VIN) 
		begin
		if (CLK'event and CLK = '1') then
				if (VIN = '1') then
			
				vout_data <= '1';
				
			else
			
				vout_data <= '0';
				
			end if;
		end if;
	end process;

end behav;	
	
	
	

		

