-- -------------------------------------------------------------
-- 
-- File Name: Generated HDL Code\BiSS_Splitter_Rev8\Bit_Counter_Error_Detector.vhd
-- Created: 2020-09-09 16:25:01
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Bit_Counter_Error_Detector
-- Source Path: BiSS_Splitter_Rev8/BiSS C Master/Bit Counter & Error Detector
-- Hierarchy Level: 2
-- 
-- This state diagram runs in circles to determine which part of the BiSS C waveform 
-- the splitter is currently recieving, and make appropriate actions based off of that.
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.BiSS_Splitter_Rev8_pac.ALL;

ENTITY Bit_Counter_Error_Detector IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        clk_1                             :   IN    std_logic;
        SLO_in                            :   IN    std_logic;
        clk_enable_1                      :   OUT   std_logic;
        count_enable                      :   OUT   std_logic;
        error_rsvd                        :   OUT   std_logic;
        onDigit                           :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        request                           :   OUT   std_logic
        );
END Bit_Counter_Error_Detector;


ARCHITECTURE rtl OF Bit_Counter_Error_Detector IS

  -- Functions
  -- HDLCODER_TO_STDLOGIC 
  FUNCTION hdlcoder_to_stdlogic(arg: boolean) RETURN std_logic IS
  BEGIN
    IF arg THEN
      RETURN '1';
    ELSE
      RETURN '0';
    END IF;
  END FUNCTION;


  -- Signals
  SIGNAL is_Bit_Counter_Error_Detector    : T_state_type_is_Bit_Counter_Error_Detector;  -- uint8
  SIGNAL keeper                           : signed(7 DOWNTO 0);  -- int8
  SIGNAL onDigit_tmp                      : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL errorKeeper                      : std_logic;
  SIGNAL counter                          : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL clk_enable_reg                   : std_logic;
  SIGNAL count_enable_reg                 : std_logic;
  SIGNAL error_reg                        : std_logic;
  SIGNAL onDigit_reg                      : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL request_reg                      : std_logic;
  SIGNAL is_Bit_Counter_Error_Detector_next : T_state_type_is_Bit_Counter_Error_Detector;  -- enum type state_type_is_Bit_Counter_Error_Detector (5 enums)
  SIGNAL keeper_next                      : signed(7 DOWNTO 0);  -- int8
  SIGNAL errorKeeper_next                 : std_logic;
  SIGNAL counter_next                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL clk_enable_reg_next              : std_logic;
  SIGNAL count_enable_reg_next            : std_logic;
  SIGNAL error_reg_next                   : std_logic;
  SIGNAL onDigit_reg_next                 : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL request_reg_next                 : std_logic;

BEGIN
  Bit_Counter_Error_Detector_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        keeper <= to_signed(16#00#, 8);
        errorKeeper <= '0';
        counter <= to_unsigned(16#00#, 8);
        clk_enable_reg <= '0';
        error_reg <= '0';
        onDigit_reg <= to_unsigned(16#00#, 8);
        is_Bit_Counter_Error_Detector <= IN_Ready;
        count_enable_reg <= '0';
        request_reg <= '0';
      ELSIF enb = '1' THEN
        is_Bit_Counter_Error_Detector <= is_Bit_Counter_Error_Detector_next;
        keeper <= keeper_next;
        errorKeeper <= errorKeeper_next;
        counter <= counter_next;
        clk_enable_reg <= clk_enable_reg_next;
        count_enable_reg <= count_enable_reg_next;
        error_reg <= error_reg_next;
        onDigit_reg <= onDigit_reg_next;
        request_reg <= request_reg_next;
      END IF;
    END IF;
  END PROCESS Bit_Counter_Error_Detector_1_process;

  Bit_Counter_Error_Detector_1_output : PROCESS (SLO_in, clk_1, clk_enable_reg, count_enable_reg, counter, errorKeeper,
       error_reg, is_Bit_Counter_Error_Detector, keeper, onDigit_reg,
       request_reg)
    VARIABLE sf_internal_predicateOutput : std_logic;
    VARIABLE sf_internal_predicateoutput_0 : std_logic;
    VARIABLE sf_internal_predicateoutput_1 : std_logic;
    VARIABLE sf_internal_predicateoutput_2 : std_logic;
    VARIABLE sf_internal_predicateoutput_3 : std_logic;
    VARIABLE counter_temp : unsigned(7 DOWNTO 0);
    VARIABLE onDigit_reg_temp : unsigned(7 DOWNTO 0);
    VARIABLE add_temp : unsigned(8 DOWNTO 0);
  BEGIN
    sf_internal_predicateoutput_3 := '0';
    sf_internal_predicateOutput := '0';
    sf_internal_predicateoutput_0 := '0';
    sf_internal_predicateoutput_1 := '0';
    sf_internal_predicateoutput_2 := '0';
    add_temp := to_unsigned(16#000#, 9);
    onDigit_reg_temp := onDigit_reg;
    counter_temp := counter;
    clk_enable_reg_next <= clk_enable_reg;
    count_enable_reg_next <= count_enable_reg;
    error_reg_next <= error_reg;
    request_reg_next <= request_reg;
    is_Bit_Counter_Error_Detector_next <= is_Bit_Counter_Error_Detector;
    keeper_next <= keeper;
    errorKeeper_next <= errorKeeper;
    CASE is_Bit_Counter_Error_Detector IS
      WHEN IN_Ack =>
        sf_internal_predicateOutput := hdlcoder_to_stdlogic((( NOT SLO_in) AND clk_1) = '1');
        IF sf_internal_predicateOutput = '1' THEN 
          is_Bit_Counter_Error_Detector_next <= IN_Start;
        END IF;
      WHEN IN_Read =>
        count_enable_reg_next <= '1';
        sf_internal_predicateoutput_0 := hdlcoder_to_stdlogic((hdlcoder_to_stdlogic(counter = to_unsigned(16#2B#, 8)) AND clk_1) = '1');
        IF sf_internal_predicateoutput_0 = '1' THEN 
          onDigit_reg_temp := to_unsigned(16#00#, 8);
          clk_enable_reg_next <= '0';
          is_Bit_Counter_Error_Detector_next <= IN_Ready;
          count_enable_reg_next <= '0';
          request_reg_next <= '0';
        ELSE 
          IF (clk_1 AND hdlcoder_to_stdlogic(keeper = to_signed(16#00#, 8))) = '1' THEN 
            add_temp := resize(counter, 9) + to_unsigned(16#001#, 9);
            IF add_temp(8) /= '0' THEN 
              counter_temp := "11111111";
            ELSE 
              counter_temp := add_temp(7 DOWNTO 0);
            END IF;
            keeper_next <= to_signed(16#01#, 8);
            IF counter_temp < to_unsigned(16#2B#, 8) THEN 
              onDigit_reg_temp := counter_temp;
            ELSE 
              onDigit_reg_temp := to_unsigned(16#00#, 8);
              clk_enable_reg_next <= '0';
            END IF;
          ELSIF ( NOT clk_1) = '1' THEN 
            keeper_next <= to_signed(16#00#, 8);
          END IF;
          IF (hdlcoder_to_stdlogic(onDigit_reg_temp = to_unsigned(16#21#, 8)) AND ( NOT errorKeeper)) = '1' THEN 
            IF SLO_in = '1' THEN 
              error_reg_next <= '1';
            END IF;
            errorKeeper_next <= '1';
          END IF;
        END IF;
      WHEN IN_Ready =>
        count_enable_reg_next <= '0';
        sf_internal_predicateoutput_1 := hdlcoder_to_stdlogic((SLO_in AND clk_1) = '1');
        IF sf_internal_predicateoutput_1 = '1' THEN 
          is_Bit_Counter_Error_Detector_next <= IN_Ack;
          error_reg_next <= '0';
          clk_enable_reg_next <= '1';
          request_reg_next <= '1';
        END IF;
      WHEN IN_Start =>
        sf_internal_predicateoutput_2 := hdlcoder_to_stdlogic((SLO_in AND clk_1) = '1');
        IF sf_internal_predicateoutput_2 = '1' THEN 
          is_Bit_Counter_Error_Detector_next <= IN_Zero;
        END IF;
      WHEN OTHERS => 
        --case IN_Zero:
        sf_internal_predicateoutput_3 := hdlcoder_to_stdlogic((( NOT SLO_in) AND clk_1) = '1');
        IF sf_internal_predicateoutput_3 = '1' THEN 
          is_Bit_Counter_Error_Detector_next <= IN_Read;
          clk_enable_reg_next <= '1';
          keeper_next <= to_signed(16#01#, 8);
          onDigit_reg_temp := to_unsigned(16#01#, 8);
          count_enable_reg_next <= '1';
          counter_temp := to_unsigned(16#01#, 8);
          errorKeeper_next <= '0';
        END IF;
    END CASE;
    counter_next <= counter_temp;
    onDigit_reg_next <= onDigit_reg_temp;
  END PROCESS Bit_Counter_Error_Detector_1_output;

  clk_enable_1 <= clk_enable_reg_next;
  count_enable <= count_enable_reg_next;
  error_rsvd <= error_reg_next;
  onDigit_tmp <= onDigit_reg_next;
  request <= request_reg_next;

  onDigit <= std_logic_vector(onDigit_tmp);

END rtl;

