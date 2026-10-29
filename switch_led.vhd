library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch_led is
    Port ( SW  : in  STD_LOGIC_VECTOR (7 downto 0);
           LED : out STD_LOGIC_VECTOR (7 downto 0));
end switch_led;

architecture Behavioral of switch_led is
begin
    LED <= SW;
end Behavioral;