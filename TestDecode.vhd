--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:48:51 05/14/2019
-- Design Name:   
-- Module Name:   /home/mampiani/Bureau/INSA_study/4A/VHDL/Compilateur/TestDecode.vhd
-- Project Name:  Compilateur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decode
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
 
ENTITY TestDecode IS
END TestDecode;
 
ARCHITECTURE behavior OF TestDecode IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decode
    PORT(
         CLK : IN  std_logic;
         ins_di : IN  std_logic_vector(31 downto 0);
         A : OUT  std_logic_vector(15 downto 0);
         OP: OUT  std_logic_vector(7  downto 0);
         B : OUT  std_logic_vector(15 downto 0);
         C : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal CLK : std_logic := '0';
   signal ins_di : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal A : std_logic_vector(15 downto 0);
   signal OP: std_logic_vector(7  downto 0);
   signal B : std_logic_vector(15 downto 0);
   signal C : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decode PORT MAP (
          CLK => CLK,
          ins_di => ins_di,
          A => A,
          OP => OP,
          B => B,
          C => C
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

	ins_di <= X"00000000", X"09AABBCC" after 200 ns, X"0AAABBCC" after 250 ns;
END;
