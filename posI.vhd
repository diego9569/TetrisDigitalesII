library ieee;
use ieee.std_logic_1164.all;

entity PosI is
	Port(
	X0, x1, x2, x3: out std_logic_vector(2 downto 0);
	y0, y1, y2, y3: out std_logic_vector(3 downto 0)
	);
end PosI;

Architecture sol of PosI is
Begin
	x0 <= "100";
	x1 <= "100";
	x2 <=	"100";
	x3 <= "100";
	y0 <= "1111";
	y1 <= "1110";
	y2 <= "1101";
	y3 <= "1100";
end sol;