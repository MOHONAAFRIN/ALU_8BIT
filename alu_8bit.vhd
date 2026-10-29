library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_8bit is
    Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
           B    : in  STD_LOGIC_VECTOR (7 downto 0);
           SEL  : in  STD_LOGIC_VECTOR (2 downto 0);
           Y    : out STD_LOGIC_VECTOR (7 downto 0);
           COUT : out STD_LOGIC);
end alu_8bit;

architecture Structural of alu_8bit is

    component adder_8bit
        Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
               B    : in  STD_LOGIC_VECTOR (7 downto 0);
               CIN  : in  STD_LOGIC;
               SUM  : out STD_LOGIC_VECTOR (7 downto 0);
               COUT : out STD_LOGIC);
    end component;

    component xor_gate
        Port ( A : in  STD_LOGIC;
               B : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    component not_gate
        Port ( A : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    component mux4
        Port ( D0  : in  STD_LOGIC;
               D1  : in  STD_LOGIC;
               D2  : in  STD_LOGIC;
               D3  : in  STD_LOGIC;
               SEL : in  STD_LOGIC_VECTOR (1 downto 0);
               Y   : out STD_LOGIC);
    end component;

    component mux2
        Port ( D0  : in  STD_LOGIC;
               D1  : in  STD_LOGIC;
               SEL : in  STD_LOGIC;
               Y   : out STD_LOGIC);
    end component;

    signal add_res : STD_LOGIC_VECTOR (7 downto 0);
    signal xor_res : STD_LOGIC_VECTOR (7 downto 0);
    signal not_res : STD_LOGIC_VECTOR (7 downto 0);
    signal shl_res : STD_LOGIC_VECTOR (7 downto 0);
    signal op_res  : STD_LOGIC_VECTOR (7 downto 0);
    signal add_cout : STD_LOGIC;
    signal op_cout  : STD_LOGIC;

begin

    U_ADD: adder_8bit port map (
        A => A, B => B, CIN => '0',
        SUM => add_res, COUT => add_cout
    );

    shl_res(0)          <= '0';
    shl_res(7 downto 1) <= A(6 downto 0);

    GEN_BIT: for i in 0 to 7 generate

        U_XOR: xor_gate port map ( A => A(i), B => B(i), Y => xor_res(i) );
        U_NOT: not_gate port map ( A => A(i), Y => not_res(i) );

        U_MUX4: mux4 port map (
            D0 => add_res(i),
            D1 => xor_res(i),
            D2 => not_res(i),
            D3 => shl_res(i),
            SEL => SEL(1 downto 0),
            Y  => op_res(i)
        );

        U_MUX2: mux2 port map (
            D0 => op_res(i),
            D1 => B(i),
            SEL => SEL(2),
            Y  => Y(i)
        );

    end generate GEN_BIT;

    U_CMUX4: mux4 port map (
        D0 => add_cout,
        D1 => '0',
        D2 => '0',
        D3 => A(7),
        SEL => SEL(1 downto 0),
        Y  => op_cout
    );

    U_CMUX2: mux2 port map (
        D0 => op_cout,
        D1 => '0',
        SEL => SEL(2),
        Y  => COUT
    );

end Structural;