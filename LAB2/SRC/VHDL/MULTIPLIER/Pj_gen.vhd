LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Pj_gen IS
PORT (
	A, X : IN std_logic_vector (31 downto 0);
	P0,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16 : OUT std_logic_vector (63 downto 0)
);
END ENTITY;

Architecture beh of Pj_gen is


signal q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15 : std_logic_vector (32 downto 0);
signal x_b0,x_b1,x_b2,x_b3,x_b4,x_b5,x_b6,x_b7,x_b8,x_b9,x_b10,x_b11,x_b12,x_b13,x_b14,x_b15,x_b16 : std_logic_vector (2 downto 0);
signal s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15 : std_logic_vector (32 downto 0);
signal s16,q16 : std_logic_vector (31 downto 0);
signal partial0,partial1,partial2,partial3,partial4,partial5,partial6,partial7,partial8,partial9,partial10,partial11,partial12,partial13,partial14,partial15,partial16 : std_logic_vector(63 downto 0);

begin

x_b0 <= X(1) & X(0) & '0';
x_b1 <= X(3) & X(2) & X(1);
x_b2 <= X(5) & X(4) & X(3);
x_b3 <= X(7) & X(6) & X(5);
x_b4 <= X(9) & X(8) & X(7);
x_b5 <= X(11) & X(10) & X(9);
x_b6 <= X(13) & X(12) & X(11);
x_b7 <= X(15) & X(14) & X(13);
x_b8 <= X(17) & X(16) & X(15);
x_b9 <= X(19) & X(18) & X(17);
x_b10 <= X(21) & X(20) & X(19);
x_b11 <= X(23) & X(22) & X(21);
x_b12 <= X(25) & X(24) & X(23);
x_b13 <= X(27) & X(26) & X(25);
x_b14 <= X(29) & X(28) & X(27);
x_b15 <= X(31) & X(30) & X(29);
x_b16 <= '0' & '0' & X(31);


q0_gen : Process (A,x_b0)
	begin
		if ((not(x_b0(1) xor x_b0(0)) and not(x_b0(2) xor x_b0(1))) = '1') then q0 <= (OTHERS => '0');
		
		elsif ((x_b0(1) xor x_b0(0)) = '1') then q0 <= '0' & A;

		elsif ((not(x_b0(1) xor x_b0(0)) and (x_b0(2) xor x_b0(1))) = '1') then q0 <= A & '0';

		end if;

	end Process;

s0 <= (OTHERS => x_b0(2));
Partial0(63 downto 36) <= (OTHERS => '0');
Partial0(35 downto 33) <= not (x_b0(2)) & x_b0(2) & x_b0(2);
Partial0 (32 downto 0) <= s0 xor q0;

q1_gen : Process (A,x_b1)
	begin
		if ((not(x_b1(1) xor x_b1(0)) and not(x_b1(2) xor x_b1(1))) = '1') then q1 <= (OTHERS => '0');
		
		elsif ((x_b1(1) xor x_b1(0)) = '1') then q1 <= '0' & A;

		elsif ((not(x_b1(1) xor x_b1(0)) and (x_b1(2) xor x_b1(1))) = '1') then q1 <= A & '0';

		end if;

	end Process;

s1 <= (OTHERS => x_b1(2));
Partial1(63 downto 37) <= (OTHERS => '0');
Partial1(36) <= '1';
Partial1(35) <= not x_b1(2);
Partial1(34 downto 2) <= s1 xor q1;
Partial1(1) <= '0';
Partial1(0) <= x_b0(2);

q2_gen : Process (A,x_b2)
	begin
		if ((not(x_b2(1) xor x_b2(0)) and not(x_b2(2) xor x_b2(1))) = '1') then q2 <= (OTHERS => '0');
		
		elsif ((x_b2(1) xor x_b2(0)) = '1') then q2 <= '0' & A;

		elsif ((not(x_b2(1) xor x_b2(0)) and (x_b2(2) xor x_b2(1))) = '1') then q2 <= A & '0';

		end if;

	end Process;

s2 <= (OTHERS => x_b2(2));
Partial2(63 downto 39) <= (OTHERS => '0');
Partial2(38) <= '1';
Partial2(37) <= not x_b2(2);
Partial2(36 downto 4) <= s2 xor q2;
Partial2(3) <= '0';
Partial2(2) <= x_b1(2);
Partial2(1 downto 0) <= (OTHERS => '0');

q3_gen : Process (A,x_b3)
	begin
		if ((not(x_b3(1) xor x_b3(0)) and not(x_b3(2) xor x_b3(1))) = '1') then q3 <= (OTHERS => '0');
		
		elsif ((x_b3(1) xor x_b3(0)) = '1') then q3 <= '0' & A;

		elsif ((not(x_b3(1) xor x_b3(0)) and (x_b3(2) xor x_b3(1))) = '1') then q3 <= A & '0';

		end if;

	end Process;

s3 <= (OTHERS => x_b3(2));
Partial3(63 downto 41) <= (OTHERS => '0');
Partial3(40) <= '1';
Partial3(39) <= not x_b3(2);
Partial3(38 downto 6) <= s3 xor q3;
Partial3(5) <= '0';
Partial3(4) <= x_b2(2);
Partial3(3 downto 0) <= (OTHERS => '0');

q4_gen : Process (A,x_b4)
	begin
		if ((not(x_b4(1) xor x_b4(0)) and not(x_b4(2) xor x_b4(1))) = '1') then q4 <= (OTHERS => '0');
		
		elsif ((x_b4(1) xor x_b4(0)) = '1') then q4 <= '0' & A;

		elsif ((not(x_b4(1) xor x_b4(0)) and (x_b4(2) xor x_b4(1))) = '1') then q4 <= A & '0';

		end if;

	end Process;

s4 <= (OTHERS => x_b4(2));
Partial4(63 downto 43) <= (OTHERS => '0');
Partial4(42) <= '1';
Partial4(41) <= not x_b4(2);
Partial4(40 downto 8) <= s4 xor q4;
Partial4(7) <= '0';
Partial4(6) <= x_b3(2);
Partial4(5 downto 0) <= (OTHERS => '0');

q5_gen : Process (A,x_b5)
	begin
		if ((not(x_b5(1) xor x_b5(0)) and not(x_b5(2) xor x_b5(1))) = '1') then q5 <= (OTHERS => '0');
		
		elsif ((x_b5(1) xor x_b5(0)) = '1') then q5 <= '0' & A;

		elsif ((not(x_b5(1) xor x_b5(0)) and (x_b5(2) xor x_b5(1))) = '1') then q5 <= A & '0';

		end if;

	end Process;

s5 <= (OTHERS => x_b5(2));
Partial5(63 downto 45) <= (OTHERS => '0');
Partial5(44) <= '1';
Partial5(43) <= not x_b5(2);
Partial5(42 downto 10) <= s5 xor q5;
Partial5(9) <= '0';
Partial5(8) <= x_b4(2);
Partial5(7 downto 0) <= (OTHERS => '0');

q6_gen : Process (A,x_b6)
	begin
		if ((not(x_b6(1) xor x_b6(0)) and not(x_b6(2) xor x_b6(1))) = '1') then q6 <= (OTHERS => '0');
		
		elsif ((x_b6(1) xor x_b6(0)) = '1') then q6 <= '0' & A;

		elsif ((not(x_b6(1) xor x_b6(0)) and (x_b6(2) xor x_b6(1))) = '1') then q6 <= A & '0';

		end if;

	end Process;

s6 <= (OTHERS => x_b6(2));
Partial6(63 downto 47) <= (OTHERS => '0');
Partial6(46) <= '1';
Partial6(45) <= not x_b6(2);
Partial6(44 downto 12) <= s6 xor q6;
Partial6(11) <= '0';
Partial6(10) <= x_b5(2);
Partial6(9 downto 0) <= (OTHERS => '0');

q7_gen : Process (A,x_b7)
	begin
		if ((not(x_b7(1) xor x_b7(0)) and not(x_b7(2) xor x_b7(1))) = '1') then q7 <= (OTHERS => '0');
		
		elsif ((x_b7(1) xor x_b7(0)) = '1') then q7 <= '0' & A;

		elsif ((not(x_b7(1) xor x_b7(0)) and (x_b7(2) xor x_b7(1))) = '1') then q7 <= A & '0';

		end if;

	end Process;

s7 <= (OTHERS => x_b7(2));
Partial7(63 downto 49) <= (OTHERS => '0');
Partial7(48) <= '1';
Partial7(47) <= not x_b7(2);
Partial7(46 downto 14) <= s7 xor q7;
Partial7(13) <= '0';
Partial7(12) <= x_b6(2);
Partial7(11 downto 0) <= (OTHERS => '0');

q8_gen : Process (A,x_b8)
	begin
		if ((not(x_b8(1) xor x_b8(0)) and not(x_b8(2) xor x_b8(1))) = '1') then q8 <= (OTHERS => '0');
		
		elsif ((x_b8(1) xor x_b8(0)) = '1') then q8 <= '0' & A;

		elsif ((not(x_b8(1) xor x_b8(0)) and (x_b8(2) xor x_b8(1))) = '1') then q8 <= A & '0';

		end if;

	end Process;

s8 <= (OTHERS => x_b8(2));
Partial8(63 downto 51) <= (OTHERS => '0');
Partial8(50) <= '1';
Partial8(49) <= not x_b8(2);
Partial8(48 downto 16) <= s8 xor q8;
Partial8(15) <= '0';
Partial8(14) <= x_b7(2);
Partial8(13 downto 0) <= (OTHERS => '0');

q9_gen : Process (A,x_b9)
	begin
		if ((not(x_b9(1) xor x_b9(0)) and not(x_b9(2) xor x_b9(1))) = '1') then q9 <= (OTHERS => '0');
		
		elsif ((x_b9(1) xor x_b9(0)) = '1') then q9 <= '0' & A;

		elsif ((not(x_b9(1) xor x_b9(0)) and (x_b9(2) xor x_b9(1))) = '1') then q9 <= A & '0';

		end if;

	end Process;

s9 <= (OTHERS => x_b9(2));
Partial9(63 downto 53) <= (OTHERS => '0');
Partial9(52) <= '1';
Partial9(51) <= not x_b9(2);
Partial9(50 downto 18) <= s9 xor q9;
Partial9(17) <= '0';
Partial9(16) <= x_b8(2);
Partial9(15 downto 0) <= (OTHERS => '0');

q10_gen : Process (A,x_b10)
	begin
		if ((not(x_b10(1) xor x_b10(0)) and not(x_b10(2) xor x_b10(1))) = '1') then q10 <= (OTHERS => '0');
		
		elsif ((x_b10(1) xor x_b10(0)) = '1') then q10 <= '0' & A;

		elsif ((not(x_b10(1) xor x_b10(0)) and (x_b10(2) xor x_b10(1))) = '1') then q10 <= A & '0';

		end if;

	end Process;

s10 <= (OTHERS => x_b10(2));
Partial10(63 downto 55) <= (OTHERS => '0');
Partial10(54) <= '1';
Partial10(53) <= not x_b10(2);
Partial10(52 downto 20) <= s10 xor q10;
Partial10(19) <= '0';
Partial10(18) <= x_b9(2);
Partial10(17 downto 0) <= (OTHERS => '0');

q11_gen : Process (A,x_b11)
	begin
		if ((not(x_b11(1) xor x_b11(0)) and not(x_b11(2) xor x_b11(1))) = '1') then q11 <= (OTHERS => '0');
		
		elsif ((x_b11(1) xor x_b11(0)) = '1') then q11 <= '0' & A;

		elsif ((not(x_b11(1) xor x_b11(0)) and (x_b11(2) xor x_b11(1))) = '1') then q11 <= A & '0';

		end if;

	end Process;

s11 <= (OTHERS => x_b11(2));
Partial11(63 downto 57) <= (OTHERS => '0');
Partial11(56) <= '1';
Partial11(55) <= not x_b11(2);
Partial11(54 downto 22) <= s11 xor q11;
Partial11(21) <= '0';
Partial11(20) <= x_b10(2);
Partial11(19 downto 0) <= (OTHERS => '0');

q12_gen : Process (A,x_b12)
	begin
		if ((not(x_b12(1) xor x_b12(0)) and not(x_b12(2) xor x_b12(1))) = '1') then q12 <= (OTHERS => '0');
		
		elsif ((x_b12(1) xor x_b12(0)) = '1') then q12 <= '0' & A;

		elsif ((not(x_b12(1) xor x_b12(0)) and (x_b12(2) xor x_b12(1))) = '1') then q12 <= A & '0';

		end if;

	end Process;

s12 <= (OTHERS => x_b12(2));
Partial12(63 downto 59) <= (OTHERS => '0');
Partial12(58) <= '1';
Partial12(57) <= not x_b12(2);
Partial12(56 downto 24) <= s12 xor q12;
Partial12(23) <= '0';
Partial12(22) <= x_b11(2);
Partial12(21 downto 0) <= (OTHERS => '0');

q13_gen : Process (A,x_b13)
	begin
		if ((not(x_b13(1) xor x_b13(0)) and not(x_b13(2) xor x_b13(1))) = '1') then q13 <= (OTHERS => '0');
		
		elsif ((x_b13(1) xor x_b13(0)) = '1') then q13 <= '0' & A;

		elsif ((not(x_b13(1) xor x_b13(0)) and (x_b13(2) xor x_b13(1))) = '1') then q13 <= A & '0';

		end if;

	end Process;

s13 <= (OTHERS => x_b13(2));
Partial13(63 downto 61) <= (OTHERS => '0');
Partial13(60) <= '1';
Partial13(59) <= not x_b13(2);
Partial13(58 downto 26) <= s13 xor q13;
Partial13(25) <= '0';
Partial13(24) <= x_b12(2);
Partial13(23 downto 0) <= (OTHERS => '0');

q14_gen : Process (A,x_b14)
	begin
		if ((not(x_b14(1) xor x_b14(0)) and not(x_b14(2) xor x_b14(1))) = '1') then q14 <= (OTHERS => '0');
		
		elsif ((x_b14(1) xor x_b14(0)) = '1') then q14 <= '0' & A;

		elsif ((not(x_b14(1) xor x_b14(0)) and (x_b14(2) xor x_b14(1))) = '1') then q14 <= A & '0';

		end if;

	end Process;

s14 <= (OTHERS => x_b14(2));
Partial14(63) <= '0';
Partial14(62) <= '1';
Partial14(61) <= not x_b14(2);
Partial14(60 downto 28) <= s14 xor q14;
Partial14(27) <= '0';
Partial14(26) <= x_b13(2);
Partial14(25 downto 0) <= (OTHERS => '0');

q15_gen : Process (A,x_b15)
	begin
		if ((not(x_b15(1) xor x_b15(0)) and not(x_b15(2) xor x_b15(1))) = '1') then q15 <= (OTHERS => '0');
		
		elsif ((x_b15(1) xor x_b15(0)) = '1') then q15 <= '0' & A;

		elsif ((not(x_b15(1) xor x_b15(0)) and (x_b15(2) xor x_b15(1))) = '1') then q15 <= A & '0';

		end if;

	end Process;

s15 <= (OTHERS => x_b15(2));
Partial15(63) <= not x_b15(2);
Partial15(62 downto 30) <= s15 xor q15;
Partial15(29) <= '0';
Partial15(28) <= x_b14(2);
Partial15(27 downto 0) <= (OTHERS => '0');

q16_gen : Process (A,x_b16)
	begin
		if ((not(x_b16(1) xor x_b16(0)) and not(x_b16(2) xor x_b16(1))) = '1') then q16 <= (OTHERS => '0');
		
		elsif ((x_b16(1) xor x_b16(0)) = '1') then q16 <= A;

		end if;

	end Process;

s16 <= (OTHERS => x_b16(2));
Partial16(63 downto 32) <= s16 xor q16;
Partial16(31) <= '0';
Partial16(30) <= x_b15(2);
Partial16(29 downto 0) <= (OTHERS => '0');

---------------------------------------------

P0(35 downto 0) <= partial0(35 downto 0);
P1(35 downto 0) <= partial1(35 downto 0);
P2(35 downto 0) <= partial2(35 downto 0);
P3(35 downto 0) <= partial3(35 downto 0);
P4(35 downto 0) <= partial4(35 downto 0);
P5(35 downto 0) <= partial5(35 downto 0);
P6(35 downto 0) <= partial6(35 downto 0);
P7(35 downto 0) <= partial7(35 downto 0);
P8(35 downto 0) <= partial8(35 downto 0);
P9(35 downto 0) <= partial9(35 downto 0);
P10(35 downto 0) <= partial10(35 downto 0);
P11(35 downto 0) <= partial11(35 downto 0);
P12(35 downto 0) <= partial12(35 downto 0);
P13(35 downto 0) <= partial13(35 downto 0);
P14(35 downto 0) <= partial14(35 downto 0);
P15(35 downto 0) <= partial15(35 downto 0);
P16(35 downto 0) <= partial16(35 downto 0);

P15(36)<=partial16(36);
P14(36)<=partial15(36);
P13(36)<=partial14(36);
P12(36)<=partial13(36);
P11(36)<=partial12(36);
P10(36)<=partial11(36);
P9(36)<=partial10(36);
P8(36)<=partial9(36);
P7(36)<=partial8(36);
P6(36)<=partial7(36);
P5(36)<=partial6(36);
P4(36)<=partial5(36);
P3(36)<=partial4(36);
P2(36)<=partial3(36);
P1(36)<=partial2(36);
P0(36)<=partial1(36);
P16(36)<='0';

P14(37)<=partial16(37);
P13(37)<=partial15(37);
P12(37)<=partial14(37);
P11(37)<=partial13(37);
P10(37)<=partial12(37);
P9(37)<=partial11(37);
P8(37)<=partial10(37);
P7(37)<=partial9(37);
P6(37)<=partial8(37);
P5(37)<=partial7(37);
P4(37)<=partial6(37);
P3(37)<=partial5(37);
P2(37)<=partial4(37);
P1(37)<=partial3(37);
P0(37)<=partial2(37);
P16(37)<='0';
P15(37)<='0';

P14(38)<=partial16(38);
P13(38)<=partial15(38);
P12(38)<=partial14(38);
P11(38)<=partial13(38);
P10(38)<=partial12(38);
P9(38)<=partial11(38);
P8(38)<=partial10(38);
P7(38)<=partial9(38);
P6(38)<=partial8(38);
P5(38)<=partial7(38);
P4(38)<=partial6(38);
P3(38)<=partial5(38);
P2(38)<=partial4(38);
P1(38)<=partial3(38);
P0(38)<=partial2(38);
P16(38)<='0';
P15(38)<='0';

P13(39)<=partial16(39);
P12(39)<=partial15(39);
P11(39)<=partial14(39);
P10(39)<=partial13(39);
P9(39)<=partial12(39);
P8(39)<=partial11(39);
P7(39)<=partial10(39);
P6(39)<=partial9(39);
P5(39)<=partial8(39);
P4(39)<=partial7(39);
P3(39)<=partial6(39);
P2(39)<=partial5(39);
P1(39)<=partial4(39);
P0(39)<=partial3(39);
P16(39)<='0';
P15(39)<='0';
P14(39)<='0';

P13(40)<=partial16(40);
P12(40)<=partial15(40);
P11(40)<=partial14(40);
P10(40)<=partial13(40);
P9(40)<=partial12(40);
P8(40)<=partial11(40);
P7(40)<=partial10(40);
P6(40)<=partial9(40);
P5(40)<=partial8(40);
P4(40)<=partial7(40);
P3(40)<=partial6(40);
P2(40)<=partial5(40);
P1(40)<=partial4(40);
P0(40)<=partial3(40);
P16(40)<='0';
P15(40)<='0';
P14(40)<='0';

P12(41)<=partial16(41);
P11(41)<=partial15(41);
P10(41)<=partial14(41);
P9(41)<=partial13(41);
P8(41)<=partial12(41);
P7(41)<=partial11(41);
P6(41)<=partial10(41);
P5(41)<=partial9(41);
P4(41)<=partial8(41);
P3(41)<=partial7(41);
P2(41)<=partial6(41);
P1(41)<=partial5(41);
P0(41)<=partial4(41);
P16(41)<='0';
P15(41)<='0';
P14(41)<='0';
P13(41)<='0';

P12(42)<=partial16(42);
P11(42)<=partial15(42);
P10(42)<=partial14(42);
P9(42)<=partial13(42);
P8(42)<=partial12(42);
P7(42)<=partial11(42);
P6(42)<=partial10(42);
P5(42)<=partial9(42);
P4(42)<=partial8(42);
P3(42)<=partial7(42);
P2(42)<=partial6(42);
P1(42)<=partial5(42);
P0(42)<=partial4(42);
P16(42)<='0';
P15(42)<='0';
P14(42)<='0';
P13(42)<='0';

P11(43)<=partial16(43);
P10(43)<=partial15(43);
P9(43)<=partial14(43);
P8(43)<=partial13(43);
P7(43)<=partial12(43);
P6(43)<=partial11(43);
P5(43)<=partial10(43);
P4(43)<=partial9(43);
P3(43)<=partial8(43);
P2(43)<=partial7(43);
P1(43)<=partial6(43);
P0(43)<=partial5(43);
P16(43)<='0';
P15(43)<='0';
P14(43)<='0';
P13(43)<='0';
P12(43)<='0';

P11(44)<=partial16(44);
P10(44)<=partial15(44);
P9(44)<=partial14(44);
P8(44)<=partial13(44);
P7(44)<=partial12(44);
P6(44)<=partial11(44);
P5(44)<=partial10(44);
P4(44)<=partial9(44);
P3(44)<=partial8(44);
P2(44)<=partial7(44);
P1(44)<=partial6(44);
P0(44)<=partial5(44);
P16(44)<='0';
P15(44)<='0';
P14(44)<='0';
P13(44)<='0';
P12(44)<='0';

P10(45)<=partial16(45);
P9(45)<=partial15(45);
P8(45)<=partial14(45);
P7(45)<=partial13(45);
P6(45)<=partial12(45);
P5(45)<=partial11(45);
P4(45)<=partial10(45);
P3(45)<=partial9(45);
P2(45)<=partial8(45);
P1(45)<=partial7(45);
P0(45)<=partial6(45);
P16(45)<='0';
P15(45)<='0';
P14(45)<='0';
P13(45)<='0';
P12(45)<='0';
P11(45)<='0';

P10(46)<=partial16(46);
P9(46)<=partial15(46);
P8(46)<=partial14(46);
P7(46)<=partial13(46);
P6(46)<=partial12(46);
P5(46)<=partial11(46);
P4(46)<=partial10(46);
P3(46)<=partial9(46);
P2(46)<=partial8(46);
P1(46)<=partial7(46);
P0(46)<=partial6(46);
P16(46)<='0';
P15(46)<='0';
P14(46)<='0';
P13(46)<='0';
P12(46)<='0';
P11(46)<='0';

P9(47)<=partial16(47);
P8(47)<=partial15(47);
P7(47)<=partial14(47);
P6(47)<=partial13(47);
P5(47)<=partial12(47);
P4(47)<=partial11(47);
P3(47)<=partial10(47);
P2(47)<=partial9(47);
P1(47)<=partial8(47);
P0(47)<=partial7(47);
P16(47)<='0';
P15(47)<='0';
P14(47)<='0';
P13(47)<='0';
P12(47)<='0';
P11(47)<='0';
P10(47)<='0';

P9(48)<=partial16(48);
P8(48)<=partial15(48);
P7(48)<=partial14(48);
P6(48)<=partial13(48);
P5(48)<=partial12(48);
P4(48)<=partial11(48);
P3(48)<=partial10(48);
P2(48)<=partial9(48);
P1(48)<=partial8(48);
P0(48)<=partial7(48);
P16(48)<='0';
P15(48)<='0';
P14(48)<='0';
P13(48)<='0';
P12(48)<='0';
P11(48)<='0';
P10(48)<='0';

P8(49)<=partial16(49);
P7(49)<=partial15(49);
P6(49)<=partial14(49);
P5(49)<=partial13(49);
P4(49)<=partial12(49);
P3(49)<=partial11(49);
P2(49)<=partial10(49);
P1(49)<=partial9(49);
P0(49)<=partial8(49);
P16(49)<='0';
P15(49)<='0';
P14(49)<='0';
P13(49)<='0';
P12(49)<='0';
P11(49)<='0';
P10(49)<='0';
P9(49)<='0';

P8(50)<=partial16(50);
P7(50)<=partial15(50);
P6(50)<=partial14(50);
P5(50)<=partial13(50);
P4(50)<=partial12(50);
P3(50)<=partial11(50);
P2(50)<=partial10(50);
P1(50)<=partial9(50);
P0(50)<=partial8(50);
P16(50)<='0';
P15(50)<='0';
P14(50)<='0';
P13(50)<='0';
P12(50)<='0';
P11(50)<='0';
P10(50)<='0';
P9(50)<='0';

P7(51)<=partial16(51);
P6(51)<=partial15(51);
P5(51)<=partial14(51);
P4(51)<=partial13(51);
P3(51)<=partial12(51);
P2(51)<=partial11(51);
P1(51)<=partial10(51);
P0(51)<=partial9(51);
P16(51)<='0';
P15(51)<='0';
P14(51)<='0';
P13(51)<='0';
P12(51)<='0';
P11(51)<='0';
P10(51)<='0';
P9(51)<='0';
P8(51)<='0';

P7(52)<=partial16(52);
P6(52)<=partial15(52);
P5(52)<=partial14(52);
P4(52)<=partial13(52);
P3(52)<=partial12(52);
P2(52)<=partial11(52);
P1(52)<=partial10(52);
P0(52)<=partial9(52);
P16(52)<='0';
P15(52)<='0';
P14(52)<='0';
P13(52)<='0';
P12(52)<='0';
P11(52)<='0';
P10(52)<='0';
P9(52)<='0';
P8(52)<='0';

P6(53)<=partial16(53);
P5(53)<=partial15(53);
P4(53)<=partial14(53);
P3(53)<=partial13(53);
P2(53)<=partial12(53);
P1(53)<=partial11(53);
P0(53)<=partial10(53);
P16(53)<='0';
P15(53)<='0';
P14(53)<='0';
P13(53)<='0';
P12(53)<='0';
P11(53)<='0';
P10(53)<='0';
P9(53)<='0';
P8(53)<='0';
P7(53)<='0';

P6(54)<=partial16(54);
P5(54)<=partial15(54);
P4(54)<=partial14(54);
P3(54)<=partial13(54);
P2(54)<=partial12(54);
P1(54)<=partial11(54);
P0(54)<=partial10(54);
P16(54)<='0';
P15(54)<='0';
P14(54)<='0';
P13(54)<='0';
P12(54)<='0';
P11(54)<='0';
P10(54)<='0';
P9(54)<='0';
P8(54)<='0';
P7(54)<='0';

P5(55)<=partial16(55);
P4(55)<=partial15(55);
P3(55)<=partial14(55);
P2(55)<=partial13(55);
P1(55)<=partial12(55);
P0(55)<=partial11(55);
P16(55)<='0';
P15(55)<='0';
P14(55)<='0';
P13(55)<='0';
P12(55)<='0';
P11(55)<='0';
P10(55)<='0';
P9(55)<='0';
P8(55)<='0';
P7(55)<='0';
P6(55)<='0';

P5(56)<=partial16(56);
P4(56)<=partial15(56);
P3(56)<=partial14(56);
P2(56)<=partial13(56);
P1(56)<=partial12(56);
P0(56)<=partial11(56);
P16(56)<='0';
P15(56)<='0';
P14(56)<='0';
P13(56)<='0';
P12(56)<='0';
P11(56)<='0';
P10(56)<='0';
P9(56)<='0';
P8(56)<='0';
P7(56)<='0';
P6(56)<='0';

P4(57)<=partial16(57);
P3(57)<=partial15(57);
P2(57)<=partial14(57);
P1(57)<=partial13(57);
P0(57)<=partial12(57);
P16(57)<='0';
P15(57)<='0';
P14(57)<='0';
P13(57)<='0';
P12(57)<='0';
P11(57)<='0';
P10(57)<='0';
P9(57)<='0';
P8(57)<='0';
P7(57)<='0';
P6(57)<='0';
P5(57)<='0';

P4(58)<=partial16(58);
P3(58)<=partial15(58);
P2(58)<=partial14(58);
P1(58)<=partial13(58);
P0(58)<=partial12(58);
P16(58)<='0';
P15(58)<='0';
P14(58)<='0';
P13(58)<='0';
P12(58)<='0';
P11(58)<='0';
P10(58)<='0';
P9(58)<='0';
P8(58)<='0';
P7(58)<='0';
P6(58)<='0';
P5(58)<='0';

P3(59)<=partial16(59);
P2(59)<=partial15(59);
P1(59)<=partial14(59);
P0(59)<=partial13(59);
P16(59)<='0';
P15(59)<='0';
P14(59)<='0';
P13(59)<='0';
P12(59)<='0';
P11(59)<='0';
P10(59)<='0';
P9(59)<='0';
P8(59)<='0';
P7(59)<='0';
P6(59)<='0';
P5(59)<='0';
P4(59)<='0';

P3(60)<=partial16(60);
P2(60)<=partial15(60);
P1(60)<=partial14(60);
P0(60)<=partial13(60);
P16(60)<='0';
P15(60)<='0';
P14(60)<='0';
P13(60)<='0';
P12(60)<='0';
P11(60)<='0';
P10(60)<='0';
P9(60)<='0';
P8(60)<='0';
P7(60)<='0';
P6(60)<='0';
P5(60)<='0';
P4(60)<='0';

P2(61)<=partial16(61);
P1(61)<=partial15(61);
P0(61)<=partial14(61);
P16(61)<='0';
P15(61)<='0';
P14(61)<='0';
P13(61)<='0';
P12(61)<='0';
P11(61)<='0';
P10(61)<='0';
P9(61)<='0';
P8(61)<='0';
P7(61)<='0';
P6(61)<='0';
P5(61)<='0';
P4(61)<='0';
P3(61)<='0';

P2(62)<=partial16(62);
P1(62)<=partial15(62);
P0(62)<=partial14(62);
P16(62)<='0';
P15(62)<='0';
P14(62)<='0';
P13(62)<='0';
P12(62)<='0';
P11(62)<='0';
P10(62)<='0';
P9(62)<='0';
P8(62)<='0';
P7(62)<='0';
P6(62)<='0';
P5(62)<='0';
P4(62)<='0';
P3(62)<='0';

P1(63)<=partial16(63);
P0(63)<=partial15(63);
P16(63)<='0';
P15(63)<='0';
P14(63)<='0';
P13(63)<='0';
P12(63)<='0';
P11(63)<='0';
P10(63)<='0';
P9(63)<='0';
P8(63)<='0';
P7(63)<='0';
P6(63)<='0';
P5(63)<='0';
P4(63)<='0';
P3(63)<='0';
P2(63)<='0';

-----------------------

--P0 <= partial0;
--P1 <= partial1;
--P2 <= partial2;
--P3 <= partial3;
--P4 <= partial4;
--P5 <= partial5;
--P6 <= partial6;
--P7 <= partial7;
--P8 <= partial8;
--P9 <= partial9;
--P10 <= partial10;
--P11 <= partial11;
--P12 <= partial12;
--P13 <= partial13;
--P14 <= partial14;
--P15 <= partial15;
--P16 <= partial16;


end beh;
