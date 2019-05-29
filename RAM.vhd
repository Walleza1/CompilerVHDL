----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:22:59 05/27/2019 
-- Design Name: 
-- Module Name:    RAM - Behavioral 
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

entity RAM is
    Port ( CLK : in STD_LOGIC;
			  RST : in STD_LOGIC;
			  data_we : in  STD_LOGIC;
           data_a  : in  STD_LOGIC_VECTOR (15 downto 0);
           data_do : in  STD_LOGIC_VECTOR (15 downto 0);
           data_di : out STD_LOGIC_VECTOR (15 downto 0));
end RAM;

architecture Behavioral of RAM is
	type Ram is array (0 to 31) of STD_LOGIC_VECTOR (15 downto 0);
	signal s_ram : Ram := (others => (others => '0'));
begin

	process
		begin
			wait until rising_edge(CLK);
			if RST = '0' then
				s_ram <= (others => (others => '0'));
			else
				-- Write enabled
				if data_we = '1' then
					s_ram(to_integer(unsigned(data_a(4 downto 0)))) <= data_do;
				else
					data_di <= s_ram(to_integer(unsigned(data_a(4 downto 0))));
				end if;
			end if;
	end process;

end Behavioral;
