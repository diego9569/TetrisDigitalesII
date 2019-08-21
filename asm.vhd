library ieee;
use ieee.std_logic_1164.all;

entity asm is
	Port(
		Resetn, clock: in std_logic;
		Start, Colision, ColIzq, ColDer, Izquierda, Derecha	:in std_logic;
		Fin500ms, Fin2s, FullFila, fin250:	in std_logic;
		Encerar, LdDesp, En2s, Ld2s, En250, Ld250: out std_logic;
		enFig, enFx, ldFx, enFy, ldFy, Fin, EnBajar, LdBajar, limpFig : out std_logic;
		upFx, upFy, saveFig, enFil, borrarFila, Desplazar:	out std_logic;
		est : out std_logic_vector(4 downTo 0)
	);
end asm;

Architecture sol of asm is
	type estado is (S0,S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30);
	signal y: estado;
begin

--Cambio de estados
	Process(Resetn, clock)
	Begin
		if Resetn = '0' then y<= S0;
		elsif clock'event and clock = '1' then
			case y is
				when S0 => if start = '1' then y<= S1; end if;
				when S1 => if start = '0' then y<= S2; end if;
				when S2 => y<= S3;
				when S3 => y<= S4;
				when S4 => y<= S5;
				when S5 => if Colision = '1' then y<= S6; else y<= s7; end if;
				when s6 => if Fin2s = '1' then y<= s0; end if;
				when s7 => 
								if Colision = '1' then y<= s2; 
								elsif FullFila = '1' then y<= s12;
								elsif ColIzq = '1' then 
									if Derecha = '0' then
										if Fin500ms = '1' then y<= s9; end if;
									else y<= S10; end if;
								elsif ColDer = '1' then
									if Izquierda = '0' then
										if Fin500ms = '1' then y<= s9; end if;
									else y <= s11; end if;
								elsif Izquierda = '1' then y<= s11;
								elsif Derecha = '1' then y<= S10;
								elsif	Fin500ms = '1' then y<=s9; end if;
				when s8 => if fullFila = '1' then y<= s12; else y<= S2; end if;
				when s9 => y<= S13;
				when s10 => if Fin500ms = '1' then y<= S14;
								elsif Derecha = '0' then y <= s15; end if;
				when S11 => if Fin500ms = '1' then y<= s16;
								elsif Izquierda = '0' then y<= s17; end if;
				when s12 => y <= S18;
				when s13 => y<= s19; 
				when S14 => y<= s20;
				when s15 => y <= s21;
				when s16 => y <= s22;
				when s17 => y <= s23;
				when s18 => y <= s24;
				when s19 => y <= s7;
				when s20 => y <= s25;
				when s21 => y <= s26;
				when s22 => y <= s27;
				when s23 => y <= s28;
				when s24 => if fin250 = '1' then y<= s29; end if;
				when s25 => y <= s10;
				when s26 => y <= s7;
				when s27 => y<= s11;
				when s28 => y <= s7;
				when s29 => y <= s30;
				when s30 => if fin250 = '1' then y <= s7; end if;
			end case;
		end if;
	end process;

-- salidas
Process(Resetn, clock, Fin250)
begin
	Encerar <= '0'; LdDesp <='0'; En2s <= '0';
	Ld2s <= '0'; En250 <= '0'; Ld250 <= '0'; enFig <= '0'; enFx <= '0';
	ldFx <= '0'; enFy <= '0'; ldFy <= '0'; Fin <= '0'; EnBajar <= '0'; 
	LdBajar <= '0'; limpFig <= '0'; upFx <= '0'; upFy <= '0'; saveFig <= '0';
	enFil <= '0'; borrarFila <= '0'; Desplazar <= '0'; est <= "00000";
	case y is
		when s0 => encerar <= '1'; ldDesp <= '1'; enBajar<= '1'; ldBajar <= '1';
						En2s <= '1'; ld2s <= '1'; en250 <= '1'; ld250 <= '1'; est <= "00000";
		when s1 => est <= "00001";
		when s2 => enFig <= '1'; est <= "00010";
		when s3 => enFx <= '1'; enFy <= '1'; ldFx <= '1'; ldFy <= '1'; est <= "00011";
		when s4 => saveFig <= '1'; est <= "00100";
		when s5 => est <= "00101";
		when s6 => fin <= '1'; En2s <= '1'; est <= "00110";
		when s7 => Enbajar <= '1'; est <= "00111";
		when s8 => if fullFila = '0' then en250 <= '1'; ld250 <= '1'; end if; est <= "01000";
		when s9 => limpFig <= '1'; est <= "01001";
		when s10 => Enbajar <= '1'; est <= "01010";
		when s11 => EnBajar <= '1'; est <= "01011";
		when s12 => enFil <= '1'; est <= "01100";
		when s13 => enFy <= '1'; est <= "01101";
		when s14 => limpFig <= '1'; est <= "01110";
		when s15 => limpFig <= '1'; est <= "01111";
		when s16 => limpFig <= '1'; est <= "10000";
		when s17 => limpFig <= '1'; est <= "10001";
		when s18 => BorrarFila <= '1'; est <= "10010";
		when s19 => SaveFig <= '1'; enBajar <= '1'; ldBajar <= '1'; est <= "10011";
		when s20 => enFy <= '1'; est <= "10100";
		when s21 => enFx <= '1'; upFx <= '1'; est <= "10101";
		when s22 => enFy <= '1'; est <= "10110";
		when s23 => enFx <= '1'; est <= "10111";
		when s24 => en250 <= '1'; limpFig <= '1'; est <= "11000";
		when s25 => SaveFig <= '1'; enBajar <= '1'; ldBajar <= '1'; est <= "11001";
		when s26 => saveFig <= '1'; est <= "11010";
		when s27 => SaveFig <= '1'; enBajar <= '1'; LdBajar <= '1'; est <= "11011";
		when s28 => SaveFig <= '1'; est <= "11100";
		when s29 => Desplazar <= '1'; en250 <= '1'; ld250 <= '1'; est <= "11101";
		when s30 => en250 <= '1'; SaveFig <= '1'; if fin250 = '1' then en250 <= '1'; ld250 <= '1'; end if; est <= "11110";
	end case;
end process;
				
end sol;