-- VHDL file
--
-- Autor: Jassan, Joel
-- Date: (mmm/YYYY)
-- 
-- Proyect Explanation: implementacion de la union entre one_hot, antirrebote y
-- decodificador_matriz_ascii. Necesita solo los datos de entrada de la matriz para funcionar.
-- 
--
--
-- Copyright 2023, Joel Jassan <joeljassan@hotmail.com>
-- All rights reserved.
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity oneHot_antirrebote_deco is

    generic (
        counts_to_switch       : integer := 5; -- cuentas para switchear el one_hot
        number_of_output_ports : integer := 4; -- 4 para la matriz 4x4
        number_of_cycles       : integer := 20 -- cuentas para antirrebote
    );

    port (
        --input ports
        clk   : in std_logic;
        reset : in std_logic;

        matrix_in_ports : in std_logic_vector(number_of_output_ports - 1 downto 0);

        --output ports
        caracter_port : out std_logic_vector (7 downto 0) --ASCII

    );

end entity;

architecture a_oneHot_antirrebote_deco of oneHot_antirrebote_deco is

    ----- Typedefs --------------------------------------------------------------------------------

    ----- Constants -------------------------------------------------------------------------------

    ----- Signals (i: entrada, o:salida, s:señal intermedia)---------------------------------------
    -- one hot
    --signal in_ports  : std_logic_vector(number_of_output_ports - 1 downto 0);
    signal one_hot_out_ports : std_logic_vector(number_of_output_ports - 1 downto 0);
    signal data              : std_logic_vector(number_of_output_ports - 1 downto 0);
    signal matrix_in_ports_s : std_logic_vector(number_of_output_ports - 1 downto 0);
    signal out_ports         : std_logic_vector(number_of_output_ports - 1 downto 0);

    -- deco
    signal matrix_out : std_logic_vector (3 downto 0);

    signal caracter_port_s : std_logic_vector (7 downto 0); --ASCII

begin
    ----- Components ------------------------------------------------------------------------------
    one_hot_cmp : entity work.one_hot
        generic map(counts_to_switch, number_of_output_ports)
        port map(clk, reset, one_hot_out_ports);

    bloque_ar_cmp : entity work.bloque_antirrebote
        generic map(counts_to_switch * number_of_cycles, number_of_output_ports)
        port map(clk, one_hot_out_ports, data, out_ports);

    deco : entity work.decodificador_matriz_ascii
        port map(clk, reset, one_hot_out_ports, matrix_out, caracter_port_s);
    ----- Codigo ----------------------------------------------------------------------------------

    -- Interconexion de componentes

    --(one_hot/bloque_antirrebote)
    matrix_in_ports_s <= matrix_in_ports;
    data              <= matrix_in_ports_s and one_hot_out_ports;

    --(bloque_antirrebote/decodificador)
    matrix_out <= out_ports;

    -- Logica Estado Siguiente

    -- Logica Salida
    caracter_port <= caracter_port_s;

end architecture;