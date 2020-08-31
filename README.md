# BiSS C Splitter Overview

### Overview:

This BiSS C splitter is designed to deliver location requests from either a data logger or a connected motor to an encoder, and serve the position information back to the device that requested it. It is to be implemented on an an Xilinx Artix-7 FPGA, although will be compatible with any Xilinx product with minor modifications in Vivado, and with any other FPGA with additional modifications. 

### General Operation:

Include picture of BiSS C waveform

![BiSS-C_Sample_Waveform](C:\Users\Austin\Downloads\BiSS-C_Sample_Waveform.jpg)



![MainSplitterCapture](C:\Users\Austin\Pictures\MainSplitterCapture.PNG)



## I/O

### 	Inputs:

* SLO In - Accepts serial position data from the encoder as a Boolean.

* DAQ Trig - Accepts a Boolean high when the DAQ requests to record data (could also take a clock signal if modified to have the same structure as the Motor BiSS C Slave)

* Motor MA- Accepts a Boolean clock signal, in line with the MA signal shown above, when the motor is requesting data.

  ### Outputs:

* Encoder MA - Outputs a Boolean clock signal at 10mhz to constantly drive the encoder.
* DAQ Out - Outputs stored serial data to the DAQ
* Motor SLO - Ouputs stored serial data to the motor, at the frequency specified by Motor MA

## BiSS C Master:

### 	Overview:

​	The first purpose of this block is to listen to the Encoder SLO input. When

 ![BiSS C Master Block](C:\Users\Austin\Pictures\BiSS C Documentation Snips\BiSS C Master Block.PNG)

Text filler



![Counter Module](C:\Users\Austin\Pictures\BiSS C Documentation Snips\Counter Module.PNG)

### 	Variables:

### 	I/0:

##### 		Inputs

* SLO In

* Clock In

  ##### Outputs

* MA Out
* Write Clock
* Error
* Buffer Out
* Bit Number
* Write Request

## Buffer

### 	Overview:

### 	Variables:

* bankToggle1 and bankToggle2
* onDigit_Read
* read_keeper
* write_keeper

### 	I/0:

##### 		Inputs

* DAQ Read Request

* DAQ Read Clock

* Write Clock

* Error

* Buffer Out

* Bit Number

* Write Request

* Motor Read Clock

* Motor Read Request

  ##### Outputs

* DAQ Read Out
* DAQ Read Done
* Motor Read Out
* Motor Read Done

## DAQ and Motor BiSS C Slaves

### Overview: 

These two modules accomplish the same output goal with two different types of inputs. The e

### Motor Variables:

### I/0:

![](C:\Users\Austin\Pictures\BiSS C Documentation Snips\DAQ BiSS C Slave.PNG)