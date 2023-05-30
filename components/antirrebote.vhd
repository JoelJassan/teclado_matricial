library ieee;
use ieee.std_logic_1164.all;
entity antirrebote is

	generic (
		delay_count : integer := 100
	);

	port (
		clk      : in std_logic;
		tecla_in : in std_logic;

		tecla_out : out std_logic
	);

end antirrebote;

architecture antirrebote_a of antirrebote is

	signal tecla_prev : std_logic := '0';
	signal cnt        : integer range 0 to delay_count;

begin
	process (clk)
	begin

		if (rising_edge(clk)) then

			if (tecla_in xor tecla_prev) = '1' then
				cnt        <= 0;
				tecla_prev <= tecla_in;
			elsif cnt < delay_count then
				cnt <= cnt + 1;
			else
				tecla_out <= tecla_prev;

			end if;
		end if;

	end process;
end antirrebote_a;