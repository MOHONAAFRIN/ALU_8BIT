library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_flip_flop_tb is
end d_flip_flop_tb;

architecture Behavioral of d_flip_flop_tb is

    component d_flip_flop
        Port ( D   : in  STD_LOGIC;
               CLK : in  STD_LOGIC;
               Q   : out STD_LOGIC;
               Q_n : out STD_LOGIC);
    end component;

    signal D_tb, CLK_tb, Q_tb, Qn_tb : STD_LOGIC := '0';

begin

    UUT: d_flip_flop port map ( D => D_tb, CLK => CLK_tb, Q => Q_tb, Q_n => Qn_tb );

    -- free-running clock, period 20 ns
    clk_proc: process
    begin
        CLK_tb <= '0'; wait for 10 ns;
        CLK_tb <= '1'; wait for 10 ns;
    end process;

    stim_proc: process
    begin
        D_tb <= '0';
        wait until rising_edge(CLK_tb); wait for 2 ns;
        assert (Q_tb = '0') report "FAIL: Q did not initialize/capture D=0" severity error;

        -- Change D while CLK is HIGH; Q must NOT change until the next rising edge
        wait until CLK_tb = '1';
        D_tb <= '1';
        wait for 2 ns;
        assert (Q_tb = '0') report "FAIL: Q changed while CLK was already high" severity error;

        -- Wait for CLK to go low then high again -> next rising edge should capture D=1
        wait until CLK_tb = '0';
        wait until rising_edge(CLK_tb);
        wait for 2 ns;
        assert (Q_tb = '1') report "FAIL: Q did not update to D=1 on rising edge" severity error;

        -- Change D again mid-high-phase, confirm no change until next edge
        wait until CLK_tb = '1';
        D_tb <= '0';
        wait for 2 ns;
        assert (Q_tb = '1') report "FAIL: Q changed while CLK was already high (2nd)" severity error;

        wait until CLK_tb = '0';
        wait until rising_edge(CLK_tb);
        wait for 2 ns;
        assert (Q_tb = '0') report "FAIL: Q did not update to D=0 on rising edge" severity error;

        report "PASS: d_flip_flop testbench completed" severity note;
        wait;
    end process;

end Behavioral;