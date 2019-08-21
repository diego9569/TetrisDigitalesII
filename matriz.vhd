library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity matriz is
	port(
		Resetn, clock:	in std_logic;
		address	: in std_logic_vector(3 downTo 0);
		fila			: in std_logic_vector(3 downTo 0);
		Encerar:	in std_logic;
		Desplazar:	in std_logic;
		borrarfila:	in std_logic;
		saveFig:	in std_logic;
		limpFig:	in std_logic;
		nFy0, nFy1, nFy2, nFy3:	in std_logic_vector(3 downTo 0);
		nFx0, nFx1, nFx2, nFx3:	in std_logic_vector(2 downTo 0);
		Colision, ColIzq, ColDer: out std_logic;
		Q:	out std_logic_vector(7 downTo 0)
	);
	
end matriz;

architecture sol of matriz is
	type Matriz is array(15 downTo 0) of std_logic_vector(7 downTo 0);
	signal pant:	Matriz;
	signal f, Fy0, Fy1, Fy2, Fy3, add:	integer range 0 to 15;
	signal Fy0sig, Fy1sig, Fy2sig, Fy3sig:	integer range 0 to 15;
	signal Fx0, Fx1, Fx2, Fx3:	integer range 0 to 7;
	signal ColLastFila, colP0, colP1, colP2, colP3: std_logic;
	signal colP0Izq, colP1Izq, colP2Izq, colP3Izq, colBordeDer: std_logic;
	signal colP0Der, colP1Der, colP2Der, colP3Der, colBordeIzq: std_logic;
	signal Fx0sigIzq, Fx1sigIzq, Fx2sigIzq, Fx3sigIzq:	integer range 0 to 7;
	signal Fx0sigDer, Fx1sigDer, Fx2sigDer, Fx3sigDer:	integer range 0 to 7;
begin

-- Cambios a la matriz
	Process(Resetn, clock)
	begin
		if Resetn = '0' or encerar = '1' then
			pant(15) <= "00000000"; pant(14) <= "00000000"; pant(13) <= "00000000";
			pant(12) <= "00000000"; pant(11) <= "00000000"; pant(10) <= "00000000";
			pant(9) <= "00000000"; pant(8) <= "00000000"; pant(7) <= "00000000";
			pant(6) <= "00000000"; pant(5) <= "00000000"; pant(4) <= "00000000";
			pant(3) <= "00000000"; pant(2) <= "00000000"; pant(1) <= "00000000";
			pant(0) <= "00000000";
		elsif(clock'event and clock = '1') then
			if borrarFila = '1' then
				pant(add-1) <= "00000000";
			elsif saveFig = '1' then
				pant(Fy0)(Fx0) <= '1';
				pant(Fy1)(Fx1) <= '1';
				pant(Fy2)(Fx2) <= '1';
				pant(Fy3)(Fx3) <= '1';
			elsif limpFig = '1' then
				pant(Fy0)(Fx0) <= '0';
				pant(Fy1)(Fx1) <= '0';
				pant(Fy2)(Fx2) <= '0';
				pant(Fy3)(Fx3) <= '0';
			elsif desplazar = '1' then
				for I in 0 to 14 loop
					if (I >= add-1) then
						pant(I) <= pant(I+1);
					end if;
				end loop;
			end if;
		end if;
	end process;

--muestra de la matriz
	Q <= pant(f);

--Colisiones (Son asincronicas)
	ColIzq <= colBordeIzq or colP0Izq or colP1Izq or colP2Izq or colP3Izq;
	ColDer <= colBordeDer or colP0Der or colP1Der or colP2Der or colP3Der;
	colBordeIzq <= '1' when ((Fx0 = 7) or (Fx1 = 7) or (Fx2 = 7) or (Fx3 = 7)) else '0';
	colBordeDer <= '1' when ((Fx0 = 0) or (Fx1 = 0) or (Fx2 = 0) or (Fx3 = 0)) else '0';
	ColLastFila <= '1' when (Fy0 = 0 or Fy1 = 0 or Fy2 = 0 or Fy3 = 0) else '0';
	colision <= colP0 or colP1 or colP2 or colP3 or colLastFila;
	colP0 <= '0' when (Fy0sig = Fy1 or (Fy0sig = Fy2) or (Fy0sig = Fy3)) else pant(Fy0sig)(Fx0);
	colP1 <= '0' when (Fy1sig = Fy0 or (Fy1sig = Fy2) or (Fy1sig = Fy3)) else pant(Fy1sig)(Fx1);
	colP2 <= '0' when (Fy2sig = Fy0 or (Fy2sig = Fy1) or (Fy2sig = Fy3)) else pant(Fy2sig)(Fx2);
	colP3 <= '0' when (Fy3sig = Fy0 or (Fy3sig = Fy1) or (Fy3sig = Fy2)) else pant(Fy3sig)(Fx3);
	
	colP0Der <= '0' when (Fx0sigDer = Fx1 or Fx0sigDer = Fx2 or Fx0sigDer = Fx3) else pant(Fy0)(Fx0sigDer);
	colP1Der <=	'0' when (Fx1sigDer = Fx0 or Fx1sigDer = Fx2 or Fx1sigDer = Fx3) else pant(Fy1)(Fx1sigDer);
	colP2Der <= '0' when (Fx2sigDer = Fx0 or Fx2sigDer = Fx1 or Fx2sigDer = Fx3) else pant(Fy2)(Fx2sigDer);
	colP3Der <=	'0' when (Fx3sigDer = Fx0 or Fx3sigDer = Fx1 or Fx3sigDer = Fx2) else pant(Fy3)(Fx3sigDer);
	
	colP0Izq <= '0' when (Fx0sigIzq = Fx1 or Fx0sigIzq = Fx2 or Fx0sigIzq = Fx3) else pant(Fy0)(Fx0sigIzq);
	colP1Izq <=	'0' when (Fx1sigIzq = Fx0 or Fx1sigIzq = Fx2 or Fx1sigIzq = Fx3) else pant(Fy1)(Fx1sigIzq);
	colP2Izq <=	'0' when (Fx2sigIzq = Fx0 or Fx2sigIzq = Fx1 or Fx2sigIzq = Fx3) else pant(Fy2)(Fx2sigIzq);
	colP3Izq <=	'0' when (Fx3sigIzq = Fx0 or Fx3sigIzq = Fx1 or Fx3sigIzq = Fx2) else pant(Fy3)(Fx3sigIzq);
	
	Fx0sigIzq <= Fx0 + 1;
	Fx1sigIzq <= Fx1 + 1;
	Fx2sigIzq <= Fx2 + 1;
	Fx3sigIzq <= Fx3 + 1;
	
	Fx0sigDer <= Fx0 - 1;
	Fx1sigDer <= Fx1 - 1;
	Fx2sigDer <= Fx2 - 1;
	Fx3sigDer <= Fx3 - 1;
	
	Fy0sig <= Fy0-1;
	Fy1sig <= Fy1-1;
	Fy2sig <= Fy2-1;
	Fy3sig <= Fy3-1;
	
--conversion de bits a integers para manejo de arreglos

	with fila select
		f <= 0 when "0000",
				1 when "0001",
				2 when "0010",
				3 when "0011",
				4 when "0100",
				5 when "0101",
				6 when "0110",
				7 when "0111",
				8 when "1000",
				9 when "1001",
				10 when "1010",
				11 when "1011",
				12 when "1100",
				13 when "1101",
				14 when "1110",
				15 when "1111";

	with address select
		add <= 0 when "0000",
				1 when "0001",
				2 when "0010",
				3 when "0011",
				4 when "0100",
				5 when "0101",
				6 when "0110",
				7 when "0111",
				8 when "1000",
				9 when "1001",
				10 when "1010",
				11 when "1011",
				12 when "1100",
				13 when "1101",
				14 when "1110",
				15 when "1111";
	
	with nFy0 select
		Fy0 <= 0 when "0000",
				1 when "0001",
				2 when "0010",
				3 when "0011",
				4 when "0100",
				5 when "0101",
				6 when "0110",
				7 when "0111",
				8 when "1000",
				9 when "1001",
				10 when "1010",
				11 when "1011",
				12 when "1100",
				13 when "1101",
				14 when "1110",
				15 when "1111";

	with nFy1 select
		Fy1 <= 0 when "0000",
				1 when "0001",
				2 when "0010",
				3 when "0011",
				4 when "0100",
				5 when "0101",
				6 when "0110",
				7 when "0111",
				8 when "1000",
				9 when "1001",
				10 when "1010",
				11 when "1011",
				12 when "1100",
				13 when "1101",
				14 when "1110",
				15 when "1111";

	with nFy2 select
		Fy2 <= 0 when "0000",
				1 when "0001",
				2 when "0010",
				3 when "0011",
				4 when "0100",
				5 when "0101",
				6 when "0110",
				7 when "0111",
				8 when "1000",
				9 when "1001",
				10 when "1010",
				11 when "1011",
				12 when "1100",
				13 when "1101",
				14 when "1110",
				15 when "1111";
	
	with nFy3 select
		Fy3 <= 0 when "0000",
				1 when "0001",
				2 when "0010",
				3 when "0011",
				4 when "0100",
				5 when "0101",
				6 when "0110",
				7 when "0111",
				8 when "1000",
				9 when "1001",
				10 when "1010",
				11 when "1011",
				12 when "1100",
				13 when "1101",
				14 when "1110",
				15 when "1111";
				
	with nFx0 select
		Fx0 <= 0 when "000",
				1 when "001",
				2 when "010",
				3 when "011",
				4 when "100",
				5 when "101",
				6 when "110",
				7 when "111";

	with nFx1 select
		Fx1 <= 0 when "000",
				1 when "001",
				2 when "010",
				3 when "011",
				4 when "100",
				5 when "101",
				6 when "110",
				7 when "111";
	
	with nFx2 select
		Fx2 <= 0 when "000",
				1 when "001",
				2 when "010",
				3 when "011",
				4 when "100",
				5 when "101",
				6 when "110",
				7 when "111";
			
	with nFx3 select
		Fx3 <= 0 when "000",
				1 when "001",
				2 when "010",
				3 when "011",
				4 when "100",
				5 when "101",
				6 when "110",
				7 when "111";	
end sol;
