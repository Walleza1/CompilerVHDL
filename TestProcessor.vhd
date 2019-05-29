-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 
  -- Component Declaration
          COMPONENT Processor
				 PORT(
--					ins_a  : out STD_LOGIC_VECTOR (15 downto 0);
--					ins_di : in  STD_LOGIC_VECTOR (31 downto 0);
					CLK    : in  STD_LOGIC;
					reset  : in  STD_LOGIC := '0';
					data_do: out STD_LOGIC_VECTOR (15 downto 0);
					data_a : out STD_LOGIC_VECTOR (15 downto 0);
					data_we: out STD_LOGIC;
					data_di: in  STD_LOGIC_VECTOR (15 downto 0)
				 );
          END COMPONENT;

--signal ins_a : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
--signal ins_di : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal data_do :STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

signal data_a :STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal data_we :STD_LOGIC := '0';
signal data_di :STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

signal reset: STD_LOGIC := '0';

	-- No clocks detected in port list. Replace CK below with
	-- appropriate port name
	signal CLK:          STD_LOGIC := '0';
	constant CLK_period: time      := 10 ns;

  BEGIN
  -- Clock process definitions
	CLK_process: process
	begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
	end process;
	
  -- Component Instantiation
	uut: Processor PORT MAP(
--			ins_a => ins_a,
--			ins_di => ins_di,
			CLK     => CLK,
			reset   => reset,
			data_do => data_do,
			data_a  => data_a,
			data_we => data_we,
			data_di => data_di
	);

	reset <= '1' after 10 ns;

	-- MUL
	-- DIV
	-- LOAD
	-- STORE
--	ins_di <= X"00000000",
--		-- AFC 1 5 ( r1 <= 0xABCD )      // r1 = 0xCD
--			X"0601ABCD" after 100 ns,
--		-- COP 2 1   ( r2 <= r1 )        // r1 = 0xCD, r2 = 0xCD
--			X"05020100" after 200 ns,
--		-- ADD 3 1 2 ( r3 <= r2 + r1 )   // r1 = 0xCD, r2 = 0xCD, r3 = 2 * 0xCD = 0x9A
--			X"01030102" after 300 ns,
--		-- MUL 3 3 1 ( r3 <= r3 * r1 )   // r1 = 0xCD, r2 = 0xCD, r3 = 0x52
--			X"02030301" after 400 ns,
--		-- SOU 4 1 3 ( r4 <= r1 - r3 )   // r1 = 0xCD, r2 = 0xCD, r3 = 0x52, r4 = 0x7B
--			X"03040103" after 430 ns;
  END;
