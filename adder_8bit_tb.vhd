library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder_8bit_tb is
end adder_8bit_tb;

architecture Behavioral of adder_8bit_tb is

    component adder_8bit
        Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
               B    : in  STD_LOGIC_VECTOR (7 downto 0);
               CIN  : in  STD_LOGIC;
               SUM  : out STD_LOGIC_VECTOR (7 downto 0);
               COUT : out STD_LOGIC);
    end component;

    signal A_tb, B_tb, SUM_tb : STD_LOGIC_VECTOR (7 downto 0);
    signal CIN_tb, COUT_tb    : STD_LOGIC;

begin

    UUT: adder_8bit port map ( A => A_tb, B => B_tb, CIN => CIN_tb,
                                SUM => SUM_tb, COUT => COUT_tb );

    stim_proc: process
    begin
        -- 00 + 00, no carry-in -> 00, cout=0
        A_tb <= x"00"; B_tb <= x"00"; CIN_tb <= '0'; wait for 20 ns;
        assert (SUM_tb = x"00" and COUT_tb = '0') report "FAIL: 00+00" severity error;

        -- FF + 01 -> 00, cout=1
        A_tb <= x"FF"; B_tb <= x"01"; CIN_tb <= '0'; wait for 20 ns;
        assert (SUM_tb = x"00" and COUT_tb = '1') report "FAIL: FF+01" severity error;

        -- 0F + 01 -> 10, cout=0 (nibble carry into upper nibble, no overall carry-out)
        A_tb <= x"0F"; B_tb <= x"01"; CIN_tb <= '0'; wait for 20 ns;
        assert (SUM_tb = x"10" and COUT_tb = '0') report "FAIL: 0F+01" severity error;

        -- 55 + AA -> FF, cout=0
        A_tb <= x"55"; B_tb <= x"AA"; CIN_tb <= '0'; wait for 20 ns;
        assert (SUM_tb = x"FF" and COUT_tb = '0') report "FAIL: 55+AA" severity error;

        -- AA + 55 -> FF, cout=0
        A_tb <= x"AA"; B_tb <= x"55"; CIN_tb <= '0'; wait for 20 ns;
        assert (SUM_tb = x"FF" and COUT_tb = '0') report "FAIL: AA+55" severity error;

        -- random vector 1: 3C + 27 = 63, cout=0
        A_tb <= x"3C"; B_tb <= x"27"; CIN_tb <= '0'; wait for 20 ns;
        assert (SUM_tb = x"63" and COUT_tb = '0') report "FAIL: 3C+27" severity error;

        -- random vector 2: 9D + 64 = 01, cout=1 (0x9D+0x64=0x101)
        A_tb <= x"9D"; B_tb <= x"64"; CIN_tb <= '0'; wait for 20 ns;
        assert (SUM_tb = x"01" and COUT_tb = '1') report "FAIL: 9D+64" severity error;

        -- random vector 3 with carry-in: 10 + 20 + CIN=1 = 31, cout=0
        A_tb <= x"10"; B_tb <= x"20"; CIN_tb <= '1'; wait for 20 ns;
        assert (SUM_tb = x"31" and COUT_tb = '0') report "FAIL: 10+20+cin" severity error;

        report "PASS: adder_8bit testbench completed" severity note;
        wait;
    end process;

end Behavioral;