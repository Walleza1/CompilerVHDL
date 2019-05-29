----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:14:17 05/07/2019 
-- Design Name: 
-- Module Name:    RegistersFile - Behavioral 
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

entity RegistersFile is
	Port ( RST : in  STD_LOGIC;
			  CLK : in STD_LOGIC;
           addrA : in  STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           addrB : in  STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0);
           W : in  STD_LOGIC;
           addrW : in  STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
           DATA : in  STD_LOGIC_VECTOR (7 downto 0));
end RegistersFile;

architecture Behavioral of RegistersFile is
	type Registers is array (0 to 15) of STD_LOGIC_VECTOR (7	downto 0);
	signal regs : Registers := (others => (others => '0'));
begin
	
	process
		begin
			wait until rising_edge(CLK);
			if RST = '0' then
				regs <= (others => (others => '0'));
			else
				if W = '1' then
					regs(to_integer(unsigned(addrW))) <= DATA ;
				end if;
			end if;
	end process;
 
	QA <= regs(to_integer(unsigned(addrA))) when addrW /= addrA else
			DATA;
	QB <= regs(to_integer(unsigned(addrB))) when addrW /= addrB else
			DATA;

end Behavioral;

