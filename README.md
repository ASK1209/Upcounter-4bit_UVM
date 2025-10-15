# 4-Bit Up-Counter Verification Project

## Overview
This project demonstrates the design and verification of a **4-bit up-counter** using **SystemVerilog** and **UVM Methodology**.  This project is ideal for **beginners in digital design verification**, as it covers:

- RTL design of a 4-bit up-counter
- Testbench creation with UVM
- SystemVerilog Assertions (SVA) for functional checking
- Functional coverage for counter values

---

## Table of Contents
- [RTL Module](#rtl-module)
- [Testbench](#testbench)
- [Functional Coverage](#functional-coverage)
- [Simulation](#simulation)

---

## RTL Module
**up_counter.v** implements a simple 4-bit up-counter:

- **Inputs:** `clk`, `rst_n` (active-low reset)
- **Output:** `count[3:0]`
- Counter increments on rising edge of `clk` when `en=1`.
- Counter resets to 0 on `rst_n=0`.

---

## Functional Coverage
**scoreboard.sv**:

- Defines bins for **counter ranges**: zero, mid, and max
- Captures coverage to ensure **all counter values are tested**

---

## Simulation
To run simulation using any SystemVerilog simulator (VCS, Questa, etc.):
vsim -view "wavefile_name"

