library ieee;
use ieee.std_logic_1164.all;

entity Mux4a1 is
	generic(n: integer:=4);
	port( sel  : in std_logic_vector(1 downTo 0);
			ent0, ent1, ent2, ent3 : in std_logic_vector(n-1 downTo 0);
			s : out std_logic_vector(n-1 downTo 0));
end Mux4a1;

Architecture sol of Mux4a1 is

Begin
	with sel select
		s <= ent0 when "00",
				ent1 when "01",
				ent2 when "10",
				ent3 when others;
end sol;