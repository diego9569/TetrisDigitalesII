library ieee;
use ieee.std_logic_1164.all;

entity PosL is
	Port(
	X0, x1, x2, x3: out std_logic_vector(2 downto 0);
	y0, y1, y2, y3: out std_logic_vector(3 downto 0)
	);
end PosL;

Architecture sol of PosL is
Begin
	x0 <= "100";
	x1 <= "100";
	x2 <=	"011";
	x3 <= "010";
	y0 <= "1111";
	y1 <= "1110";
	y2 <= "1110";
	y3 <= "1110";
end sol;