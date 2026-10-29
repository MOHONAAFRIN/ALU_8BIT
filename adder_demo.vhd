library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_demo is
    Port ( SW_A : in  STD_LOGIC_VECTOR (3 downto 0);
           SW_B : in  STD_LOGIC_VECTOR (3 downto 0);
           LED_SUM  : out STD_LOGIC_VECTOR (3 downto 0);
           LED_COUT : out STD_LOGIC);
end adder_demo;

architecture Structural of adder_demo is

    component adder_4bit
        Port ( A    : in  STD_LOGIC_VECTOR (3 downto 0);
               B    : in  STD_LOGIC_VECTOR (3 downto 0);
               CIN  : in  STD_LOGIC;
               SUM  : out STD_LOGIC_VECTOR (3 downto 0);
               COUT : out STD_LOGIC);
    end component;

begin

    UUT: adder_4bit port map (
        A => SW_A, B => SW_B, CIN => '0',
        SUM => LED_SUM, COUT => LED_COUT
    );

end Structural;