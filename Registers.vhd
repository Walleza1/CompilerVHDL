----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:06:20 05/07/2019 
-- Design Name: 
-- Module Name:    Registers - Behavioral 
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

entity Registers is
    Port ( RST : in  STD_LOGIC;
           addrA : in  STD_LOGIC_VECTOR (7 downto 0);
           addrB : in  STD_LOGIC_VECTOR (7 downto 0);
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0);
           W : in  STD_LOGIC;
           addrW : in  STD_LOGIC_VECTOR (7 downto 0);
           DATA : in  STD_LOGIC_VECTOR (7 downto 0));
end Registers;

architecture Behavioral of Registers is
	type REGISTERS is array (0 to 7) of STD_LOGIC_VECTOR (15 downto 0);
	signal regs : REGISTERS := (others => (others => '0'));
begin


end Behavioral;

