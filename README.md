# Binary Bomb Lab: Disassembly, Debugging, and Reverse Engineering

## Project Overview

This repository contains my comprehensive analysis and solutions for a Binary Bomb Lab, a classic cybersecurity exercise designed to hone **reverse engineering, assembly language analysis, and debugging skills**. The "binary bomb" is an executable program consisting of several "phases." Each phase requires a specific, secret input string to avoid "exploding" (terminating prematurely). The challenge lies in disassembling and debugging the binary to uncover the logic and determine the correct input for each phase without access to the source code.

This project demonstrates my ability to:
* Perform **low-level code analysis** (x86-64 assembly).
* Utilize **dynamic analysis** techniques with a debugger (GDB).
* Identify and understand various **program constructs** (loops, conditional jumps, switch statements, recursive functions, data structures).
* Systematically **problem-solve complex technical challenges**.
* Document technical findings clearly and concisely.

My background in Computer Science and Mathematics, coupled with [mention if you want to broadly allude to your classified experience, e.g., "prior experience in secure environments tackling complex analytical problems"], provides a strong foundation for this type of detailed security analysis.

## Features & Skills Demonstrated

Through this project, I showcase proficiency in:

* **Reverse Engineering:** Static and dynamic analysis of compiled binaries.
* **x86-64 Assembly Language:** Reading, understanding, and interpreting common assembly instructions and patterns.
* **Debugging with GDB:** Setting breakpoints, inspecting registers, memory, and stack; stepping through code; analyzing function calls.
* **Control Flow Analysis:** Mapping execution paths, identifying conditional logic and loops.
* **Data Structure Identification:** Recognizing string manipulations, arrays, and linked list traversals.
* **Function Analysis:** Deconstructing complex and recursive functions (`func4` analysis).
* **Vulnerability Insight:** Understanding how precise input validation is critical and how deviations can lead to program termination (or, in real-world scenarios, vulnerabilities).
* **Technical Documentation:** Clearly explaining complex technical concepts and solutions.

## How to "Defuse" This Bomb (Locally)

To explore or verify the solutions, you would typically need the `bomb` executable itself. This repository provides the analysis; the binary is usually provided by an academic course or can be built from similar labs found online.

Assuming you have a `bomb` executable and `gdb` installed:

1.  **Place the `bomb` executable** in a working directory.
2.  **Navigate to a phase directory** (e.g., `phases/phase1/`).
3.  **Launch GDB:** `gdb ./bomb`
4.  **Set a breakpoint** at the start of the phase you're interested in (e.g., `b phase_1`) or at the `explode_bomb` function (`b explode_bomb`).
5.  **Run the program:** `run`
6.  **Provide the correct input** when prompted, as detailed in the `solution.txt` within each phase's directory or in the main report.
7.  **Step through code** using `ni` (next instruction) or `si` (step into instruction) and **inspect memory/registers** using `x` and `p $reg_name` commands as outlined in the report.

## Project Structure

This repository is organized as follows:
