-- VHDL file
--
-- Autor: Jassan, Joel
-- Date: (may/2023)
-- 
-- Proyect Explanation: testbench de contador.vhd
-- El proyecto solo corre la simulacion para ver la forma de onda de salida.
--
--
-- Copyright 2023, Joel Jassan <joeljassan@hotmail.com>
-- All rights reserved.
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity contador_tb is
end entity;

architecture a_contador_tb of contador_tb is

    ----- Typedefs --------------------------------------------------------------------------------

    ----- Constants -------------------------------------------------------------------------------
    constant clk_period      : time := 10 ns;
    constant reset_off_time  : time := 80 ns;
    constant enable_off_time : time := 100 ns;
    constant simulation_time : time := 5000 ns; --esto no funciona

    ----- Simulation ------------------------------------------------------------------------------

    ----- Signals (i: entrada, o:salida, s:señal intermedia) --------------------------------------
    signal clk_i, rst_i, enable_i : std_logic;

    --component inputs

    --component outputs
    signal clk_enable : std_logic;
begin
    ----- Component to validate -------------------------------------------------------------------
    count : entity work.contador
        generic map(10, 10)
        port map(clk_i, rst_i, clk_enable, open);
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
        wait;
    end process;
    --
    --
    --

    -- End of test
    stop : process
    begin
        wait for 5000 ns; --tiempo total de
        std.env.stop;
    end process;

    -- Data Verify
    -- aqui irian los note, warning, etc.

end architecture;