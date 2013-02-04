----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:18:48 02/04/2013 
-- Design Name: 
-- Module Name:    voter - Behavioral 
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

entity voter is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c : in  STD_LOGIC;
           d : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           y : out  STD_LOGIC;
           status : out  STD_LOGIC_VECTOR (2 downto 0)
);
end voter;

architecture Behavioral of voter is

signal working : std_logic_vector(3 downto 0);

begin

vote : process(clk, a, b , c, d)
begin
if rising_edge(clk) then
		if ( ((a and b) or (a and c) or (a and d) or (b and c) or (b and d) or (c and d)) = '1' ) then
			y <= '1';
			working <= (
			0 => working(0) and ((a and b) or (a and c) or (a and d)),
			1 => working(1) and ((b and a) or (b and c) or (b and d)), 
			2 => working(2) and ((c and a) or (c and b) or (c and d)),
			3 => working(3) and ((d and a) or (d and b) or (d and c))); 
		else
			y <= '0';
			working <= (
			0 => working(0) and (not ((a and b) or (a and c) or (a and d))),
			1 => working(1) and (not ((b and a) or (b and c) or (b and d))), 
			2 => working(2) and (not ((c and a) or (c and b) or (c and d))),
			3 => working(3) and (not ((d and a) or (d and b) or (d and c)))); 
		end if;
	end if;
end process;

calc_status : process(working, clk, reset)
begin
	if rising_edge(clk) then
		if (reset = '1') then
				status <= "000";
		else
			case working is
				when "0000" => status <= "111";
				when "0001" => status <= "111";
				when "0010" => status <= "111";
				when "0011" => status <= "111";
				when "0100" => status <= "111";
				when "0101" => status <= "010";
				when "0110" => status <= "010";
				when "0111" => status <= "001";	
				when "1000" => status <= "111";
				when "1001" => status <= "010";
				when "1010" => status <= "010";
				when "1011" => status <= "001";
				when "1100" => status <= "010";
				when "1101" => status <= "001";
				when "1110" => status <= "001";
				when "1111" => status <= "000";
				when others => status <= "111";
			end case;
		end if;
	end if;
end process;

end Behavioral;

