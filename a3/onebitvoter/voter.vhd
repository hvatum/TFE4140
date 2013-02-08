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
use work.custom_func.all;

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
signal prev_working : std_logic_vector(3 downto 0);
signal internal_voted : std_logic;

component selector is
	Generic (N: Natural := 4);
    Port ( mcu : in  STD_LOGIC_VECTOR(N-1 downto 0);
			  active : in  STD_LOGIC_VECTOR(N-1 downto 0);
           y : out  STD_LOGIC
);
end component;

begin

sel: component selector
	port map (
		mcu(0)=> a,
		mcu(1)=> b,
		mcu(2)=> c,
		mcu(3)=> d,
		active=> working,
		y=> internal_voted
	);



vote : process(clk, internal_voted)
begin
	if rising_edge(clk) then
	if reset = '1' then
			working <= (others => '0');
			y <= '0';
	else
		y <= internal_voted;
		working(0) <= bool_to_stdlogic((prev_working(0) = '1' and (a = internal_voted)));
		working(1) <= bool_to_stdlogic((prev_working(1) = '1' and (b = internal_voted)));
		working(2) <= bool_to_stdlogic((prev_working(2) = '1' and (c = internal_voted)));
		working(3) <= bool_to_stdlogic((prev_working(3) = '1' and (d = internal_voted)));
	end if;
	end if;
end process;

calc_status : process(working, clk, reset)
begin
	if rising_edge(clk) then
		if (reset = '1') then
			status <= "000";
			prev_working <= (others => '0');
		else
			prev_working <= working;
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

