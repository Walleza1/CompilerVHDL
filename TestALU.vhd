--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:11:00 04/18/2019
-- Design Name:   
-- Module Name:   /home/mampiani/Bureau/INSA_study/4A/VHDL/Compilateur/TestALU.vhd
-- Project Name:  Compilateur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TestALU IS
END TestALU;
 
ARCHITECTURE behavior OF TestALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         OP : IN  std_logic_vector(7 downto 0);
         S : OUT  std_logic_vector(15 downto 0);
         FLAG : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal OP : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(15 downto 0);
   signal FLAG : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace CK below with 
   -- appropriate port name 
	signal CK : STD_LOGIC := '0';
   constant CK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          OP => OP,
          S => S,
          FLAG => FLAG
        );

   -- Clock process definitions
   CK_process :process
   begin
		CK <= '0';
		wait for CK_period/2;
		CK <= '1';
		wait for CK_period/2;
   end process;
	
	
	OP <= X"09", X"0A" after 100 ns;
	A <= X"0001", X"0002" after 50 ns;
	B <= X"0010", X"0001" after 20 ns, X"0010" after 80 ns;
END;
