library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sr_latch_tb is
end sr_latch_tb;

architecture Behavioral of sr_latch_tb is

    component sr_latch
        Port ( S_n : in  STD_LOGIC;
               R_n : in  STD_LOGIC;
               Q   : out STD_LOGIC;
               Q_n : out STD_LOGIC);
    end component;

    signal Sn_tb, Rn_tb, Q_tb, Qn_tb : STD_LOGIC;

begin

    UUT: sr_latch port map ( S_n => Sn_tb, R_n => Rn_tb, Q => Q_tb, Q_n => Qn_tb );

    stim_proc: process
    begin
        -- Set (S_n=0, R_n=1): Q should go to 1
        Sn_tb <= '0'; Rn_tb <= '1'; wait for 20 ns;
        assert (Q_tb = '1' and Qn_tb = '0')
            report "FAIL: Set did not force Q=1" severity error;

        -- Hold (S_n=1, R_n=1): Q should retain previous value (1)
        Sn_tb <= '1'; Rn_tb <= '1'; wait for 20 ns;
        assert (Q_tb = '1')
            report "FAIL: Hold after Set did not retain Q=1" severity error;

        -- Reset (S_n=1, R_n=0): Q should go to 0
        Sn_tb <= '1'; Rn_tb <= '0'; wait for 20 ns;
        assert (Q_tb = '0' and Qn_tb = '1')
            report "FAIL: Reset did not force Q=0" severity error;

        -- Hold (S_n=1, R_n=1): Q should retain previous value (0)
        Sn_tb <= '1'; Rn_tb <= '1'; wait for 20 ns;
        assert (Q_tb = '0')
            report "FAIL: Hold after Reset did not retain Q=0" severity error;

        -- Invalid state (S_n=0, R_n=0): both Q and Q_n driven to 1
        -- (not a valid stored state); report observed result, don't assert PASS/FAIL
        Sn_tb <= '0'; Rn_tb <= '0'; wait for 20 ns;
        report "INFO: Invalid state S_n=0,R_n=0 -> Q=" & STD_LOGIC'image(Q_tb) &
               " Q_n=" & STD_LOGIC'image(Qn_tb) severity note;

        -- Exit invalid state, confirm latch resolves to a defined state
        Sn_tb <= '1'; Rn_tb <= '1'; wait for 20 ns;
        report "INFO: After leaving invalid state -> Q=" & STD_LOGIC'image(Q_tb) &
               " Q_n=" & STD_LOGIC'image(Qn_tb) severity note;

        report "PASS: sr_latch testbench completed" severity note;
        wait;
    end process;

end Behavioral;