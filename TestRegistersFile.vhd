--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:09:19 05/07/2019
-- Design Name:   
-- Module Name:   /home/mampiani/Bureau/INSA_study/4A/VHDL/Compilateur/TestRegistersFile.vhd
-- Project Name:  Compilateur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegistersFile
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
 
ENTITY TestRegistersFile IS
END TestRegistersFile;
 
ARCHITECTURE behavior OF TestRegistersFile IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegistersFile
    PORT(
         RST : IN  std_logic;
         CLK : IN  std_logic;
         addrA : IN  std_logic_vector(3 downto 0);
         addrB : IN  std_logic_vector(3 downto 0);
         QA : OUT  std_logic_vector(7 downto 0);
         QB : OUT  std_logic_vector(7 downto 0);
         W : IN  std_logic;
         addrW : IN  std_logic_vector(3 downto 0);
         DATA : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';
   signal addrA : std_logic_vector(3 downto 0) := (others => '0');
   signal addrB : std_logic_vector(3 downto 0) := (others => '0');
   signal W : std_logic := '0';
   signal addrW : std_logic_vector(3 downto 0) := (others => '0');
   signal DATA : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal QA : std_logic_vector(7 downto 0);
   signal QB : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegistersFile PORT MAP (
          RST => RST,
          CLK => CLK,
          addrA => addrA,
          addrB => addrB,
          QA => QA,
          QB => QB,
          W => W,
          addrW => addrW,
          DATA => DATA
        );

   -- Clock process definitions
   CLK_process: process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
	RST <= '0', '1' after 100 ns;
	DATA <= X"00",X"F0" after 150 ns;
	addrW <= X"4", X"0" after 270 ns;
	W <= '0', '1' after 200 ns, '0' after 300 ns;
	addrA <= X"4" after 250 ns;
	addrB <= X"4" after 350 ns;
	
END;
