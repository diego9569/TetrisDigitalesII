library ieee;
use ieee.std_logic_1164.all;

Entity Conv_Decimal_Binario is
	Port(
	Ent : in std_logic_vector(15 downTo 0);
	BCD : out std_logic_vector(3 downTo 0));
end Conv_Decimal_Binario;

Architecture sol of Conv_Decimal_Binario is

Begin
	with Ent select
	BCD <="0000" when "0111111111111111", 
			"0001" when "1011111111111111",
			"0010" when "1101111111111111",
			"0011" when "1110111111111111",
			"0100" when "1111011111111111",
			"0101" when "1111101111111111",
			"0110" when "1111110111111111",
			"0111" when "1111111011111111",
			"1000" when "1111111101111111",
			"1001" when "1111111110111111",
			"1010" when "1111111111011111",
			"1011" when "1111111111101111",
			"1100" when "1111111111110111",
			"1101" when "1111111111111011",
			"1110" when "1111111111111101",
			"1111" when others;
end sol;