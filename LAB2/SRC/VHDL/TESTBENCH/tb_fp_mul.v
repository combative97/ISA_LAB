module tb_fp_mul ();

   wire CLK_i;
   wire [31:0] DINA_i;
   wire [31:0] DINB_i;
   wire [31:0] DOUT_i;

   clk_gen CG(
  	      .CLK(CLK_i));

   data_maker SM(.CLK(CLK_i),
		 .DOUT_A(DINA_i),
		 .DOUT_B(DINB_i));

   FPmul UUT(.CLK(CLK_i),
	     .FP_A(DINA_i),
	     .FP_B(DINB_i),
        .FP_Z(DOUT_i));

   data_sink DS(.CLK(CLK_i),

		.DIN(DOUT_i));   

endmodule
