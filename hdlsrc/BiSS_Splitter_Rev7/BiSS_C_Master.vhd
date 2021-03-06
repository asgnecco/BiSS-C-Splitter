-- -------------------------------------------------------------
-- 
-- File Name: hdlsrc\BiSS_Splitter_Rev7\BiSS_C_Master.vhd
-- Created: 2020-08-28 16:31:32
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: BiSS_C_Master
-- Source Path: BiSS_Splitter_Rev7/BiSS C Master
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY BiSS_C_Master IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_2_0                         :   IN    std_logic;
        enb                               :   IN    std_logic;
        SLO_In                            :   IN    std_logic;
        MA_Out                            :   OUT   std_logic;
        Write_Clock                       :   OUT   std_logic;
        Error_rsvd                        :   OUT   std_logic;
        Buffer_Out                        :   OUT   std_logic;
        Bit_Number                        :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        Write_Request                     :   OUT   std_logic
        );
END BiSS_C_Master;


ARCHITECTURE rtl OF BiSS_C_Master IS

  -- Component Declarations
  COMPONENT Bit_Counter_Error_Detector
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          clk_1                           :   IN    std_logic;
          SLO_in                          :   IN    std_logic;
          clk_enable_1                    :   OUT   std_logic;
          count_enable                    :   OUT   std_logic;
          error_rsvd                      :   OUT   std_logic;
          onDigit                         :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          request                         :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Bit_Counter_Error_Detector
    USE ENTITY work.Bit_Counter_Error_Detector(rtl);

  -- Signals
  SIGNAL HDL_Counter_out1                 : std_logic;  -- ufix1
  SIGNAL Clock                            : std_logic;
  SIGNAL Clock_1                          : std_logic;
  SIGNAL clk_enable_1                     : std_logic;
  SIGNAL count_enable                     : std_logic;
  SIGNAL error_rsvd_1                     : std_logic;
  SIGNAL onDigit                          : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL request                          : std_logic;
  SIGNAL Constant1_out1                   : std_logic;
  SIGNAL Clock_2                          : std_logic;
  SIGNAL MA_to_Encoder                    : std_logic;
  SIGNAL Constant2_out1                   : std_logic;

BEGIN
  -- Clock Generator
  -- 
  -- This module supplys a clock to the simulation, and uses that clock to count bits on the SLO In signal and 
  -- detect if the signal's error bit is engaged in addition to passing modified versions of the clock signal through
  -- to drive the other components that run off of the clock

  u_Bit_Counter_Error_Detector : Bit_Counter_Error_Detector
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              clk_1 => Clock_1,
              SLO_in => SLO_In,
              clk_enable_1 => clk_enable_1,
              count_enable => count_enable,
              error_rsvd => error_rsvd_1,
              onDigit => onDigit,  -- uint8
              request => request
              );

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 1
  HDL_Counter_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        HDL_Counter_out1 <= '0';
      ELSIF enb_1_2_0 = '1' THEN
        HDL_Counter_out1 <=  NOT HDL_Counter_out1;
      END IF;
    END IF;
  END PROCESS HDL_Counter_process;


  
  Clock <= '1' WHEN HDL_Counter_out1 /= '0' ELSE
      '0';

  Clock_1 <= Clock;

  Constant1_out1 <= '1';

  Clock_2 <= Clock;

  
  MA_to_Encoder <= Constant1_out1 WHEN clk_enable_1 = '0' ELSE
      Clock_2;

  Constant2_out1 <= '0';

  
  Write_Clock <= Constant2_out1 WHEN count_enable = '0' ELSE
      MA_to_Encoder;

  MA_Out <= MA_to_Encoder;

  Error_rsvd <= error_rsvd_1;

  Buffer_Out <= SLO_In;

  Bit_Number <= onDigit;

  Write_Request <= request;

END rtl;

