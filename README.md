# BiSS C Splitter Overview

### Overview:

This BiSS C splitter is designed to deliver location requests from either a data logger or a connected motor to an encoder, and serve the position information back to the device that requested it. It is to be implemented on an an Xilinx Artix-7 FPGA, although will be compatible with any Xilinx product with minor modifications in Vivado, and with any other FPGA with additional modifications. 



## I/O

### 	Inputs:

* SLO In- Comes from encoder, and delivers...

* DAQ Trig-

* Motor MA- 

  ### Outputs:

* Encoder MA-
* DAQ Out
* Motor SLO

## BiSS C Master:

### 	Overview:

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

* 

## DAQ BiSS C Slave

### Overview:

### Variables:

### I/0:

## Motor BiSS C Slave

### Overview:

### Variables:

### I/0: