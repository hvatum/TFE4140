library ieee;
use ieee.std_logic_1164.all;

ENTITY ab_latch IS
    PORT (A, B: IN std_ulogic;
         Q, QN: OUT std_ulogic);

    signal s_Q: std_ulogic;
    signal s_QN: std_ulogic;
END;

ARCHITECTURE behavior OF ab_latch IS
BEGIN
    s_Q <= A nor s_QN;
    s_QN <= B nor s_Q;
    Q <= s_Q;
    QN <= s_QN;
END;
