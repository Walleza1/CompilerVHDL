----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:03:26 05/07/2019 
-- Design Name: 
-- Module Name:    Processor - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Processor is
    port (
--			ins_a  : out STD_LOGIC_VECTOR (15 downto 0);
--			ins_di : in  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
			CLK    : in STD_LOGIC;
			reset  : in STD_LOGIC;
			data_do: out STD_LOGIC_VECTOR (15 downto 0);
			data_a : out STD_LOGIC_VECTOR (15 downto 0);
			data_we: out STD_LOGIC;
			data_di: in  STD_LOGIC_VECTOR (15 downto 0) := (others => '0')
		);
end Processor;

architecture Behavioral of Processor is
	component Decode
		port (
			CLK   : in  STD_LOGIC;
			ins_di: in  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
			A     : out STD_LOGIC_VECTOR (15 downto 0);
			OP    : out STD_LOGIC_VECTOR (7  downto 0);
			B     : out STD_LOGIC_VECTOR (15 downto 0);
			C     : out STD_LOGIC_VECTOR (15 downto 0)
		);
	end component;

	component Pipeline
		port (
			CLK  : in  STD_LOGIC;
			alea : in  STD_LOGIC := '0';
			inA  : in  STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
			outA : out STD_LOGIC_VECTOR (15 downto 0);
			inOP : in  STD_LOGIC_VECTOR (7  downto 0) := (others => '0');
			outOP: out STD_LOGIC_VECTOR (7  downto 0);
			inB  : in  STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
			outB : out STD_LOGIC_VECTOR (15 downto 0);
			inC  : in  STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
			outC : out STD_LOGIC_VECTOR (15 downto 0));
	end component;

	component ALU
		port(
			A   : in  STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
			B   : in  STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
			OP  : in  STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
			S   : out STD_LOGIC_VECTOR(15 downto 0);
			FLAG: out STD_LOGIC_VECTOR(3 downto 0)
		);
    end component;

	 component RegistersFile
		Port (
			RST  : in  STD_LOGIC                     := '0';
			CLK  : in  STD_LOGIC                     := '0';
			addrA: in  STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
			addrB: in  STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
			QA   : out STD_LOGIC_VECTOR (7 downto 0);
			QB   : out STD_LOGIC_VECTOR (7 downto 0);
			W    : in  STD_LOGIC                     := '0';
			addrW: in  STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
			DATA : in  STD_LOGIC_VECTOR (7 downto 0) := (others => '0')
		);
	end component;

	component instr_memory
		generic (
			LEN_SEL: natural   := 16;
			LEN_INSTR: natural := 32
		);
		Port (
			sel: in  STD_LOGIC_VECTOR (LEN_SEL-1   downto 0);
			q  : out STD_LOGIC_VECTOR (LEN_INSTR-1 downto 0)
		);
	end component;
	
	component compteur
		generic (
			N: natural := 16
		);
		Port (
			CK  : in  STD_LOGIC;
         RST : in  STD_LOGIC;
         LOAD: in  STD_LOGIC;
         SENS: in  STD_LOGIC;
			EN  : in  STD_LOGIC;
         Din : in  STD_LOGIC_VECTOR (N-1 downto 0);
         Dout: out STD_LOGIC_VECTOR (N-1 downto 0)
		);
	end component;

	component AleaSupervisor
		Port (
			P1_A : in  STD_LOGIC_VECTOR (15 downto 0);
			P1_OP: in  STD_LOGIC_VECTOR (7  downto 0);
         P1_B : in  STD_LOGIC_VECTOR (15 downto 0);
         P1_C : in  STD_LOGIC_VECTOR (15 downto 0);
         P2_A : in  STD_LOGIC_VECTOR (15 downto 0);
         P2_OP: in  STD_LOGIC_VECTOR (7  downto 0);
         P2_B : in  STD_LOGIC_VECTOR (15 downto 0);
         P2_C : in  STD_LOGIC_VECTOR (15 downto 0);
         P3_A : in  STD_LOGIC_VECTOR (15 downto 0);
         P3_OP: in  STD_LOGIC_VECTOR (7  downto 0);
         P3_B : in  STD_LOGIC_VECTOR (15 downto 0);
         P3_C : in  STD_LOGIC_VECTOR (15 downto 0);
			alea : out STD_LOGIC
		);
	end component;

	type stage_record is record
		op: STD_LOGIC_VECTOR (7 downto 0);
		a, b, c: STD_LOGIC_VECTOR (15 downto 0);
	end record;

	-- Internal
	signal s_ins_a, s_compteur_din : STD_LOGIC_VECTOR (15 downto 0);
	signal s_compteur_load, s_alea : STD_LOGIC := '0';
	signal s_ins_di: STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

	signal s_decode, s_pi1, s_pi2, s_pi3, s_pi4: stage_record;
	signal s_lc1: STD_LOGIC_VECTOR (7 downto 0);
	signal s_lc3: STD_LOGIC := '0';
	signal s_mux1, s_mux2, s_mux3: STD_LOGIC_VECTOR (15 downto 0);
	signal s_mux4: STD_LOGIC_VECTOR (7 downto 0);
	signal s_registers_qa, s_registers_qb: STD_LOGIC_VECTOR (7 downto 0);
	signal s_out_alu: STD_LOGIC_VECTOR (15 downto 0);

begin

	c_decode: Decode PORT MAP (
		CLK    => CLK,
		ins_di => s_ins_di,
		A      => s_decode.a,
		OP     => s_decode.op,
		B      => s_decode.b,
		C      => s_decode.c
	);

	c_alu: ALU PORT MAP (
		A    => s_pi2.b,
		B    => s_pi2.c,
		OP   => s_lc1,
		S    => s_out_alu,
		FLAG => open
	);

	c_registers_file: RegistersFile PORT MAP (
		RST   => reset,
		CLK   => CLK,
		addrA => s_pi1.b (3 downto 0),
		addrB => s_pi1.c (3 downto 0),
		QA    => s_registers_qa,
		QB    => s_registers_qb,
		W     => s_lc3,
		addrW => s_pi4.a (3 downto 0),
		DATA  => s_mux4
	);

	c_instr_memory: instr_memory PORT MAP (
		sel => s_ins_a,
		q   => s_ins_di
	);

	c_ip: compteur PORT MAP (
		CK   => CLK,
		RST  => reset,
		LOAD => s_compteur_load,
		SENS => '1',
		EN   => s_alea,
		Din  => s_compteur_din,
		Dout => s_ins_a
	);

	c_pi1: Pipeline PORT MAP(
		CLK   => CLK,
		alea  => s_alea,
		inA   => s_decode.a,
		outA  => s_pi1.a,
		inOP  => s_decode.op,
		outOP => s_pi1.op,
		inB   => s_decode.b,
		outB  => s_pi1.b,
		inC   => s_decode.c,
		outC  => s_pi1.c
	);

	c_pi2: Pipeline PORT MAP(
		CLK   => CLK,
		alea  => '0',
		inA   => s_pi1.a,
		outA  => s_pi2.a,
		inOP  => s_pi1.op,
		outOP => s_pi2.op,
		inB   => s_mux1,
		outB  => s_pi2.b,
		inC   => X"00" & s_registers_qb,
		outC  => s_pi2.c
	);

	c_pi3: Pipeline PORT MAP(
		CLK   => CLK,
		alea  => '0',
		inA   => s_pi2.a,
		outA  => s_pi3.a,
		inOP  => s_pi2.op,
		outOP => s_pi3.op,
		inB   => s_mux2,
		outB  => s_pi3.b,
		inC   => X"0000",
		outC  => open
	);

	c_pi4: Pipeline PORT MAP(
		CLK   => CLK,
		alea  => '0',
		inA   => s_pi3.a,
		outA  => s_pi4.a,
		inOP  => s_pi3.op,
		outOP => s_pi4.op,
		inB   => s_pi3.b,
		outB  => s_pi4.b,
		inC   => X"0000",
		outC  => open
	);

	s_alea_supervisor: AleaSupervisor PORT MAP(
		P1_A  => s_decode.a,
		P1_OP => s_decode.op,
      P1_B  => s_decode.b,
      P1_C  => s_decode.c,
      P2_A  => s_pi1.a,
      P2_OP => s_pi1.op,
      P2_B  => s_pi1.b,
      P2_C  => s_pi1.c,
      P3_A  => s_pi2.a,
      P3_OP => s_pi2.op,
      P3_B  => s_pi2.b,
      P3_C  => s_pi2.c,
		alea  => s_alea
	);

	-- LC1 ALU            - ADD, SUB, MUL, DIV: 0x01 to 0x04
	s_lc1 <= s_pi2.op when s_pi2.op <= X"04" else
				s_pi2.op when s_pi2.op = X"09"  else
				s_pi2.op when s_pi2.op = X"0A"
				else X"00";
	-- LC2 data memory    - STORE: 0x08
	-- LC3 registers file - STORE: 0x08, do not write on registers
	s_lc3 <= '1' when s_pi4.op = X"01"
						or s_pi4.op = X"02"
						or s_pi4.op = X"03"
						or s_pi4.op = X"04"
						or s_pi4.op = X"05"
						or s_pi4.op = X"06"
						or s_pi4.op = X"07"
						or s_pi4.op = X"09"
						or s_pi4.op = X"0A"
						or s_pi4.op = X"0B"
						or s_pi4.op = X"0C"
						or s_pi4.op = X"0D"
					  else '0';

	-- MUX1 - ADD 0x01 -- MUL : 0x02 -- SUB : 0x03 -- DIV : 0x04 -- COP: 0x05
	-- Don't forget STORE 0x08
	s_mux1 <= X"00" & s_registers_qa when s_pi1.op=X"01" 
							or s_pi1.op = X"02" 
							or s_pi1.op = X"03" 
							or s_pi1.op = X"04" 
							or s_pi1.op = X"05" 
							or s_pi1.op = X"08"
							or s_pi1.op = X"09" -- EQ
							or s_pi1.op = X"0A" -- INF
							else s_pi1.b;
	-- MUX2 - ADD, SUB, MUL, DIV: 0x01 to 0x04
	s_mux2 <= s_out_alu when s_pi2.op <= X"04" else
				 s_out_alu when s_pi2.op = X"09"  else
				 s_out_alu when s_pi2.op = X"0A"  else
				 s_pi2.b;
	-- MUX4 - LOAD: 0x07

	s_mux4 <= data_di (7 downto 0) when s_pi4.op = X"07" else s_pi4.b (7 downto 0);
	
	-- MUX3 - STORE: 0x08
	data_a <= s_pi3.a when s_pi3.op = X"08" else s_pi3.b;
	data_do <= s_pi3.b;
	data_we <= '1' when s_pi3.op = X"08" else '0';
	
	
	-- JMP, JMPC after the 2nd pipeline
	s_compteur_load <= '1' when s_pi2.op = X"0E" or (s_pi2.op = X"0F" and s_pi2.c = X"0000") else '0';
	s_compteur_din <= s_pi2.b;

end Behavioral;
