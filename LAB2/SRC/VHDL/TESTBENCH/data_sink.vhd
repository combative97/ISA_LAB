library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_sink is
  port (
    CLK   : in std_logic;
    DIN   : in std_logic_vector(31 downto 0));
end data_sink;

architecture beh of data_sink is

begin  -- beh

  process (CLK)
    file res_fp : text open WRITE_MODE is "/home/isa28_2021_2022/LAB2/fpuvhdl/fp_prod_VHDL_Pipe_MBE.hex";
    variable line_out : line;    
  begin  -- process
    if CLK'event and CLK = '1' then  -- rise
        hwrite(line_out, DIN);
        writeline(res_fp, line_out);
    end if;
  end process;

end beh;
