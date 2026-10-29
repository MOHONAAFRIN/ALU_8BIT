library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xnor_gate is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Y : out STD_LOGIC);
end xnor_gate;

architecture Structural of xnor_gate is

    component xor_gate
        Port ( A : in  STD_LOGIC;
               B : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    component not_gate
        Port ( A : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    signal xor_out : STD_LOGIC;

begin

    U1: xor_gate port map ( A => A, B => B, Y => xor_out );
    U2: not_gate port map ( A => xor_out, Y => Y );

end Structural;