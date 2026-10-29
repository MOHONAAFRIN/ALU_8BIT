library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_8bit_tb is
end alu_8bit_tb;

architecture Behavioral of alu_8bit_tb is

    component alu_8bit
        Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
               B    : in  STD_LOGIC_VECTOR (7 downto 0);
               SEL  : in  STD_LOGIC_VECTOR (2 downto 0);
               Y    : out STD_LOGIC_VECTOR (7 downto 0);
               COUT : out STD_LOGIC);
    end component;

    signal A_tb, B_tb, Y_tb : STD_LOGIC_VECTOR (7 downto 0);
    signal SEL_tb           : STD_LOGIC_VECTOR (2 downto 0);
    signal COUT_tb          : STD_LOGIC;

begin

    UUT: alu_8bit port map ( A => A_tb, B => B_tb, SEL => SEL_tb,
                             Y => Y_tb, COUT => COUT_tb );

    stim_proc: process
    begin
        ---------------- ADD (SEL = 000) ----------------
        SEL_tb <= "000";
        A_tb <= x"3C"; B_tb <= x"27"; wait for 20 ns;
        assert (Y_tb = x"63" and COUT_tb = '0') report "FAIL: ADD 3C+27" severity error;

        A_tb <= x"FF"; B_tb <= x"01"; wait for 20 ns;
        assert (Y_tb = x"00" and COUT_tb = '1') report "FAIL: ADD FF+01" severity error;

        A_tb <= x"0F"; B_tb <= x"01"; wait for 20 ns;
        assert (Y_tb = x"10" and COUT_tb = '0') report "FAIL: ADD 0F+01" severity error;

        ---------------- XOR (SEL = 001) ----------------
        SEL_tb <= "001";
        A_tb <= x"F0"; B_tb <= x"FF"; wait for 20 ns;
        assert (Y_tb = x"0F" and COUT_tb = '0') report "FAIL: XOR F0^FF" severity error;

        A_tb <= x"AA"; B_tb <= x"55"; wait for 20 ns;
        assert (Y_tb = x"FF" and COUT_tb = '0') report "FAIL: XOR AA^55" severity error;

        A_tb <= x"5A"; B_tb <= x"5A"; wait for 20 ns;
        assert (Y_tb = x"00" and COUT_tb = '0') report "FAIL: XOR 5A^5A" severity error;

        ---------------- NOT (SEL = 010) ----------------
        SEL_tb <= "010";
        A_tb <= x"0F"; B_tb <= x"FF"; wait for 20 ns;   -- B must be ignored
        assert (Y_tb = x"F0" and COUT_tb = '0') report "FAIL: NOT 0F" severity error;

        A_tb <= x"00"; B_tb <= x"00"; wait for 20 ns;
        assert (Y_tb = x"FF" and COUT_tb = '0') report "FAIL: NOT 00" severity error;

        ---------------- SHL (SEL = 011) ----------------
        SEL_tb <= "011";
        A_tb <= x"01"; B_tb <= x"FF"; wait for 20 ns;   -- B must be ignored
        assert (Y_tb = x"02" and COUT_tb = '0') report "FAIL: SHL 01" severity error;

        A_tb <= x"81"; B_tb <= x"00"; wait for 20 ns;
        assert (Y_tb = x"02" and COUT_tb = '1') report "FAIL: SHL 81" severity error;

        A_tb <= x"C0"; B_tb <= x"00"; wait for 20 ns;
        assert (Y_tb = x"80" and COUT_tb = '1') report "FAIL: SHL C0" severity error;

        ---------------- LDI (SEL = 100) ----------------
        SEL_tb <= "100";
        A_tb <= x"FF"; B_tb <= x"A5"; wait for 20 ns;   -- A must be ignored
        assert (Y_tb = x"A5" and COUT_tb = '0') report "FAIL: LDI A5" severity error;

        A_tb <= x"00"; B_tb <= x"3E"; wait for 20 ns;
        assert (Y_tb = x"3E" and COUT_tb = '0') report "FAIL: LDI 3E" severity error;

        report "PASS: alu_8bit testbench completed" severity note;
        wait;
    end process;

end Behavioral;