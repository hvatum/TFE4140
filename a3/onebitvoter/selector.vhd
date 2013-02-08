----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:21:47 02/08/2013 
-- Design Name: 
-- Module Name:    selector - Behavioral 
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

entity selector is
    Port ( mcu : in  STD_LOGIC_VECTOR(3 downto 0);
			  active : in  STD_LOGIC_VECTOR(3 downto 0);
           y : out  STD_LOGIC
);

end selector;

architecture Behavioral of selector is

signal active_high : std_logic_vector(3 downto 0);
signal active_low : std_logic_vector(3 downto 0);

signal cnt_high : integer;
signal cnt_low : integer;

begin

		active_high <= active and mcu;
		active_low <= active and not mcu;
		y <= bool_to_stdlogic(cnt_high > cnt_low);

process(active_high, active_low) is
begin
		case active_high is
				when "0000" => cnt_high <= 0;
				when "0001" => cnt_high <= 1;
				when "0010" => cnt_high <= 1;
				when "0011" => cnt_high <= 1;
				when "0100" => cnt_high <= 1;
				when "0101" => cnt_high <= 1;
				when "0110" => cnt_high <= 2;
				when "0111" => cnt_high <= 3;	
				when "1000" => cnt_high <= 1;
				when "1001" => cnt_high <= 2;
				when "1010" => cnt_high <= 2;
				when "1011" => cnt_high <= 3;
				when "1100" => cnt_high <= 2;
				when "1101" => cnt_high <= 3;
				when "1110" => cnt_high <= 3;
				when "1111" => cnt_high <= 4;
				when others => cnt_high <= 0;
		end case;
		case active_low is
				when "0000" => cnt_low <= 0;
				when "0001" => cnt_low <= 1;
				when "0010" => cnt_low <= 1;
				when "0011" => cnt_low <= 1;
				when "0100" => cnt_low <= 1;
				when "0101" => cnt_low <= 1;
				when "0110" => cnt_low <= 2;
				when "0111" => cnt_low <= 3;	
				when "1000" => cnt_low <= 1;
				when "1001" => cnt_low <= 2;
				when "1010" => cnt_low <= 2;
				when "1011" => cnt_low <= 3;
				when "1100" => cnt_low <= 2;
				when "1101" => cnt_low <= 3;
				when "1110" => cnt_low <= 3;
				when "1111" => cnt_low <= 4;
				when others => cnt_low <= 0;
		end case;
end process;

end Behavioral;