-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench_comp IS
  END testbench_comp;

  ARCHITECTURE behavior OF testbench_comp IS 

  -- Component Declaration
          COMPONENT Computer
				PORT(
					reset : IN std_logic
            );
          END COMPONENT;          

	signal s_reset: STD_LOGIC := '0';
  BEGIN

  -- Component Instantiation
          uut: Computer PORT MAP(
                  reset => s_reset
          );

	s_reset <= '0', '1' after 10 ns;
  END;
