----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:54:37 05/20/2019 
-- Design Name: 
-- Module Name:    AleaSupervisor - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AleaSupervisor is
    Port ( P1_A : in  STD_LOGIC_VECTOR (15 downto 0);
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
			  alea : out STD_LOGIC);
end AleaSupervisor;

architecture Behavioral of AleaSupervisor is
	signal writing_2_3 : STD_LOGIC;
	signal reading_1 : STD_LOGIC;
	signal same_register : STD_LOGIC;
begin

	writing_2_3 <= '1' when(P2_OP = X"01"
									or P2_OP = X"02"
									or P2_OP = X"03"
									or P2_OP = X"04"
									or P2_OP = X"05"
									or P2_OP = X"06"
									or P2_OP = X"07"
									or P2_OP = X"09"
									or P2_OP = X"0A"
									or P3_OP = X"01"
									or P3_OP = X"02"
									or P3_OP = X"03"
									or P3_OP = X"04"
									or P3_OP = X"05"
									or P3_OP = X"06"
									or P3_OP = X"07"
									or P3_OP = X"09"
									or P3_OP = X"0A")
						else '0';
				
				
				
	reading_1 <= '1' when (P1_OP = X"01"
									or P1_OP = X"02"
									or P1_OP = X"03"
									or P1_OP = X"04"
									or P1_OP = X"05"
									or P1_OP = X"08"
									or P1_OP = X"09"
									or P1_OP = X"0A"
									or P1_OP = X"0F")
						else '0';

	same_register <= '1' when P2_A = P1_B 
									or (P2_A = P1_C and P1_OP /= X"05" and P1_OP /= X"07" and P1_OP /= X"0E")
									or P3_A = P1_B
									or (P3_A = P1_C and P1_OP /= X"05" and P1_OP /= X"07" and P1_OP /= X"0E")
						else '0';
	
	alea <= '1' when same_register = '1' and reading_1 = '1' and writing_2_3 = '1' 
						else '0';
end Behavioral;

