----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:12:14 05/07/2019 
-- Design Name: 
-- Module Name:    Decode - Behavioral 
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

entity Decode is
	port ( CLK : in STD_LOGIC;
			 ins_di : in STD_LOGIC_VECTOR (31 downto 0);
			 A : out STD_LOGIC_VECTOR (15 downto 0);
			 OP: out STD_LOGIC_VECTOR (7 downto 0);
			 B : out STD_LOGIC_VECTOR (15 downto 0);
			 C : out STD_LOGIC_VECTOR (15 downto 0)
			);
end Decode;

architecture Behavioral of Decode is
	signal tmpOP: STD_LOGIC_VECTOR (7  downto 0);
begin
	
	tmpOP <= ins_di (31 downto 24);
	
	-- AFC (0x06), LOAD (0x07): B on 16 bits
	-- If add give A to B & B to C
	A <= 	X"00" & 	ins_di (23 downto 16) when tmpOP = X"06" or tmpOP = X"07" 						else
						ins_di (23 downto 8)  when tmpOP = X"08" 						 						else 
			X"00" &  ins_di (23 downto 16);
		
	B <=         	ins_di (15 downto 0)  when tmpOP = X"06" or tmpOP = X"07" 						else 
			X"00" & 	ins_di (7  downto 0)  when tmpOP = X"08" 												else 
			X"00" &  ins_di (15 downto 8);
			
	C <= X"0000"                   		 when tmpOP = X"06" or tmpOP = X"07" or tmpOP = X"08" else 
		  X"00"  &  ins_di (7  downto 0);

	OP <= tmpOP;

end Behavioral;

