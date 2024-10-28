# RISC-V Processor Implementation on Nexys A7 Trainer Kit

## Project Overview

This project demonstrates the design and testing of a RISC-V processor, implemented on the Nexys A7 FPGA trainer kit. The processor supports the RV32I base integer instruction set and includes a pipelined architecture with hazard management. Given the constraint of a single-port, byte-addressable memory for both data and instructions, the design achieves optimal performance by issuing instructions every two clock cycles, effectively managing structural hazards.

## Project Objectives

### Instruction Set Compliance

The processor supports the 42 user-level RV32I instructions as specified in the RISC-V Unprivileged Specification, with the following modifications:

- **ECALL**: Interpreted as a halting instruction that stops program execution by preventing the program counter (PC) from updating.
- **EBREAK, PAUSE, FENCE, and FENCE.TSO**: These instructions are implemented as no-ops and do not alter the processor state.

### Pipelining and Hazard Management

The design incorporates a pipelined architecture that manages both data and control hazards:

- **Structural Hazards**: Managed by configuring memory as single-port, byte-addressable, shared between instruction and data memory.
- **Instruction Issue Rate**: Instructions are issued every two clock cycles (CPI = 2) to separate memory accesses and avoid conflicts.

## Technical Implementation

- **Architecture**: RV32I base integer instruction set (32-bit RISC-V)
- **Memory Configuration**: Single-port, byte-addressable memory serving both instruction and data needs
- **Instruction Issue Rate**: CPI maintained at 2 to address single-memory access constraints

## Phased Design and Testing

### Single-Cycle Implementation (Phase 1)
- A functional single-cycle processor executing the full RV32I instruction set.
- Validates correctness for each instruction except `ECALL`, `EBREAK`, `PAUSE`, `FENCE`, and `FENCE.TSO`.

### Pipelined Implementation (Phase 2)
- Transforms the single-cycle design into a pipelined processor, adding hazard detection and resolution mechanisms.
- Enhances performance and ensures functional correctness across all implemented instructions.

## Testing and Validation

The processor is validated with test cases covering each RV32I instruction (excluding `ECALL`, `EBREAK`, `PAUSE`, `FENCE`, and `FENCE.TSO`) to ensure robustness and compliance with functional and performance requirements.

> **Note**: Testing on the Nexys A7 FPGA board is optional but recommended to showcase the processor’s performance and pipelining capabilities in a real-world environment.

## Current Status

As of now, we have achieved a single-cycle datapath block diagram and Verilog description supporting all of the RV32I instructions as described above. Basic test cases covering all supported instructions have also been included. At this stage, two separate memories must be used for instructions and data. 

### Future Plans
We plan to implement the remaining features mentioned above, including:
- Adding support for compressed instructions to effectively support the full RV32IC instruction set, excluding compressed instructions that do not map to supported instructions according to the requirements above.
- Implementing a 2-bit dynamic branch prediction mechanism (and branch target address prediction) to enhance instruction flow and performance.
