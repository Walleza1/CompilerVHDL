----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:06:02 04/18/2019 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           OP : in  STD_LOGIC_VECTOR (7 downto 0);
           S : out  STD_LOGIC_VECTOR (15 downto 0);
           FLAG : out  STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is
	signal S_add  : STD_LOGIC_VECTOR(16 downto 0) := (others => '0');
	signal S_sub  : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal S_eq   : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal S_inf  : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal S_mul  : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal C : STD_LOGIC := '0';
	signal N : STD_LOGIC := '0';
	signal Z : STD_LOGIC := '0';
	signal V : STD_LOGIC := '0';
	
begin
	S_add <= ("0" & A)+("0" & B);
	S_sub <= A-B;
	S_mul <= A*B;
	
	
	S_eq 	<= X"0001" when OP = X"09" and A = B else X"0000";
	S_inf <= X"0001" when OP = X"0A" and A < B else X"0000";
	
	
	S <=	S_add(15 downto 0) when OP = X"01" else
			S_sub(15 downto 0) when OP = X"03" else
			S_mul(15 downto 0) when OP = X"02" else
			S_eq					 when OP = X"09" else
			S_inf					 when OP = X"0A";

	
	-- Flag is [CNZV]
	-- C : carry
	-- N : negative
	-- Z : zero
	-- V : overflow
	C <=  S_add(16) when OP = X"01" ;
	
	N <= S_add(15) when OP = X"01";
	
	Z <=  '1' when OP = X"01" and S_add(15 downto 0) = X"00" else
			'1' when OP = X"02" and S_sub(15 downto 0) = X"00" else
			'1' when OP = X"02" and S_mul(15 downto 0) = X"00";
	
	V <= 	'1' when OP = X"01" and ( ( S_add(15) = '0' and A(15) = '1' and B(15) = '1') or (S_add(15) = '1' and A(15) = '0' and B(15) = '0')) else
			'1' when OP = X"03" and ( ( S_add(15) = '0' and A(15) = '1' and B(15) = '0') or (S_add(15) = '1' and A(15) = '0' and B(15) = '1')) else
			'1' when OP = X"02" and ( S_mul(31 downto 16) = X"00");
	
	-- Reverse it because first is [V] then [Z,V]
	FLAG <= V & Z & N & C;
	
end Behavioral;

