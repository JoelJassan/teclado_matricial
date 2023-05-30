-- VHDL file
--
-- Autor: Jassan, Joel
-- Date: (may/2023)
-- 
-- Proyect Explanation: testbench de bloque_antirrebote.vhd
-- Se estimula in_ports para ver que funcionen todos los antirrebotes.
--
--
-- Copyright 2023, Joel Jassan <joeljassan@hotmail.com>
-- All rights reserved.
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity bloque_antirrebote_tb is
end entity;

architecture a_bloque_antirrebote_tb of bloque_antirrebote_tb is

    ----- Typedefs --------------------------------------------------------------------------------

    ----- Constants -------------------------------------------------------------------------------

    constant delay_count     : integer := 50000;
    constant number_of_ports : integer := 6;

    ----- Simulation ------------------------------------------------------------------------------
    constant clk_period      : time := 20 ns;
    constant reset_off_time  : time := 80 ns;
    constant enable_off_time : time := 100 ns;
    constant simulation_time : time := 10 ms;
    constant extra_time      : time := delay_count/10 * clk_period;

    ----- Signals (i: entrada, o:salida, s:señal intermedia) --------------------------------------
    signal clk_i, rst_i, enable_i : std_logic;

    --component inputs
    signal in_ports : std_logic_vector (number_of_ports - 1 downto 0);

    --component outputs
    signal out_ports : std_logic_vector (number_of_ports - 1 downto 0);

begin
    ----- Component to validate -------------------------------------------------------------------
    bloque_ar_test : entity work.bloque_antirrebote
        generic map(delay_count, number_of_ports)
        port map(clk_i, in_ports, out_ports);
    ----- Code ------------------------------------------------------------------------------------

    -- clock stimulus
    reloj : process
    begin
        clk_i <= '0';
        wait for clk_period/2;
        clk_i <= '1';
        wait for clk_period/2;
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

    -- component to validate stimulus ------
    --
    --
    ejecucion : process
    begin
        in_ports <= (others => '0');
        wait for delay_count * clk_period;
        wait for extra_time;
        in_ports(1) <= '1';
        wait for delay_count * clk_period;
        wait for extra_time;
        in_ports(0) <= '1';
        wait for delay_count * clk_period;
        wait for extra_time;
        --in_ports <= "101100";
        wait;
    end process;
    --
    --
    ----------------------------------------

    -- End of test
    stop : process
    begin
        wait for simulation_time; --tiempo total de
        std.env.stop;
    end process;

    -- Data Verify
    -- aqui irian los note, warning, etc.

end architecture;