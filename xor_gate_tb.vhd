library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_gate_tb is
end xor_gate_tb;

architecture Behavioral of xor_gate_tb is

    component xor_gate
        Port ( A : in  STD_LOGIC;
               B : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    signal A_tb, B_tb, Y_tb : STD_LOGIC;

begin

    UUT: xor_gate port map ( A => A_tb, B => B_tb, Y => Y_tb );

    stim_proc: process
    begin
        A_tb <= '0'; B_tb <= '0'; wait for 20 ns;
        assert (Y_tb = '0') report "FAIL: XOR(0,0) /= 0" severity error;

        A_tb <= '0'; B_tb <= '1'; wait for 20 ns;
        assert (Y_tb = '1') report "FAIL: XOR(0,1) /= 1" severity error;

        A_tb <= '1'; B_tb <= '0'; wait for 20 ns;
        assert (Y_tb = '1') report "FAIL: XOR(1,0) /= 1" severity error;

        A_tb <= '1'; B_tb <= '1'; wait for 20 ns;
        assert (Y_tb = '0') report "FAIL: XOR(1,1) /= 0" severity error;

        report "PASS: xor_gate testbench completed" severity note;
        wait;
    end process;

end Behavioral;