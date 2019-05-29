--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:01:08 05/27/2019
-- Design Name:   
-- Module Name:   /home/mampiani/Bureau/INSA_study/4A/VHDL/Compilateur/TestAleaSupervisor.vhd
-- Project Name:  Compilateur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: AleaSupervisor
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
 
ENTITY TestAleaSupervisor IS
END TestAleaSupervisor;
 
ARCHITECTURE behavior OF TestAleaSupervisor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT AleaSupervisor
    PORT(
         P1_A : IN  std_logic_vector(15 downto 0);
         P1_OP: IN  std_logic_vector(7  downto 0);
         P1_B : IN  std_logic_vector(15 downto 0);
         P1_C : IN  std_logic_vector(15 downto 0);
         P2_A : IN  std_logic_vector(15 downto 0);
         P2_OP: IN  std_logic_vector(7  downto 0);
         P2_B : IN  std_logic_vector(15 downto 0);
         P2_C : IN  std_logic_vector(15 downto 0);
         P3_A : IN  std_logic_vector(15 downto 0);
         P3_OP: IN  std_logic_vector(7  downto 0);
         P3_B : IN  std_logic_vector(15 downto 0);
         P3_C : IN  std_logic_vector(15 downto 0);
         alea : OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal P1_A : std_logic_vector(15 downto 0) := (others => '0');
   signal P1_OP: std_logic_vector(7  downto 0) := (others => '0');
   signal P1_B : std_logic_vector(15 downto 0) := (others => '0');
   signal P1_C : std_logic_vector(15 downto 0) := (others => '0');
   signal P2_A : std_logic_vector(15 downto 0) := (others => '0');
   signal P2_OP: std_logic_vector(7  downto 0) := (others => '0');
   signal P2_B : std_logic_vector(15 downto 0) := (others => '0');
   signal P2_C : std_logic_vector(15 downto 0) := (others => '0');
   signal P3_A : std_logic_vector(15 downto 0) := (others => '0');
   signal P3_OP: std_logic_vector(7  downto 0) := (others => '0');
   signal P3_B : std_logic_vector(15 downto 0) := (others => '0');
   signal P3_C : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal alea : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	signal CLK : STD_LOGIC := '0';
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AleaSupervisor PORT MAP (
          P1_A => P1_A,
          P1_OP => P1_OP,
          P1_B => P1_B,
          P1_C => P1_C,
          P2_A => P2_A,
          P2_OP => P2_OP,
          P2_B => P2_B,
          P2_C => P2_C,
          P3_A => P3_A,
          P3_OP => P3_OP,
          P3_B => P3_B,
          P3_C => P3_C,
          alea => alea
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
   --       aléa     pas aléa           pas aléa              aléa
	P1_OP <= X"01";
	P1_A  <= X"0001";
	P1_B  <= X"0002";
	P1_C  <= X"0003";
	
	P2_OP <= X"01",   X"90" after 20 ns, X"01"   after 100 ns;
	P2_A  <= X"0002",                    X"0009" after 100 ns;
	P2_B  <= X"0004";
	P2_C  <= X"0005";
	
	P3_OP <= X"90",                                            X"90"   after 150 ns;
	P3_A  <= X"0006",                                          X"0003" after 150 ns;
	P3_B  <= X"0007";
	P3_C  <= X"0008";
END;
