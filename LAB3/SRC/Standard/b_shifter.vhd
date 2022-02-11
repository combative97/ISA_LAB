library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

Entity b_shifter is   -- barrel shifter
      port (
            shift   : in  std_logic_vector(4 downto 0);  -- shift count
            input   : in  std_logic_vector (63 downto 0);
            output  : out std_logic_vector (63 downto 0) );
end entity b_shifter;


architecture rtl of b_shifter is

component mux32 is
port(
	in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16 : in std_logic_vector(63 downto 0);
	in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31,in32 : in std_logic_vector(63 downto 0);
	sel : in std_logic_vector(4 downto 0);
	out_mux : out std_logic_vector(63 downto 0)
);
end component;


signal sh1,sh2,sh3,sh4,sh5,sh6,sh7,sh8,sh9,sh10,sh11,sh12,sh13,sh14,sh15,sh16 : std_logic_vector(63 downto 0);
signal sh17,sh18,sh19,sh20,sh21,sh22,sh23,sh24,sh25,sh26,sh27,sh28,sh29,sh30,sh31,sh32 : std_logic_vector(63 downto 0);

begin 

sh1 <= input;
sh2(63 downto 62) <= (others=>input(63)); sh2(61 downto 0) <= input(62 downto 1);
sh3(63 downto 61) <= (others=>input(63)); sh3(60 downto 0) <= input(62 downto 2);
sh4(63 downto 60) <= (others=>input(63)); sh4(59 downto 0) <= input(62 downto 3);
sh5(63 downto 59) <= (others=>input(63)); sh5(58 downto 0) <= input(62 downto 4);
sh6(63 downto 58) <= (others=>input(63)); sh6(57 downto 0) <= input(62 downto 5);
sh7(63 downto 57) <= (others=>input(63)); sh7(56 downto 0) <= input(62 downto 6);
sh8(63 downto 56) <= (others=>input(63)); sh8(55 downto 0) <= input(62 downto 7);
sh9(63 downto 55) <= (others=>input(63)); sh9(54 downto 0) <= input(62 downto 8);
sh10(63 downto 54) <= (others=>input(63)); sh10(53 downto 0) <= input(62 downto 9);
sh11(63 downto 53) <= (others=>input(63)); sh11(52 downto 0) <= input(62 downto 10);
sh12(63 downto 52) <= (others=>input(63)); sh12(51 downto 0) <= input(62 downto 11);
sh13(63 downto 51) <= (others=>input(63)); sh13(50 downto 0) <= input(62 downto 12);
sh14(63 downto 50) <= (others=>input(63)); sh14(49 downto 0) <= input(62 downto 13);
sh15(63 downto 49) <= (others=>input(63)); sh15(48 downto 0) <= input(62 downto 14);
sh16(63 downto 48) <= (others=>input(63)); sh16(47 downto 0) <= input(62 downto 15);
sh17(63 downto 47) <= (others=>input(63)); sh17(46 downto 0) <= input(62 downto 16);
sh18(63 downto 46) <= (others=>input(63)); sh18(45 downto 0) <= input(62 downto 17);
sh19(63 downto 45) <= (others=>input(63)); sh19(44 downto 0) <= input(62 downto 18);
sh20(63 downto 44) <= (others=>input(63)); sh20(43 downto 0) <= input(62 downto 19);
sh21(63 downto 43) <= (others=>input(63)); sh21(42 downto 0) <= input(62 downto 20);
sh22(63 downto 42) <= (others=>input(63)); sh22(41 downto 0) <= input(62 downto 21);
sh23(63 downto 41) <= (others=>input(63)); sh23(40 downto 0) <= input(62 downto 22);
sh24(63 downto 40) <= (others=>input(63)); sh24(39 downto 0) <= input(62 downto 23);
sh25(63 downto 39) <= (others=>input(63)); sh25(38 downto 0) <= input(62 downto 24);
sh26(63 downto 38) <= (others=>input(63)); sh26(37 downto 0) <= input(62 downto 25);
sh27(63 downto 37) <= (others=>input(63)); sh27(36 downto 0) <= input(62 downto 26);
sh28(63 downto 36) <= (others=>input(63)); sh28(35 downto 0) <= input(62 downto 27);
sh29(63 downto 35) <= (others=>input(63)); sh29(34 downto 0) <= input(62 downto 28);
sh30(63 downto 34) <= (others=>input(63)); sh30(33 downto 0) <= input(62 downto 29);
sh31(63 downto 33) <= (others=>input(63)); sh31(32 downto 0) <= input(62 downto 30);
sh32(63 downto 32) <= (others=>input(63)); sh32(31 downto 0) <= input(62 downto 31);

out_mux : mux32 port map(sh1,sh2,sh3,sh4,sh5,sh6,sh7,sh8,sh9,sh10,sh11,sh12,sh13,sh14,sh15,sh16,sh17,sh18,sh19,sh20,sh21,sh22,sh23,sh24,sh25,sh26,sh27,sh28,sh29,sh30,sh31,sh32,shift,output);

end architecture rtl;  -- of bshift
