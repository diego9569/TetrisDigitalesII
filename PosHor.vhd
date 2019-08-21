library ieee;
use ieee.std_logic_1164.all;

entity PosHor is
	Port(
	X0, x1, x2, x3: out std_logic_vector(2 downto 0);
	y0, y1, y2, y3: out std_logic_vector(3 downto 0)
	);
end PosHor;

Architecture sol of PosHor is
Begin
	x0 <= "101";
	x1 <= "100";
	x2 <=	"011";
	x3 <= "010";
	y0 <= "1111";
	y1 <= "1111";
	y2 <= "1111";
	y3 <= "1111";
end sol;