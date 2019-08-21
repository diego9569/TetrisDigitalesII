library ieee;
use ieee.std_logic_1164.all;

Entity RegSost is
	Generic(n: integer:=4);
	Port(Resetn, clock: in std_logic;
			En: in std_logic;
			Ent: in std_logic_vector(n-1 downTo 0);
			Q: out std_logic_vector(n-1 downTo 0));
end RegSost;

Architecture sol of RegSost is

Begin
	Process(Resetn, clock)
	Begin
	if Resetn = '0' then Q <= (Others => '0');
	Elsif clock'event and clock='1' then
		if En = '1' then
			Q<= Ent;
		end if;
	end if;
	end Process;
end sol;