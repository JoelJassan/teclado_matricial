-- VHDL file
--
-- Autor: Jassan, Joel
-- Date: (may/2023)
-- 
-- Proyect Explanation: testbench de one_hot con bloque_antirrebote funcionando juntos.
-- El bloque de antirrebote necesita una frecuencia "number_of_ports" mas lenta que el one_hot.
-- Esta prueba me permite saber si va a funcionar al dividir en "number_of_ports" la frecuencia.
--
--
-- Copyright 2023, Joel Jassan <joeljassan@hotmail.com>
-- All rights reserved.
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity oneHot_antirrebote_tb is
end entity;

architecture a_oneHot_antirrebote_tb of oneHot_antirrebote_tb is

    ----- Typedefs --------------------------------------------------------------------------------

    ----- Constants -------------------------------------------------------------------------------

    constant counts_to_switch       : integer := 20;
    constant number_of_output_ports : integer := 4;
    constant number_of_cycles       : integer := 20;

    ----- Simulation ------------------------------------------------------------------------------
    constant clk_period      : time := 10 ns;
    constant reset_off_time  : time := 80 ns;
    constant enable_off_time : time := 100 ns;
    constant simulation_time : time := 20 ms;

    ----- Signals (i: entrada, o:salida, s:señal intermedia) --------------------------------------
    signal clk_i, rst_i, enable_i : std_logic;

    signal in_ports : std_logic_vector (number_of_output_ports - 1 downto 0);

    --one_hot
    signal one_hot_out_ports : std_logic_vector(number_of_output_ports - 1 downto 0);

    --bloque_arr
    signal data      : std_logic_vector(number_of_output_ports - 1 downto 0);
    signal out_ports : std_logic_vector(number_of_output_ports - 1 downto 0);

begin
    ----- Component to validate -------------------------------------------------------------------
    --one_hot_test : entity work.one_hot
    --    generic map(counts_to_switch, number_of_output_ports)
    --    port map(clk_i, rst_i, one_hot_out_ports);

    --bloque_ar_test : entity work.bloque_antirrebote
    --    generic map((number_of_cycles - 3), number_of_output_ports)
    --    port map(clk_i, one_hot_out_ports, data, out_ports);

    oneHot_ar_text : entity work.oneHot_antirrebote
        generic map(counts_to_switch, number_of_output_ports, number_of_cycles)
        port map(clk_i, rst_i, in_ports, out_ports);

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
        wait for 20 * reset_off_time;
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
    -- signals conection
    --data <= in_ports and one_hot_out_ports; -- simula la matriz

    ejecucion : process
    begin
        in_ports <= "0000";
        wait for 50000 * clk_period;
        in_ports <= "0001";
        wait for 200000 * clk_period;
        in_ports <= "0000";
        wait for 200000 * clk_period;
        in_ports <= "0100";
        wait for 200000 * clk_period;
        in_ports <= "1000";
        wait for 200000 * clk_period;
        in_ports <= "0110";
        wait for 200000 * clk_period;
        in_ports <= "0100";

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