library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch_led_tb is
end switch_led_tb;

architecture Behavioral of switch_led_tb is

    component switch_led
        Port ( SW  : in  STD_LOGIC_VECTOR (7 downto 0);
               LED : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal SW_tb  : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal LED_tb : STD_LOGIC_VECTOR (7 downto 0);

begin

    UUT: switch_led
        Port map ( SW => SW_tb, LED => LED_tb );

    stim_proc: process
    begin
        -- all zeros
        SW_tb <= "00000000";
        wait for 20 ns;
        assert (LED_tb = "00000000")
            report "FAIL: all-zeros pattern did not pass through" severity error;

        -- all ones
        SW_tb <= "11111111";
        wait for 20 ns;
        assert (LED_tb = "11111111")
            report "FAIL: all-ones pattern did not pass through" severity error;

        -- mixed pattern 1
        SW_tb <= "10101010";
        wait for 20 ns;
        assert (LED_tb = "10101010")
            report "FAIL: pattern 10101010 did not pass through" severity error;

        -- mixed pattern 2
        SW_tb <= "01010101";
        wait for 20 ns;
        assert (LED_tb = "01010101")
            report "FAIL: pattern 01010101 did not pass through" severity error;

        -- mixed pattern 3
        SW_tb <= "11001100";
        wait for 20 ns;
        assert (LED_tb = "11001100")
            report "FAIL: pattern 11001100 did not pass through" severity error;

        report "PASS: switch_led testbench completed" severity note;
        wait;
    end process;

end Behavioral;