-- VHDL file
--
-- Autor: Jassan, Joel
-- Date: (may/2023)
-- 
-- Proyect Explanation: implementacion de un decodificador de entradas y salidas de una matriz 4x4.
-- Este bloque toma las salidas del bloque one_hot y las salidas de la matriz 4x4. 
-- Para no ejecutar constantemente, el bloque toma las señales estabilizadas de la matriz.
-- 
--
-- Copyright 2023, Joel Jassan <joeljassan@hotmail.com>
-- All rights reserved.
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity decodificador_matriz_ascii is

    port (
        --input ports
        clk    : in std_logic;
        reset  : in std_logic;
        enable : in std_logic;

        one_hot_in : in std_logic_vector (3 downto 0);
        matriz_out : in std_logic_vector (3 downto 0);
        --output ports
        caracter_port : out std_logic_vector (7 downto 0) --ASCII
    );

end entity;

architecture a_decodificador_matriz_ascii of decodificador_matriz_ascii is

    ----- Typedefs --------------------------------------------------------------------------------

    ----- Constants -------------------------------------------------------------------------------

    ----- Signals (i: entrada, o:salida, s:señal intermedia)---------------------------------------
    signal caracter : character; --'A'
begin
    ----- Components ------------------------------------------------------------------------------

    ----- Codigo ----------------------------------------------------------------------------------

    -- Logica Estado Siguiente

    -- Logica Salida
    process (matriz_out)
    begin
        case (one_hot_in & matriz_out) is
            when "00010001" => caracter <= '1';
            when "00010010" => caracter <= '2';
            when "00010100" => caracter <= '3';
            when "00011000" => caracter <= 'A';
                --
            when "00100001" => caracter <= '4';
            when "00100010" => caracter <= '5';
            when "00100100" => caracter <= '6';
            when "00101000" => caracter <= 'B';
                --
            when "01000001" => caracter <= '7';
            when "01000010" => caracter <= '8';
            when "01000100" => caracter <= '9';
            when "01001000" => caracter <= 'C';
                --
            when "10000001" => caracter <= '*';
            when "10000010" => caracter <= '2';
            when "10000100" => caracter <= '#';
            when "10001000" => caracter <= 'D';

            when others => caracter <= '-';
        end case;
    end process;

    --caracter_port <= std_logic_vector(to_unsigned(character'pos(ascii_value), 8));

end architecture;