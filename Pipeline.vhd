----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:45:37 05/07/2019 
-- Design Name: 
-- Module Name:    Pipeline - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pipeline is
    Port ( CLK  : in  STD_LOGIC;
			  alea : in  STD_LOGIC;
			  inA  : in  STD_LOGIC_VECTOR (15 downto 0);
           outA : out STD_LOGIC_VECTOR (15 downto 0);
           inOP : in  STD_LOGIC_VECTOR (7  downto 0);
           outOP: out STD_LOGIC_VECTOR (7  downto 0);
           inB  : in  STD_LOGIC_VECTOR (15 downto 0);
           outB : out STD_LOGIC_VECTOR (15 downto 0);
           inC  : in  STD_LOGIC_VECTOR (15 downto 0);
           outC : out STD_LOGIC_VECTOR (15 downto 0)
	);
end Pipeline;

architecture Behavioral of Pipeline is

begin
	process
		begin
			wait until rising_edge(CLK);
			if alea = '1' then
				outOP <= X"90";
			else
				outOP <= inOP;
			end if;
			outA <= inA;
			outB <= inB;
			outC <= inC;
	end process;

end Behavioral;

