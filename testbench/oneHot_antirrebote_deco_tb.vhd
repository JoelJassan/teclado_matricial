-- VHDL file
--
-- Autor: Jassan, Joel
-- Date: (mmm/YYYY)
-- 
-- Proyect Explanation:
--
--
-- Copyright 2023, Joel Jassan <joeljassan@hotmail.com>
-- All rights reserved.
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity oneHot_antirrebote_deco_tb is
end entity;

architecture a_oneHot_antirrebote_deco_tb of oneHot_antirrebote_deco_tb is

    ----- Typedefs --------------------------------------------------------------------------------

    ----- Constants -------------------------------------------------------------------------------
    constant counts_to_switch       : integer := 5; -- cuentas para switchear el one_hot
    constant number_of_output_ports : integer := 4; -- 4 para la matriz 4x4
    constant number_of_cycles       : integer := 5; -- cuentas para antirrebote

    ----- Simulation ------------------------------------------------------------------------------
    constant clk_period      : time := 10 ns;
    constant reset_off_time  : time := 80 ns;
    constant enable_off_time : time := 100 ns;
    constant simulation_time : time := 5000 ns;

    ----- Signals (i: entrada, o:salida, s:señal intermedia) --------------------------------------
    signal clk_i, rst_i, enable_i : std_logic;

    --component inputs
    signal matrix_button  : std_logic_vector(number_of_output_ports - 1 downto 0);
    signal ascii_caracter : std_logic_vector (7 downto 0); --ASCII

    --component outputs

begin
    ----- Component to validate -------------------------------------------------------------------
    oneHot_ar_deco_test : entity work.oneHot_antirrebote_deco
        generic map(counts_to_switch, number_of_output_ports, number_of_cycles)
        port map(clk_i, rst_i, matrix_button, ascii_caracter);
    ----- Code ------------------------------------------------------------------------------------

    -- clock stimulus
    reloj : process
    begin
        clk_i <= '0';
        wait for clk_period;
        clk_i <= '1';
        wait for clk_period;
    end process;

    -- reset stimulus
    reset : process
    begin
        rst_i <= '0';
        wait for reset_off_time;
        rst_i <= '1';
        wait;
    end process;

    -- enable stimulus
    enable : process
    begin
        wait for enable_off_time;
        enable_i <= '1';
        wait;
    end process;

    -- component to validate stimulus
    --
    --
    ejecucion : process
    begin
        matrix_button <= "0000";
        wait for 100 ns;
        matrix_button <= "0001";
        wait for 500 us;
        matrix_button <= "0001";
        wait for 500 us;
        matrix_button <= "0010";

        wait;
    end process;
    --
    --
    --

    -- End of test
    stop : process
    begin
        wait for simulation_time; --tiempo total de
        std.env.stop;
    end process;

    -- Data Verify
    -- aqui irian los note, warning, etc.

end architecture;