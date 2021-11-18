LIBRARY IEEE;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.all;

entity iir_filter is
	port(DIN,a1,b0,b1 : IN signed(7 downto 0); 
		VIN,RST_n,CLK : IN std_logic;
		VOUT : OUT std_logic;
		DOUT : OUT signed(7 downto 0));
end entity;

architecture behav of iir_filter is

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
	signal out_mul_a1 : signed (15 downto 0);
	signal out_mul_b0,out_mul_b1 : signed (15 downto 0);
	signal x,y,w,w_reg,mb0,fb,ff,out_sum_x, out_sum_y : signed (8 downto 0);
	signal b0_reg,b1_reg : signed(6 downto 0);
	signal a1_reg : signed(6 downto 0);
	signal out_en, vout_data : std_logic;

	begin

		a1_reg <= a1_8reg(6 downto 0);
		b0_reg <= b0_8reg(6 downto 0);
		b1_reg <= b1_8reg(6 downto 0);
		x <= din_reg(7) & din_reg;
		--mb0 <= out_mul_b0 (15 downto 7); --8 bit
		mb0 <= out_mul_b0(15) & out_mul_b0(15 downto 8); --7 bit
		--fb <= out_mul_a1(15 downto 7); --8 bit
		fb <= out_mul_a1(15) & out_mul_a1(15 downto 8); --7 bit
		--ff <= out_mul_b1(15 downto 7); --8 bit
		ff <= out_mul_b1(15) & out_mul_b1(15 downto 8); --7 bit
		out_sum_x <= x - fb;
		out_mul_b0 <= w*b0_reg;
		out_sum_y <= mb0 + ff;
		out_mul_a1 <= a1_reg*w_reg;
		out_mul_b1 <= w_reg*b1_reg;
		w <= out_sum_x;
		y <= out_sum_y;
		dout_reg <= y(7 downto 0);
		
		out_en <= vout_data;

		Reg_in: Reg generic map(N=>8) port map (R => DIN, EN=>VIN, Clock => CLK, Resetn => RST_n, Q=> din_reg);
		Reg_a1 : REG generic map (N=>8) port map (R=>a1, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>a1_8reg);
		Reg_b0 : REG generic map (N=>8) port map (R=>b0, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>b0_8reg);
		Reg_b1 : REG generic map (N=>8) port map (R=>b1, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>b1_8reg);
		Reg_w : REG generic map (N=>9) port map (R=>w, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>w_reg);
		Reg_out: REG generic map (N=>8) port map (R=>dout_reg, EN=>out_en, Clock=>CLK, Resetn=>RST_n, Q=>DOUT);
		Reg_vout : std_logic_Reg port map (R=>vout_data, EN=>'1', Clock=>CLK, Resetn=>RST_n, Q=>VOUT);

		
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
						 

		
		 
