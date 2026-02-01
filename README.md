# CUSTOM-PROCESSOR-WITH-MUL
# Custom Single-Cycle Processor with Multi-Cycle Multiplication

## 📌 Project Overview
This project implements a **custom processor** from scratch as part of a **Computer System Architecture (CSA)** course.  
It supports **R-type, I-type, branch, load/store instructions** in **single-cycle**, plus a **multi-cycle multiplication instruction**.

---

## 🧠 Key Features
- Single-cycle execution for standard instructions  
- Multi-cycle multiplication instruction  
- Supports R-type, I-type, branch, load/store  
- Modular and readable Verilog/SystemVerilog design  
- Simulation-ready and FPGA-friendly  

---

## 🧩 Supported Instructions

### 🔹 R-Type Instructions
- Arithmetic operations: ADD, SUB, AND, OR, etc.  
- Register-to-register execution  

### 🔹 I-Type Instructions
- Immediate arithmetic/logical operations  
- Address calculation for memory access  

### 🔹 Branch Instructions
- Conditional branch instructions  
- PC update logic within the same cycle  

### 🔹 Load Word (LW)
- Memory read operation  
- Writes data to register  

### 🔹 Store Word (SW)
- Memory write operation  
- Single-cycle execution  

### 🔹 Multi-Cycle Multiplication
- Complex operation implemented using multiple cycles  
- Internal control logic and state machine  

---

## 🏗️ Processor Architecture
- Program Counter (PC)  
- Instruction Memory  
- Register File  
- ALU  
- Data Memory  
- Control Unit  
- Multiplier Control Logic  

---

## 🛠️ Technologies Used
- SystemVerilog / Verilog  
- Vivado (simulation and synthesis)  
- GitHub for version control  

---

## 📁 Project Structure

