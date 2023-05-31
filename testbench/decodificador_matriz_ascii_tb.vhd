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

entity decodificador_matriz_ascii_tb is
end entity;

architecture a_decodificador_matriz_ascii_tb of decodificador_matriz_ascii_tb is

    ----- Typedefs --------------------------------------------------------------------------------

    ----- Constants -------------------------------------------------------------------------------

    ----- Simulation ------------------------------------------------------------------------------
    constant clk_period      : time := 10 ns;
    constant reset_off_time  : time := 80 ns;
    constant enable_off_time : time := 100 ns;
    constant simulation_time : time := 11 us;

    ----- Signals (i: entrada, o:salida, s:señal intermedia) --------------------------------------
    signal clk_i, rst_i, enable_i : std_logic;

    --component inputs
    signal one_hot_in : std_logic_vector (3 downto 0) := "0000";
    signal matrix_out : std_logic_vector (3 downto 0) := "0000";
    --component outputs
    signal caracter_port : std_logic_vector (7 downto 0); --ASCII

begin
    ----- Component to validate -------------------------------------------------------------------
    deco : entity work.decodificador_matriz_ascii
        port map(clk_i, rst_i, one_hot_in, matrix_out, caracter_port);
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
    matrix : process
        variable flag : integer := 0;
    begin
        if flag = 0 then
            flag := 1;
            wait for 100 ns;
        end if;
        matrix_out <= "0001";
        wait for 500 ns;
        matrix_out <= "0010";
        wait for 500 ns;
        matrix_out <= "0100";
        wait for 500 ns;
        matrix_out <= "1000";
        wait for 500 ns;

    end process;

    one_hot : process
        variable flag : integer := 0;
    begin
        if flag = 0 then
            flag := 1;
            wait for 2100 ns;
        end if;
        one_hot_in <= "0001";
        wait for 2000 ns;
        one_hot_in <= "0010";
        wait for 2000 ns;
        one_hot_in <= "0100";
        wait for 2000 ns;
        one_hot_in <= "1000";
        wait for 2000 ns;

    end process;

    -- End of test
    stop : process
    begin
        wait for simulation_time; --tiempo total de
        std.env.stop;
    end process;

    -- Data Verify
    -- aqui irian los note, warning, etc.

end architecture;