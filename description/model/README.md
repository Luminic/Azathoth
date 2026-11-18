# Components

The design of this processor will be made with the following components:

Instruction Memory

Instruction Decode

ALU

Registers

Memory

## Ports

### Note

All circuit logic will be combinational execpt for writing values

The components listed above will have the following task, inputs, and outpus

Instruction Memory:

- The instruction memory will contain the instructions flashed from the computer

- Inputs: clk, rst, instruction pointer (32), write value (32)

- Outputs: instruction (32)

Instruction Decode:

- The instruction decoder will be responsible for determining the instruction
and setting control signals so the rest of the processor is configured to properly handle the operation

- Inputs: instruction (32)

- Outputs: immediate value (32), register 1 (4), register 2 (4), Control Bits (TBD)

ALU

- This component is dedicated to performing arithmetic operations

- Inputs: value 1 (32), value 2 (32), operation (TBD)

- Outputs: result (32)

Registers

- This component houses 16 general purpose registers

- Inputs: clk, rst, read register 1 (4), read register 2 (4), write register(4), write enable

- Outputs: value 1 (32), value 2 (32)

Memory

- This component holds all the memory and dedicated addresses for IO

- Inputs: clk, rst, read address (TBD), write address (TBD), write value (32)

- Outputs: read value (32)

## Additional components

The following components are not nessesary for the processor but allow it to utilize the hardware it is connected to, in other words, these components are IO controllers. Later a default program will be built to write and execute what the computer sends

UART Communication

Switch and Led IO

Seven Segment Controller
