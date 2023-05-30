-- VHDL file
--
-- Autor: Jassan, Joel
-- Date: (may/2023)
-- 
-- Proyect Explanation: implementacion del modulo de union entre one_hot y antirrebote.
-- El codigo este se desarrolla despues de probar en testbench, y se genera para probarlo en la
-- FPGA.
-- El one_hot funciona como reloj del antirrebote. "antirrebote" se actualiza "number_of_cycles"
-- veces, antes de releer el estado.
--
--
-- Copyright 2023, Joel Jassan <joeljassan@hotmail.com>
-- All rights reserved.
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity oneHot_antirrebote is

    generic (
        counts_to_switch       : integer := 4; -- cuentas para switchear el one_hot
        number_of_output_ports : integer := 4; -- 4 para la matriz 4x4
        number_of_cycles       : integer := 20 -- cuentas para antirrebote
    );

    port (
        --input ports
        clk   : in std_logic;
        reset : in std_logic;

        in_ports : in std_logic_vector(number_of_output_ports - 1 downto 0);
        --output ports
        out_ports : out std_logic_vector(number_of_output_ports - 1 downto 0)

    );

end entity;

architecture a_oneHot_antirrebote of oneHot_antirrebote is

    ----- Typedefs --------------------------------------------------------------------------------

    ----- Constants -------------------------------------------------------------------------------

    ----- Signals (i: entrada, o:salida, s:señal intermedia)---------------------------------------
    signal one_hot_out_ports : std_logic_vector(number_of_output_ports - 1 downto 0);
    signal data              : std_logic_vector(number_of_output_ports - 1 downto 0);
    signal in_ports_s        : std_logic_vector(number_of_output_ports - 1 downto 0);

begin
    ----- Components ------------------------------------------------------------------------------
    one_hot_cmp : entity work.one_hot
        generic map(counts_to_switch, number_of_output_ports)
        port map(clk, reset, one_hot_out_ports);

    bloque_ar_cmp : entity work.bloque_antirrebote
        generic map(counts_to_switch * number_of_cycles, number_of_output_ports)
        port map(clk, one_hot_out_ports, data, out_ports);

    ----- Codigo ----------------------------------------------------------------------------------

    -- Logica Estado Siguiente
    --AQUI HAGO PRUEBAS HASTA ENCONTRAR LA SOLUCION

    in_ports_s <= in_ports;
    data       <= in_ports_s and one_hot_out_ports;

end architecture;