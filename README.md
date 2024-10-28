RISC-V Processor Implementation on Nexys A7 Trainer Kit

Project Overview

This project demonstrates the design and testing of a RISC-V processor, implemented on the Nexys A7 FPGA trainer kit. The processor supports the RV32I base integer instruction set and includes a pipelined architecture with hazard management. Given the constraint of a single-port, byte-addressable memory for both data and instructions, the design achieves optimal performance by issuing instructions every two clock cycles, effectively managing structural hazards.

Project Objectives

Instruction Set Compliance
The processor supports the 42 user-level RV32I instructions as specified in the RISC-V Unprivileged Specification, with the following modifications:
ECALL: Interpreted as a halting instruction that stops program execution by preventing the program counter (PC) from updating.
EBREAK, PAUSE, FENCE, and FENCE.TSO: These instructions are implemented as no-ops and do not alter the processor state.
Pipelining and Hazard Management
The design incorporates a pipelined architecture that manages both data and control hazards.
Structural hazards are managed by configuring the memory as single-port, byte-addressable, shared between instruction and data memory.
To avoid memory access conflicts, instructions are issued every two clock cycles (CPI = 2), thus separating memory accesses across cycles.
Technical Implementation

Architecture: RV32I base integer instruction set (32-bit RISC-V).
Memory Configuration: Single-port, byte-addressable memory serving both instruction and data needs.
Instruction Issue Rate: CPI is maintained at 2, addressing single-memory access constraints.
Phased Design and Testing

Single-Cycle Implementation (Phase 1):
Initial functional single-cycle processor that can execute the full RV32I instruction set.
Validates functional correctness for each instruction, except ECALL, EBREAK, PAUSE, FENCE, and FENCE.TSO, as specified.
Pipelined Implementation (Phase 2):
Transforms the single-cycle design into a pipelined processor, adding hazard detection and resolution mechanisms.
Ensures performance enhancement and functional correctness across all implemented instructions.
Testing and Validation

The processor is validated with test cases covering each RV32I instruction (excluding ECALL, EBREAK, PAUSE, FENCE, and FENCE.TSO) to ensure robustness and compliance with the functional and performance requirements.

Note:
Testing on the Nexys A7 FPGA board is optional but recommended to showcase the processor’s performance and pipelining capabilities in a real-world environment.
