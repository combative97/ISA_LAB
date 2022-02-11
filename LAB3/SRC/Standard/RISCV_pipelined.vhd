library ieee;
use ieee.std_logic_1164.all;

entity RISCV_pipelined is
port
(
	rst_n, clk : in std_logic;
	instr_from_mem : in std_logic_vector(31 downto 0);
	data_from_data_mem: in std_logic_vector(63 downto 0);
	PC_to_I_MEM : out std_logic_vector(63 downto 0); 
	Address_to_data_mem, Data_to_data_mem : out std_logic_vector(63 downto 0);
	data_mem_wr_en, data_mem_rd_en : out std_logic
);
end entity;

architecture RTL of RISCV_pipelined is

component add is
port
(
	A,B: in std_logic_vector(63 downto 0);
	S : out std_logic_vector(63 downto 0)
);
end component;

component ALU is
port
(
	data1, data2 : in std_logic_vector(63 downto 0);
	alu_ctrl : in std_logic_vector (3 downto 0);
	out_data : out std_logic_vector (63 downto 0);
	zero_flag : out std_logic
);
end component;

component ALU_ctrl is
port
(
	func3 : in std_logic_vector (2 downto 0);
	func7 : in std_logic;
	AluOP : in std_logic_vector(1 downto 0);
	AluCtrl : out std_logic_vector (3 downto 0)
);
end component;

component Control_unit is
	PORT(
		Op_code:in std_logic_vector(6 downto 0);
		Code:out std_logic_vector(12 downto 0)
);
end component Control_unit;

component Imm_gen is
port
(
	instr : in std_logic_vector (31 downto 0);
	imm : out std_logic_vector (63 downto 0)
);
end component;

component mux2 is GENERIC(N : INTEGER);
port
(
	A, B : in std_logic_vector(N-1 downto 0);
	S : in std_logic;
	Y : out std_logic_vector(N-1 downto 0)
);
end component;

component mux4 is
port
(
	A, B, C, D : in std_logic_vector(63 downto 0);
	S : in std_logic_vector(1 downto 0);
	Y : out std_logic_vector(63 downto 0)
);
end component;

component PC IS  
	PORT (R : IN std_logic_vector (63 DOWNTO 0);
			EN : std_logic;
				Clock, Resetn : IN  STD_LOGIC;   
					Q : OUT std_logic_vector(63 DOWNTO 0)); 
END component;

component eq_cmp is
port
(
	A, B : in std_logic_vector(63 downto 0);
	eq : out std_logic
);
end component;

component Register_file is
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
end component;

component Reg IS  GENERIC ( N : integer);  
	PORT (R : IN std_logic_vector (N-1 DOWNTO 0);
			EN : std_logic;
				Clock, Resetn : IN  STD_LOGIC;   
					Q : OUT std_logic_vector(N-1 DOWNTO 0)); 
END component;

component std_logic_Reg IS  
	PORT (R : IN std_logic;
			EN : std_logic;
				Clock, Resetn : IN  STD_LOGIC;   
					Q : OUT std_logic); 
END component;

component instr_Reg IS  
	PORT (R : IN std_logic_vector (31 DOWNTO 0);
			EN : std_logic;
				Clock, Resetn, Flush : IN  STD_LOGIC;   
					Q : OUT std_logic_vector(31 DOWNTO 0)); 
END component;

component Forwarding_unit is
    port (
        idex_rs1 : in std_logic_vector(4 downto 0);
        idex_rs2 : in std_logic_vector(4 downto 0);
        exmem_rd : in std_logic_vector(4 downto 0);
        memwb_rd : in std_logic_vector(4 downto 0);
        exmem_regwrite, memwb_regwrite : in std_logic;
        forwarda : out std_logic_vector(1 downto 0);
        forwardb : out std_logic_vector(1 downto 0)
        );
end component;

component Hazard_Detection_Unit is
	PORT(rs1, rs2, rd_old : in std_logic_vector(4 downto 0);
		ID_EX_MemRead, branch_bit, jump_bit : in std_logic;
		PC_Write, IF_ID_Write, Flush_Pipe:out std_logic;
		control_zero : out std_logic);
end component;

-------------------------------------------------------------------

component Branch_fwd is
    port (
        ifid_rs1 : in std_logic_vector(4 downto 0);
        ifid_rs2 : in std_logic_vector(4 downto 0);
        idex_rd : in std_logic_vector(4 downto 0);
        exmem_rd : in std_logic_vector(4 downto 0);
        idex_regwrite, exmem_regwrite : in std_logic;
        forwarda : out std_logic_vector(1 downto 0);
        forwardb : out std_logic_vector(1 downto 0)
        );
end component;

-------------------------------------------------------------------

signal PrC,PrC_IF_ID, PrC_ID_EX : std_logic_vector(63 downto 0);
signal new_PrC, next_PrC,next_PrC_IF_ID,next_PrC_ID_EX,next_PrC_EX_MEM,next_PrC_MEM_WB : std_logic_vector(63 downto 0);
signal offset_PrC : std_logic_vector(63 downto 0);
signal instr, instr_IF_ID : std_logic_vector(31 downto 0);
signal instr_ID_EX, instr_alu_ctrl : std_logic_vector(3 downto 0);
signal controls, mux_controls : std_logic_vector(12 downto 0);
signal EX_controls, EX_controls_ID_EX : std_logic_vector(5 downto 0);
signal M_controls, M_controls_ID_EX, M_controls_EX_MEM : std_logic_vector(1 downto 0);
signal WB_controls, WB_controls_ID_EX, WB_controls_EX_MEM, WB_controls_MEM_WB : std_logic_vector(2 downto 0);
signal jump_sel, zero_flag, eq_regs, branch : std_logic;
signal Alu_ctrls : std_logic_vector(3 downto 0);
signal immediate,immediate_ID_EX, jump_imm, offset_imm : std_logic_vector(63 downto 0);
signal ALU_in1, ALU_in2, ALU_out, ALU_out_EX_MEM, ALU_out_MEM_WB : std_logic_vector(63 downto 0);
signal sdata1, sdata1_ID_EX, sdata1_ID_EX_mux, sdata2, sdata2_ID_EX, sdata2_ID_EX_mux, sdata2_EX_MEM_mux : std_logic_vector(63 downto 0);
signal rd, rd_ID_EX, rd_EX_MEM, rd_MEM_WB : std_logic_vector(4 downto 0);
signal rs1, rs2, rs1_ID_EX, rs2_ID_EX : std_logic_vector(4 downto 0);
signal data_mem_out, data_mem_out_MEM_WB : std_logic_vector(63 downto 0);
signal WB_data : std_logic_vector(63 downto 0);
signal PrC_Write, IF_ID_Write, IF_Flush : std_logic;
signal fwd_sel1, fwd_sel2 : std_logic_vector(1 downto 0);
signal CU_sel : std_logic;

-----------------------------

signal to_cmp1, to_cmp2 : std_logic_vector(63 downto 0);
signal cmp_sel1, cmp_sel2 : std_logic_vector(1 downto 0);

-----------------------------

begin

program_counter : PC port map(new_PrC, PrC_Write, clk, rst_n, PrC);
PrC_IF_ID_reg : Reg generic map(N=>64) port map(PrC, IF_ID_Write, clk, rst_n, PrC_IF_ID);
PrC_ID_EX_reg : Reg generic map(N=>64) port map(PrC_IF_ID, '1', clk, rst_n, PrC_ID_EX);
seq_adder : add port map(PrC, x"0000000000000004", next_PrC);
next_Prc_IF_ID_Reg : Reg generic map(N=>64) port map(next_PrC, IF_ID_Write, clk, rst_n, next_PrC_IF_ID);
next_Prc_ID_EX_Reg : Reg generic map(N=>64) port map(next_PrC_IF_ID, '1', clk, rst_n, next_PrC_ID_EX);
next_Prc_EX_MEM_Reg : Reg generic map(N=>64) port map(next_PrC_ID_EX, '1', clk, rst_n, next_PrC_EX_MEM);
next_Prc_MEM_WB_Reg : Reg generic map(N=>64) port map(next_PrC_EX_MEM, '1', clk, rst_n, next_PrC_MEM_WB);
offset_adder : add port map(PrC_IF_ID, jump_imm, offset_PrC);
jump_mux : mux2 generic map(N=>64) port map(next_PrC, offset_PrC, jump_sel, new_PrC);

PC_to_I_mem <= PrC;
instr <= instr_from_mem;

Instr_IF_ID_Reg : instr_Reg port map(instr, IF_ID_Write, clk, rst_n, IF_Flush, instr_IF_ID);
CU : control_unit port map(instr_IF_ID(6 downto 0), controls);
rd <= instr_IF_ID(11 downto 7);
CU_MUX : mux2 generic map(N=>13) port map(controls, "0000000000000", CU_sel, mux_controls);
EX_controls_Reg_ID_EX : Reg generic map(N=>6) port map(EX_controls, '1', clk, rst_n, EX_controls_ID_EX);
M_controls_Reg_ID_EX : Reg generic map(N=>2) port map(M_controls, '1', clk, rst_n, M_controls_ID_EX);
WB_controls_Reg_ID_EX : Reg generic map(N=>3) port map(WB_controls, '1', clk, rst_n, WB_controls_ID_EX); 
hazard_detection : Hazard_Detection_Unit port map(rs1, rs2, rd_ID_EX, M_controls_ID_EX(0), branch, mux_controls(12), PrC_Write, IF_ID_Write, IF_Flush, CU_sel);
EX_controls <= mux_controls(10 downto 9) & mux_controls(8 downto 7) & mux_controls(5 downto 4);
M_controls <= mux_controls(6) & mux_controls(1);
WB_controls <= mux_controls(11) & mux_controls(3 downto 2);
rs1 <= instr_IF_ID(19 downto 15);
rs2 <= instr_IF_ID(24 downto 20);
RF : Register_file port map(clk, rst_n, WB_controls_MEM_WB(2), rs1, rs2, rd_MEM_WB, WB_data, sdata1, sdata2);
Imm_generator : Imm_gen port map(instr_IF_ID, immediate);
sdata1_ID_EX_Reg : Reg generic map(N=>64) port map(sdata1, '1', clk, rst_n, sdata1_ID_EX);
sdata2_ID_EX_Reg : Reg generic map(N=>64) port map(sdata2, '1', clk, rst_n, sdata2_ID_EX);
Imm_ID_EX_Reg : Reg generic map(N=>64) port map(immediate, '1', clk, rst_n, immediate_ID_EX);
rs1_ID_EX_Reg : Reg generic map(N=>5) port map(rs1, '1', clk, rst_n, rs1_ID_EX);
rs2_ID_EX_Reg : Reg generic map(N=>5) port map(rs2, '1', clk, rst_n, rs2_ID_EX);
rd_ID_EX_Reg : Reg generic map(N=>5) port map(rd, '1', clk, rst_n, rd_ID_EX);
jump_imm <= immediate(62 downto 0) & '0';
offset_imm(63 downto 32) <= (others => immediate_ID_EX(63));
offset_imm(31 downto 12) <= immediate_ID_EX(19 downto 0);
offset_imm(11 downto 0) <= (others => '0');

-----------------------------------------------------------------------

comparator_forward : Branch_fwd port map(rs1, rs2, rd_ID_EX, rd_EX_MEM, WB_controls_ID_EX(2), WB_controls_EX_MEM(2), cmp_sel1, cmp_sel2);
branch_mux1 : mux4 port map(sdata1, Alu_out, data_mem_out, x"0000000000000000", cmp_sel1, to_cmp1); 
branch_mux2 : mux4 port map(sdata2, Alu_out, data_mem_out, x"0000000000000000", cmp_sel2, to_cmp2); 

-----------------------------------------------------------------------

 
comparator : eq_cmp port map(to_cmp1, to_cmp2, eq_regs); --to_cmp1 <= sdata1; to_cmp2 <= sdata2;
branch <= mux_controls(0) and eq_regs;
jump_sel <= branch or mux_controls(12);
alusrc_mux1 : mux4 port map(sdata1_ID_EX_mux, x"0000000000000000", PrC_ID_EX, x"0000000000000000", EX_Controls_ID_EX(3 downto 2), ALU_in1);
alusrc_mux2 : mux4 port map(sdata2_ID_EX_mux, immediate_ID_EX, offset_imm, x"0000000000000000", EX_Controls_ID_EX(5 downto 4), ALU_in2);
fwd_mux1 : mux4 port map(sdata1_ID_EX, Alu_out_EX_MEM, WB_data, x"0000000000000000", fwd_sel1, sdata1_ID_EX_mux);
fwd_mux2 : mux4 port map(sdata2_ID_EX, Alu_out_EX_MEM, WB_data, x"0000000000000000", fwd_sel2, sdata2_ID_EX_mux);
instr_alu_ctrl <= instr_IF_ID(30) & instr_IF_ID(14 downto 12);
instr_ID_EX_Reg : Reg generic map(N=>4) port map(instr_alu_ctrl, '1', clk, rst_n, instr_ID_EX);
fwd : Forwarding_unit port map(rs1_ID_EX, rs2_ID_EX, rd_EX_MEM, rd_MEM_WB, WB_controls_EX_MEM(2), WB_controls_MEM_WB(2), fwd_sel1, fwd_sel2); 
ALU_control : ALU_ctrl port map(instr_ID_EX(2 downto 0), instr_ID_EX(3), EX_controls_ID_EX(1 downto 0), ALU_ctrls);
ALU_cmp : ALU port map(ALU_in1, ALU_in2, ALU_ctrls, ALU_out, zero_flag);
M_controls_Reg_EX_MEM : Reg generic map(N=>2) port map(M_controls_ID_EX, '1', clk, rst_n, M_controls_EX_MEM);
WB_controls_Reg_EX_MEM : Reg generic map(N=>3) port map(WB_controls_ID_EX, '1', clk, rst_n, WB_controls_EX_MEM);
Alu_Reg_EX_MEM : Reg generic map(N=>64) port map(Alu_out, '1', clk, rst_n, Alu_out_EX_MEM);
sdata2_Reg_EX_MEM : Reg generic map(N=>64) port map(sdata2_ID_EX_mux, '1', clk, rst_n, sdata2_EX_MEM_mux);
rd_Reg_EX_MEM : Reg generic map(N=>5) port map(rd_ID_EX, '1', clk, rst_n, rd_EX_MEM);

Address_to_data_mem <= ALU_out_EX_MEM;
Data_to_data_mem <= sdata2_EX_MEM_mux;
data_mem_out <= data_from_data_mem;
data_mem_wr_en <= M_controls_EX_MEM(1);
data_mem_rd_en <= M_controls_EX_MEM(0);

WB_controls_Reg_MEM_WB : Reg generic map(N=>3) port map(WB_controls_EX_MEM, '1', clk, rst_n, WB_controls_MEM_WB);
data_mem_MEM_WB_Reg : Reg generic map(N=>64) port map(data_mem_out, '1', clk, rst_n, data_mem_out_MEM_WB);
ALU_out_MEM_WB_Reg : Reg generic map(N=>64) port map(ALU_out_EX_MEM, '1', clk, rst_n, ALU_out_MEM_WB);
rd_MEM_WB_Reg : Reg generic map(N=>5) port map(rd_EX_MEM, '1', clk, rst_n, rd_MEM_WB);
WB_mux : mux4 port map(ALU_out_MEM_WB, next_PrC_MEM_WB, data_mem_out_MEM_WB, x"0000000000000000", WB_controls_MEM_WB(1 downto 0), WB_data);


end RTL; 
