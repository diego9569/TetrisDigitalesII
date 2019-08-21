library ieee;
use ieee.std_logic_1164.all;

entity regDespIzqDer is
	generic(n: integer:=4);
	Port(
		DataIn : in std_logic_vector( n-1 downTo 0);
		En : in std_logic;
		Ld : in std_logic;
		clock : in std_logic;
		resetn : in std_logic;
		DataOut : buffer std_logic_vector(n-1 downTo 0)
	);
end regDespIzqDer;

architecture sol of regDespIzqDer is
	signal ctemp : std_logic;
Begin
	ctemp <= DataOut(0);
	Process(Resetn, clock)
	Begin
		if Resetn = '0' then DataOut <= (Others => '0');
		elsif clock'event and clock = '1' then
			if En='1' then
				if Ld = '1' then DataOut <= DataIn;
				else 	DataOut(n-2 downTo 0) <= DataOut(n-1 downTo 1);
						DataOut(n-1) <= ctemp;
				end if;
			end if;
		end if;	
	end process;	
end sol;