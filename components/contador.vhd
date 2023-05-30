-- VHDL file
--
-- Autor: Jassan, Joel
-- Date: (may/2023)
-- 
-- Proyect Explanation: contador binario que muestra un pulso en la salida cuando termina la cuenta
--
--
-- Copyright 2023, Joel Jassan <joeljassan@hotmail.com>
-- All rights reserved.
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador is

	generic (
		nbits   : integer := 25;
		cnt_max : integer := 50000000
	);

	port (
		--input ports
		clk   : in std_logic;
		reset : in std_logic;

		--output ports
		clk_out_port : out std_logic;
		q            : out std_logic_vector (nbits - 1 downto 0)
	);

end entity;

architecture contador_a of contador is

	----- Typedefs --------------------------------------------------------------------------------

	----- Constants -------------------------------------------------------------------------------

	----- Signals (i: entrada, o:salida, s:señal intermedia)---------------------------------------
	signal clk_out_s : std_logic;
	signal q_s       : std_logic_vector(nbits - 1 downto 0);

begin

	process (clk, reset)
		variable cnt : integer range 0 to cnt_max;
	begin

		if reset = '0' then
			cnt := 0;
		elsif (rising_edge(clk)) then

			if (cnt < cnt_max) then
				cnt := cnt + 1;
				clk_out_s <= '0';
			else
				cnt := 0;
				clk_out_s <= '1';
			end if;

		end if;

		q_s <= std_logic_vector(to_unsigned(cnt, q_s'length));

	end process;

	-- Logica de Salida
	q            <= q_s;
	clk_out_port <= clk_out_s;

end contador_a;