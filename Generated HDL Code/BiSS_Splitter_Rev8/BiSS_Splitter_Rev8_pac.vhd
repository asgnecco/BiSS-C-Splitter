-- -------------------------------------------------------------
-- 
-- File Name: Generated HDL Code\BiSS_Splitter_Rev8\BiSS_Splitter_Rev8_pac.vhd
-- Created: 2020-09-09 16:25:01
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE BiSS_Splitter_Rev8_pac IS
  TYPE T_state_type_is_Bit_Counter_Error_Detector IS (IN_Ack, IN_Read, IN_Ready, IN_Start, IN_Zero);
  TYPE T_state_type_is_Chart IS (IN_DAQRead, IN_DAQReadandWrite, IN_Initialization, IN_MotorRead, IN_MotorReadandWrite, IN_NormalOperation, IN_SwitchBank, IN_WriteOnly);
  TYPE T_state_type_is_Chart1 IS (IN_Off, IN_On);
END BiSS_Splitter_Rev8_pac;

