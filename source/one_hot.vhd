-- VHDL file
--
-- Autor: Jassan, Joel
-- Date: (may/2023)
-- 
-- Proyect Explanation: Implementacion de un sistema con salida one_hot, con parametros genericos.
-- Se puede ajustar cada cuant os pulsos de reloj (de 50MHz) se actualiza la salida.
--
--
-- Copyright 2023, Joel Jassan <joeljassan@hotmail.com>
-- All rights reserved.
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity one_hot is

    generic (
        counts_to_switch       : integer := 10;
        number_of_output_ports : integer := 4
    );

    port (
        --input ports
        clk   : in std_logic;
        reset : in std_logic;

        --output ports
        one_hot_output_ports : out std_logic_vector (number_of_output_ports - 1 downto 0)
    );

end entity;

architecture a_one_hot of one_hot is

    ----- Typedefs --------------------------------------------------------------------------------

    ----- Constants -------------------------------------------------------------------------------
    constant one_hot_max : integer := number_of_output_ports - 1;
    ----- Signals (i: entrada, o:salida, s:señal intermedia)---------------------------------------

    -- contador
    signal switch : std_logic;

    --one_hot
    signal one_hot_output_ports_s : std_logic_vector(number_of_output_ports - 1 downto 0);

begin
    ----- Components ------------------------------------------------------------------------------
    cambio : entity work.contador
        generic map(counts_to_switch)
        port map(clk, reset, switch);
    ----- Codigo ----------------------------------------------------------------------------------

    -- Logica Estado Siguiente
    process (clk, reset)
        variable one_hot_bit_on : integer := 0;
    begin
        if (reset = '0') then
            one_hot_bit_on := - 1; -- para que inicie en el LSB la cuenta
            one_hot_output_ports_s <= (others => '0');

        elsif (rising_edge(clk)) then

            -- +1 si llega un pulso
            if (switch = '1') then

                if (one_hot_max /= one_hot_bit_on) then
                    one_hot_bit_on := one_hot_bit_on + 1;
                else
                    one_hot_bit_on := 0;
                end if;

                one_hot_output_ports_s <= std_logic_vector(to_unsigned((2 ** one_hot_bit_on), one_hot_output_ports_s'length));

            end if;
        end if;
    end process;

    -- Logica Salida
    one_hot_output_ports <= one_hot_output_ports_s;

end architecture;