library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_register_1bit is
end tb_register_1bit;

architecture Behavioral of tb_register_1bit is

    component register_1bit
        Port (
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            LOAD  : in  STD_LOGIC;
            D     : in  STD_LOGIC;
            Q     : out STD_LOGIC
        );
    end component;

    signal CLK   : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal LOAD  : STD_LOGIC := '0';
    signal D     : STD_LOGIC := '0';
    signal Q     : STD_LOGIC;

begin

    -- Unit Under Test
    UUT: register_1bit
        port map (
            CLK   => CLK,
            RESET => RESET,
            LOAD  => LOAD,
            D     => D,
            Q     => Q
        );

    -- Clock generation
    CLK_PROCESS: process
    begin
        while true loop
            CLK <= '0';
            wait for 10 ns;

            CLK <= '1';
            wait for 10 ns;
        end loop;
    end process;

    -- Test stimulus
    STIMULUS: process
    begin

        -- ==========================================
        -- Test 1: RESET
        -- ==========================================
        RESET <= '1';
        LOAD  <= '0';
        D     <= '1';

        wait for 20 ns;

        -- Q should become 0 at rising edge
        RESET <= '0';

        -- ==========================================
        -- Test 2: LOAD D = 1
        -- ==========================================
        LOAD <= '1';
        D    <= '1';

        wait for 20 ns;
		  
		  RESET <= '1';
        wait for 20 ns;

        -- Q should become 1

        -- ==========================================
        -- Test 3: HOLD
        -- ==========================================
        LOAD <= '0';
        D    <= '0';

        wait for 20 ns;

        -- Q should remain 1

        -- ==========================================
        -- Test 4: LOAD D = 0
        -- ==========================================
        LOAD <= '1';
        D    <= '0';

        wait for 20 ns;

        -- Q should become 0

        -- ==========================================
        -- Test 5: HOLD again
        -- ==========================================
        LOAD <= '0';
        D    <= '1';

        wait for 20 ns;
		  
		  

        -- Q should remain 0

        -- End simulation
        wait;

    end process;

end Behavioral;