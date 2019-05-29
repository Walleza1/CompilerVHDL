----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:36:57 05/27/2019 
-- Design Name: 
-- Module Name:    Computer - Behavioral 
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

entity Computer is
    Port ( reset : in  STD_LOGIC);
end Computer;

architecture Behavioral of Computer is
	component Processor
    port (
			CLK    : in STD_LOGIC;
			reset  : in STD_LOGIC;
			data_do: out STD_LOGIC_VECTOR (15 downto 0);
			data_a : out STD_LOGIC_VECTOR (15 downto 0);
			data_we: out STD_LOGIC;
			data_di: in  STD_LOGIC_VECTOR (15 downto 0) := (others => '0')
		);
	end component;

	component RAM
     Port (
			CLK    : in  STD_LOGIC := '0';
			RST    : in  STD_LOGIC := '0';
			data_we: in  STD_LOGIC := '0';
         data_a : in  STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
         data_do: in  STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
         data_di: out STD_LOGIC_VECTOR (15 downto 0) := (others => '0')
		);
	end component;

	signal CLK, s_data_we:                 STD_LOGIC := '0';
	signal s_data_a, s_data_do, s_data_di: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

	constant CLK_period: time := 10 ns;
	
begin
	c_ram: RAM PORT MAP (
		CLK     => CLK,
		RST     => reset,
		data_we => s_data_we,
      data_a  => s_data_a,
      data_do => s_data_do,
      data_di => s_data_di
	);
	
	d_processor: Processor PORT MAP (
		CLK     => CLK,
		reset   => reset,
		data_do => s_data_do,
		data_a  => s_data_a,
		data_we => s_data_we,
		data_di => s_data_di
	);
	
	CLK_process: process
	begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
	end process;

end Behavioral;
