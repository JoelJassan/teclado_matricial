-- VHDL file
--
-- Autor: Jassan, Joel
-- Date: (may/2023)
-- 
-- Proyect Explanation: implementacion de un bloque de antirrebote, con soporte para multiples
-- entradas. La cantidad de entradas se asigna en "number_of_ports" y el tiempo de retardo en 
-- "delay_count".
--
--
-- Copyright 2023, Joel Jassan <joeljassan@hotmail.com>
-- All rights reserved.
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity bloque_antirrebote is

    generic (
        delay_count     : integer := 100;
        number_of_ports : integer := 4
    );

    port (
        --input ports
        clk          : in std_logic;
        enable_ports : in std_logic_vector (number_of_ports - 1 downto 0);

        in_ports : in std_logic_vector (number_of_ports - 1 downto 0);
        --output ports
        out_ports : out std_logic_vector (number_of_ports - 1 downto 0)
    );

end entity;

architecture a_bloque_antirrebote of bloque_antirrebote is

    ----- Typedefs --------------------------------------------------------------------------------

    ----- Constants -------------------------------------------------------------------------------

    ----- Signals (i: entrada, o:salida, s:señal intermedia)---------------------------------------
    signal in_ports_s     : std_logic_vector (number_of_ports - 1 downto 0);
    signal out_ports_s    : std_logic_vector (number_of_ports - 1 downto 0);
    signal enable_ports_s : std_logic_vector (number_of_ports - 1 downto 0);

begin
    ----- Components ------------------------------------------------------------------------------

    gen_components : for i in (number_of_ports - 1) downto 0 generate
        modulo_antirrebote : entity work.antirrebote
            generic map(delay_count)
            port map(clk, enable_ports_s(i), in_ports_s(i), out_ports_s(i));
    end generate;

    ----- Codigo ----------------------------------------------------------------------------------

    -- Logica Estado Siguiente

    -- Logica Salida
    enable_ports_s <= enable_ports;
    in_ports_s     <= in_ports;
    out_ports      <= out_ports_s;

end architecture;