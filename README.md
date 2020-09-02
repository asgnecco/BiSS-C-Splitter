BiSS C Splitter Overview

### Overview:

This BiSS C splitter is designed to deliver location requests from either a data logger or a connected motor to an encoder, and serve the position information back to the device that requested it. It is to be implemented on an an Xilinx Artix-7 FPGA, although will be compatible with any Xilinx product with minor modifications in Vivado, and with any other FPGA with additional modifications. 

### General Operation:

Include picture of BiSS C waveform

![](https://github.com/asgnecco/BiSS-C-Splitter/blob/working/BiSS%20C%20Documentation%20Snips/BiSS-C_Sample_Waveform.jpg?raw=true)



![](https://github.com/asgnecco/BiSS-C-Splitter/blob/working/BiSS%20C%20Documentation%20Snips/MainSplitterCapture.PNG?raw=true)



## I/O

##### 	   	Inputs:

* SLO In - Accepts serial position data from the encoder as a Boolean.

* DAQ Trig - Accepts a Boolean high when the DAQ requests to record data (could also take a clock signal if modified to have the same structure as the Motor BiSS C Slave)

* Motor MA- Accepts a Boolean clock signal, in line with the MA signal shown above, when the motor is requesting data.

  ##### Outputs:

* Encoder MA - Outputs a Boolean clock signal at 10mhz to constantly drive the encoder.

* DAQ Out - Outputs stored serial data to the DAQ

* Motor SLO - Ouputs stored serial data to the motor, at the frequency specified by Motor MA

## BiSS C Master:

### 	Overview:

​	The first purpose of the BiSS C Master block, is to provide the clocking information for the rest of the diagram and to analyze the signal from 



The Simulink logic diagram is shown here:

![BiSS C Master Block](C:\Users\Austin\Pictures\BiSS C Documentation Snips\BiSS C Master Block.PNG)

The Bit Counter & Error Detector state diagram is shown here:



![Counter Module](C:\Users\Austin\Pictures\BiSS C Documentation Snips\Counter Module.PNG)

### 	Variables:

### 	I/0:

##### 		Inputs

* SLO In - Raw data in from the encoder

* Clock In - Clock signal from the FPGA

  ##### Outputs

* MA Out - A copy of the FPGA clock that can be turned on or off by the bit counter module, in order to drive the encoder.
* Write Clock - Another copy of the FPGA clock turned on and off at slightly different times, to drive the buffer that records the encoder's data
* Error - Is triggered high when the Bit Counter module detects an error in the response, so that the buffer does not write corrupt data or switch banks
* Buffer Out - Data parsed from the encoder's response to be recorded on the buffer
* Bit Number - The current bit that the encoder is sending, to be recorded on the buffer
* Write Request - Tells the buffer module that it should begin writing data

## Buffer

### 	Overview:

### 	Variables:

* bankToggle1 and bankToggle2 - Switch back and fourth to determine which bank is read to and written from
* onDigit_Read - Keeps track of the digit being written to
* read_keeper - Is used to ensure that each read is only performed once
* write_keeper - Is used to ensure that each write is only performed once

### 	I/0:

##### 		Inputs

* DAQ Read Request - Sent from the DAQ BiSS C Slave module when there is a request from the DAQ to read data.

* DAQ Read Clock - Provides the clocking at which to read the data for the DAQ

* Write Clock - Provides the clocking at which to write data to the buffer

* Error - Is set to high if there is an error detected, so that the buffers do not switch, and bad data is disregarded.

* Buffer Out - The stream of data coming out of the buffer to be sent to the DAQ or Motor

* Bit Number - The number of the bit that is currently being fed to the buffer

* Write Request - Lets the buffer know that there is data ready to be written

* Motor Read Clock - Provides the clocking at which to read the data for the motor

* Motor Read Request - Sent from the Motor BiSS C Slave module when there is a request from the motor to read data.

  ##### Outputs

* DAQ Read Out - Read data to be sent to the DAQ
* DAQ Read Done - Tells the DAQ BiSS C Slave module that data is done being read
* Motor Read Out- Tells the Motor BiSS C Slave module that data is done being read
* Motor Read Done - Read data to be sent to the motor

## DAQ and Motor BiSS C Slaves

### Overview: 

These two modules are essentially the same, although they do have slightly different names to some of their inputs and outputs. The state diagram in the middle acts in the same manner as a SR Flip-flop, in that the output state can be toggled on by a high signal on MA_in, and can only be turned off by a high signal on the reset pin. The delay block is necessary in order to prevent logic loops.



### I/0:

##### Inputs

* Buffer In - The data being sent into the Motor and DAQ modules to pass through to the desired device
* Trig/MA In - Designation depends on whether it is in the Motor or DAQ module. Provides the clocking for data readback
* DAQ/Motor Read Done - Designation depends on whether it is in the Motor or DAQ module. Is set high when data readback is completed

##### Outputs

* Data Log/SLO Out - Data out to the corresponding device
* 



![](C:\Users\Austin\Pictures\BiSS C Documentation Snips\DAQ BiSS C Slave.PNG)

## Instructions to Run Simulation

Many of the setup requirements are already housed within the MATLAB simulation file, but there are some things that still need to be done manually. Besides the simulation file, you will also need to download the "Full Splitter Test" MATLAB document. This contains the raw data for the inputs of this splitter, to run a simulation off of. The signals can be edited by the user to test different scenarios. 

Once this file is attained, the "Connect Inputs" wizard will need to be used, from under the simulation tab on the BiSS C Splitter Simulink model. From there, the "Full Splitter Test" document can be opened. Once it has been opened, use the green play button to map to inputs, and then use the "Mark for Simulation" button to run those signals on the next test. From there, you may run the simulation through Simulink and use the Data Inspector to view the results. 

## Modifications to HDL Code