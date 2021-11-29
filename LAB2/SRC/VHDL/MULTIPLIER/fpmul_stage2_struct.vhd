-- VHDL Entity HAVOC.FPmul_stage2.interface
--
-- Created by
-- Guillermo Marcus, gmarcus@ieee.org
-- using Mentor Graphics FPGA Advantage tools.
--
-- Visit "http://fpga.mty.itesm.mx" for more info.
--
-- 2003-2004. V1.0
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY FPmul_stage2 IS
   PORT( 
      A_EXP           : IN     std_logic_vector (7 DOWNTO 0);
      A_SIG           : IN     std_logic_vector (31 DOWNTO 0);
      B_EXP           : IN     std_logic_vector (7 DOWNTO 0);
      B_SIG           : IN     std_logic_vector (31 DOWNTO 0);
      SIGN_out_stage1 : IN     std_logic;
      clk             : IN     std_logic;
      isINF_stage1    : IN     std_logic;
      isNaN_stage1    : IN     std_logic;
      isZ_tab_stage1  : IN     std_logic;
      EXP_in          : OUT    std_logic_vector (7 DOWNTO 0);
      EXP_neg_stage2  : OUT    std_logic;
      EXP_pos_stage2  : OUT    std_logic;
      SIGN_out_stage2 : OUT    std_logic;
      SIG_in          : OUT    std_logic_vector (27 DOWNTO 0);
      isINF_stage2    : OUT    std_logic;
      isNaN_stage2    : OUT    std_logic;
      isZ_tab_stage2  : OUT    std_logic
   );

-- Declarations

END FPmul_stage2 ;

--
-- VHDL Architecture HAVOC.FPmul_stage2.struct
--
-- Created by
-- Guillermo Marcus, gmarcus@ieee.org
-- using Mentor Graphics FPGA Advantage tools.
--
-- Visit "http://fpga.mty.itesm.mx" for more info.
--
-- Copyright 2003-2004. V1.0
--


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ARCHITECTURE struct OF FPmul_stage2 IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL EXP_in_int  : std_logic_vector(7 DOWNTO 0);
   SIGNAL EXP_neg_int : std_logic;
   SIGNAL EXP_pos_int : std_logic;
   SIGNAL SIG_in_int  : std_logic_vector(27 DOWNTO 0);
   SIGNAL dout        : std_logic;
   SIGNAL dout1       : std_logic_vector(7 DOWNTO 0);
   SIGNAL prod        : std_logic_vector(63 DOWNTO 0);
   
   --output register's signals
   SIGNAL EXP_in_int_reg : std_logic_vector(7 DOWNTO 0);
   SIGNAL EXP_neg_int_reg : std_logic;
   SIGNAL EXP_pos_int_reg : std_logic;
   SIGNAL SIG_in_int_reg : std_logic_vector(27 DOWNTO 0);
   SIGNAL isINF_stage1_reg : std_logic;
   SIGNAL isNaN_stage1_reg : std_logic;
   SIGNAL isZ_tab_stage1_reg : std_logic;
   SIGNAL SIGN_out_stage1_reg : std_logic;
   
   COMPONENT MBE_32 is PORT
   (
	   A, X : IN std_logic_vector (31 downto 0);
		   P : OUT std_logic_vector (63 downto 0)
   );
   END COMPONENT;
    
   COMPONENT Reg IS  GENERIC ( N : integer);  
	   PORT (R : IN std_logic_vector (N-1 DOWNTO 0);
			   EN : std_logic;
				   Clock, Resetn : IN  STD_LOGIC;   
					   Q : OUT std_logic_vector(N-1 DOWNTO 0)); 
   END COMPONENT; 
   
   COMPONENT std_logic_Reg IS  
	   PORT (R : IN std_logic;
			   EN : std_logic;
				   Clock, Resetn : IN  STD_LOGIC;   
					   Q : OUT std_logic); 
   END COMPONENT; 

BEGIN
   -- Architecture concurrent statements
   -- HDL Embedded Text Block 1 sig
   -- eb1 1
   SIG_in_int_reg <= prod(47 DOWNTO 20);

   -- HDL Embedded Text Block 2 inv
   -- eb5 5
   EXP_in_int_reg <= (NOT dout1(7)) & dout1(6 DOWNTO 0);

   -- HDL Embedded Text Block 3 latch
   -- eb2 2
   
   outReg1 : Reg generic map(N => 8) port map(EXP_in_int_reg, '1',clk,'1',EXP_in_int);
   outReg2 : Reg generic map(N => 28) port map(SIG_in_int_reg, '1',clk,'1',SIG_in_int);
   outReg3 : std_logic_Reg port map(isINF_stage1, '1',clk,'1',isINF_stage1_reg);
   outReg4 : std_logic_Reg port map(isZ_tab_stage1, '1',clk,'1',isZ_tab_stage1_reg);
   outReg5 : std_logic_Reg port map(isNaN_stage1, '1',clk,'1',isNaN_stage1_reg);
   outReg6 : std_logic_Reg port map(SIGN_out_stage1, '1',clk,'1',SIGN_out_stage1_reg);
   outReg7 : std_logic_Reg port map(EXP_pos_int_reg, '1',clk,'1',EXP_pos_int);
   outReg8 : std_logic_Reg port map(EXP_neg_int_reg, '1',clk,'1',EXP_neg_int);
   
   PROCESS(clk)
   BEGIN
      IF RISING_EDGE(clk) THEN
         EXP_in <= EXP_in_int;
         SIG_in <= SIG_in_int;
         EXP_pos_stage2 <= EXP_pos_int;
         EXP_neg_stage2 <= EXP_neg_int;
      END IF;
   END PROCESS;

   -- HDL Embedded Text Block 4 latch2
   -- latch2 4
   PROCESS(clk)
   BEGIN
      IF RISING_EDGE(clk) THEN
         isINF_stage2 <= isINF_stage1_reg;
         isNaN_stage2 <= isNaN_stage1_reg;
         isZ_tab_stage2 <= isZ_tab_stage1_reg;
         SIGN_out_stage2 <= SIGN_out_stage1_reg;
      END IF;
   END PROCESS;

   -- HDL Embedded Text Block 5 eb1
   -- exp_pos 5
   EXP_pos_int_reg <= A_EXP(7) AND B_EXP(7);
--   EXP_neg_int <= NOT(A_EXP(7) OR B_EXP(7));
   EXP_neg_int_reg <= '1' WHEN ( (A_EXP(7)='0' AND NOT (A_EXP=X"7F")) AND (B_EXP(7)='0' AND NOT (B_EXP=X"7F")) ) ELSE '0';


   -- ModuleWare code(v1.1) for instance 'I4' of 'add'
   I4combo: PROCESS (A_EXP, B_EXP, dout)
   VARIABLE mw_I4t0 : std_logic_vector(8 DOWNTO 0);
   VARIABLE mw_I4t1 : std_logic_vector(8 DOWNTO 0);
   VARIABLE mw_I4sum : unsigned(8 DOWNTO 0);
   VARIABLE mw_I4carry : std_logic;
   BEGIN
      mw_I4t0 := '0' & A_EXP;
      mw_I4t1 := '0' & B_EXP;
      mw_I4carry := dout;
      mw_I4sum := unsigned(mw_I4t0) + unsigned(mw_I4t1) + mw_I4carry;
      dout1 <= conv_std_logic_vector(mw_I4sum(7 DOWNTO 0),8);
   END PROCESS I4combo;

--ModuleWare code(v1.1) for instance 'I2' of 'mult'
--   I2combo : PROCESS (A_SIG, B_SIG)
--   VARIABLE dtemp : unsigned(63 DOWNTO 0);
--      BEGIN
--      dtemp := (unsigned(A_SIG) * unsigned(B_SIG));
--         prod <= dtemp;
--   END PROCESS I2combo;

   -- ModuleWare code(v1.1) for instance 'I6' of 'vdd'
   dout <= '1';

   -- Instance port mappings.
   
   MBE : MBE_32 port map(A_SIG,B_SIG,prod);

END struct;
