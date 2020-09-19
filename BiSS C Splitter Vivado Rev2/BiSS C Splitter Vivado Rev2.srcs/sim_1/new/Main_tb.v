library ieee;
use ieee.std_logic_1164.all;

entity tb_BiSS_Splitter_Rev8 is
end tb_BiSS_Splitter_Rev8;

architecture tb of tb_BiSS_Splitter_Rev8 is

    component BiSS_Splitter_Rev8
        port (clk         : in std_logic;
              reset       : in std_logic;
              clk_enable  : in std_logic;
              Encoder_SLO : in std_logic;
              DAQ_Trig    : in std_logic;
              Motor_MA    : in std_logic;
              clk_1       : in std_logic;
              ce_out      : out std_logic;
              Encoder_MA  : out std_logic;
              DAQ_Out     : out std_logic;
              Motor_SLO   : out std_logic);
    end component;

    signal clk         : std_logic;
    signal reset       : std_logic;
    signal clk_enable  : std_logic;
    signal Encoder_SLO : std_logic;
    signal DAQ_Trig    : std_logic;
    signal Motor_MA    : std_logic;
    signal clk_1       : std_logic;
    signal ce_out      : std_logic;
    signal Encoder_MA  : std_logic;
    signal DAQ_Out     : std_logic;
    signal Motor_SLO   : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : BiSS_Splitter_Rev8
    port map (clk         => clk,
              reset       => reset,
              clk_enable  => clk_enable,
              Encoder_SLO => Encoder_SLO,
              DAQ_Trig    => DAQ_Trig,
              Motor_MA    => Motor_MA,
              clk_1       => clk_1,
              ce_out      => ce_out,
              Encoder_MA  => Encoder_MA,
              DAQ_Out     => DAQ_Out,
              Motor_SLO   => Motor_SLO);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        clk_enable <= '0';
        Encoder_SLO <= '0';
        DAQ_Trig <= '0';
        Motor_MA <= '0';
        clk_1 <= '0';
        wait for 100 ns;
        Encoder_SLO <= '1';
        wait for 100 ns;
        Encoder_SLO <= '0';
        wait for 100 ns;
        Encoder_SLO <= '1';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_BiSS_Splitter_Rev8 of tb_BiSS_Splitter_Rev8 is
    for tb
    end for;
end cfg_tb_BiSS_Splitter_Rev8;