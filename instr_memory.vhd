library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.common.all;


entity instr_memory is
	generic(
		LEN_SEL: natural := 16;
		LEN_INSTR: natural := 32
	);
	port(
		sel: in std_logic_vector(LEN_SEL-1 downto 0);
		q: out std_logic_vector(LEN_INSTR-1 downto 0)
	);
end entity;


architecture beh of instr_memory is

	--signal instr_memory: instrArray := init_rom(filename => "<path_to_your_code>");

	signal instr_memory: instrArray := (
		0 => x"0601ABCD", -- AFC 1 5 ( r1 <= 0xABCD )      // r1 = 0xCD
		1 => x"05020100", -- COP 2 1   ( r2 <= r1 )        // r1 = 0xCD, r2 = 0xCD
		2 => x"01030102", -- ADD 3 1 2 ( r3 <= r2 + r1 )   // r1 = 0xCD, r2 = 0xCD, r3 = 2 * 0xCD = 0x9A
		3 => x"02030301", -- MUL 3 3 1 ( r3 <= r3 * r1 )   // r1 = 0xCD, r2 = 0xCD, r3 = 0x52
		4 => x"03040103", -- SOU 4 1 3 ( r4 <= r1 - r3 )   // r1 = 0xCD, r2 = 0xCD, r3 = 0x52, r4 = 0x7B
		5 => x"0E000800", -- JMP 0X0008
		8 => X"08000104", -- STORE @0001 04 ( STORE (7b) )
		9 => X"07050001", -- LOAD 05 @0001 ( r5 <= LOAD(0001) )
		10 => X"09060504", -- EQ 06 05 04 ( r6 <= EQ(r5,r4) ) -- EQ(x,y) = 1 if x = y else 0
		11 => X"0A060504", -- EQ 06 05 04 ( r6 <= EQ(r5,r4) ) -- EQ(x,y) = 1 if x = y else 0
		others => x"90FFFFFF"
	);

begin

	q <= instr_memory(to_integer(unsigned(sel)));

end architecture;
