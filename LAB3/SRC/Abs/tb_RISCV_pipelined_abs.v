module tb_RISCV_pipelined_abs ();

	wire CLK_i;
	wire RST_n_i;
	wire D_MEM_wr_en;
	wire D_MEM_rd_en;
	wire [63:0] D_MEM_Address;
	wire [63:0] D_MEM_data_in;
	wire [63:0] D_MEM_data_out;
	wire [63:0] I_MEM_Address;
	wire [31:0] instr;
	
	clk_gen CG(.CLK(CLK_i),
			.RST_n(RST_n_i));
			
	Data_mem DM(.address(D_MEM_Address),
			.data_in(D_MEM_data_in),
			.data_out(D_MEM_data_out),
			.wr_en(D_MEM_wr_en),
			.rd_en(D_MEM_rd_en));
		
	Instruction_MEM IM(.address(I_MEM_Address),
				.dout(instr));
				
	RISCV_pipelined_abs DUT(.rst_n(RST_n_i),
			.clk(CLK_i),
			.instr_from_mem(instr),
			.data_from_data_mem(D_MEM_data_out),
			.PC_to_I_MEM(I_MEM_Address),
			.Address_to_data_mem(D_MEM_Address),
			.Data_to_data_mem(D_MEM_data_in),
			.data_mem_wr_en(D_MEM_wr_en),
			.data_mem_rd_en(D_MEM_rd_en));
endmodule	
