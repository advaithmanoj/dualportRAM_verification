# Dual-Port RAM Verification using SystemVerilog
A SystemVerilog-based verification project for a **Dual-Port RAM** using a modular, self-checking verification environment.

The project verifies independent read and write operations through dedicated drivers and monitors, with a reference model and scoreboard used to automatically compare expected and actual behavior.

## 🔗 EDA Playground

[Run my complete project on EDA Playground](https://edaplayground.com/x/FCMz)

##  Project Overview
A Dual-Port RAM allows memory to be accessed through two independent ports. 
This project focuses on verifying the read and write functionality of the RAM using a structured SystemVerilog verification environment.

The verification environment generates transactions, drives them to the DUT, monitors the DUT activity, predicts expected results using a reference model, and compares them against the observed output using a scoreboard.

### Testbench Architecture
<img width="800" alt="dualportTB" src="https://github.com/user-attachments/assets/90ecf5db-e43c-41d5-889a-77a6c601f64e" />


