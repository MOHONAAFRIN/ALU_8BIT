library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_latch_tb is
end d_latch_tb;

architecture Behavioral of d_latch_tb is

    component d_latch
        Port ( D      : in  STD_LOGIC;
               ENABLE : in  STD_LOGIC;
               Q      : out STD_LOGIC;
               Q_n    : out STD_LOGIC);
    end component;

    signal D_tb, EN_tb, Q_tb, Qn_tb : STD_LOGIC;

begin

    UUT: d_latch port map ( D => D_tb, ENABLE => EN_tb, Q => Q_tb, Q_n => Qn_tb );

    stim_proc: process
    begin
        -- Transparent mode: ENABLE=1, Q should follow D
        EN_tb <= '1';

        D_tb <= '0'; wait for 20 ns;
        assert (Q_tb = '0') report "FAIL: transparent D=0 -> Q/=0" severity error;

        D_tb <= '1'; wait for 20 ns;
        assert (Q_tb = '1') report "FAIL: transparent D=1 -> Q/=1" severity error;

        D_tb <= '0'; wait for 20 ns;
        assert (Q_tb = '0') report "FAIL: transparent D=0 (2nd) -> Q/=0" severity error;

        -- Hold mode: ENABLE=0, Q should hold last value regardless of D
        EN_tb <= '0'; wait for 20 ns;
        assert (Q_tb = '0') report "FAIL: hold did not retain Q=0" severity error;

        D_tb <= '1'; wait for 20 ns;  -- D changes, Q must NOT follow
        assert (Q_tb = '0') report "FAIL: Q changed while ENABLE=0" severity error;

        D_tb <= '0'; wait for 20 ns;  -- D changes again, Q must still hold
        assert (Q_tb = '0') report "FAIL: Q changed while ENABLE=0 (2nd)" severity error;

        -- Re-enable and confirm transparency resumes with the now-held D value
        EN_tb <= '1'; D_tb <= '1'; wait for 20 ns;
        assert (Q_tb = '1') report "FAIL: transparency did not resume after re-enable" severity error;

        report "PASS: d_latch testbench completed" severity note;
        wait;
    end process;

end Behavioral;