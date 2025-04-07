library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TDM4_tb is
end TDM4_tb;

architecture test_bench of TDM4_tb is 	

	-- COMPONENT DECLARATION
	component TDM4 is
		generic (k_WIDTH : natural := 4);
		port (
			i_clk	: in  STD_LOGIC;
			i_reset	: in  STD_LOGIC;
			i_D3 	: in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
			i_D2 	: in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
			i_D1 	: in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
			i_D0 	: in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
			o_data	: out STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
			o_sel	: out STD_LOGIC_VECTOR (3 downto 0)
		);
	end component;

	-- CONSTANTS
	constant k_clk_period : time := 20 ns;
	constant k_IO_WIDTH   : natural := 4;

	-- SIGNALS
	signal w_clk    : std_logic := '0';
	signal w_reset  : std_logic;
	signal w_D3     : std_logic_vector(k_IO_WIDTH - 1 downto 0);
	signal w_D2     : std_logic_vector(k_IO_WIDTH - 1 downto 0);
	signal w_D1     : std_logic_vector(k_IO_WIDTH - 1 downto 0);
	signal w_D0     : std_logic_vector(k_IO_WIDTH - 1 downto 0);
	signal f_data   : std_logic_vector(k_IO_WIDTH - 1 downto 0);
	signal f_sel_n  : std_logic_vector(3 downto 0);

begin
	-- UUT PORT MAP
	uut_inst : TDM4
		generic map (k_WIDTH => k_IO_WIDTH)
		port map (
			i_clk   => w_clk,
			i_reset => w_reset,
			i_D3    => w_D3,
			i_D2    => w_D2,
			i_D1    => w_D1,
			i_D0    => w_D0,
			o_data  => f_data,
			o_sel   => f_sel_n
		);

	-- CLOCK PROCESS
	clk_process : process
	begin
		while now < 160 ns loop
			w_clk <= '0';
			wait for k_clk_period / 2;
			w_clk <= '1';
			wait for k_clk_period / 2;
		end loop;
		wait;
	end process clk_process;

	-- TEST PROCESS
	test_process : process 
	begin
		-- Assign test values to inputs
		w_D3 <= "1100";
		w_D2 <= "1001";
		w_D1 <= "0110";
		w_D0 <= "0011";

		-- Reset the system
		w_reset <= '1';
		wait for k_clk_period;
		w_reset <= '0';

		-- Run simulation for enough cycles to see full rotation
		wait for 160 ns;
		wait;
	end process test_process;

end test_bench;
