# Simple Bootloader Project

This project demonstrates a simple bootloader for x86 systems written in assembly and C. The bootloader initializes protected mode, loads a kernel from disk, and then executes it. The kernel displays a message on the screen and halts the CPU.

## Project Structure

- **`disk.asm`**: Assembly code for loading sectors from the disk.
- **`gdt.asm`**: Defines the Global Descriptor Table (GDT) for protected mode setup.
- **`kernel-entry.asm`**: Entry point for the kernel, calling the main function written in C.
- **`mbr.asm`**: Master Boot Record (MBR) code that initializes the stack, loads the kernel, and switches to 32-bit mode.
- **`switch-to-32bit.asm`**: Assembly code to switch from real mode to protected mode.
- **`kernel.c`**: C program that runs as the kernel, displaying a message on the screen.

## Building and Running the Bootloader

To simplify the build and run process, a `run.sh` script is provided. This script assembles, compiles, links, and runs the bootloader and kernel.

### Running the Script
1. **Naviagte to the Directory:**
   ```bash
    cd protected_mode
    ```

2. **Make the Script Executable:**

    ```bash
    chmod +x run.sh
    ```

3. **Execute the Script:**

    ```bash
    ./run.sh
    ```

The `run.sh` script performs the following steps:

1. **Assemble the Assembly Files:**
2. **Compile the C Code:**
3. **Link the Kernel:**
4. **Combine Bootloader and Kernel:**
5. **Run the Bootloader with QEMU:**

## Description

- **Bootloader (`mbr.asm`)**: Sets up the stack, loads the kernel from disk, switches to 32-bit protected mode, and transfers control to the kernel.
- **Kernel (`kernel.c`)**: A simple C program that writes "Bootloader done" to the screen using VGA text mode and halts the CPU.
- **GDT Setup (`gdt.asm` and `switch-to-32bit.asm`)**: Configures the Global Descriptor Table and enables protected mode.
- **Disk Loading (`disk.asm`)**: Handles the loading of the kernel from disk sectors.

## Notes

- The provided code is intended for educational purposes and demonstrates basic bootloader and kernel operations.
- Ensure that you have the necessary tools (NASM, GCC, LD, QEMU) installed on your system.
- Adjust memory addresses and segment sizes in the code as needed for different configurations.
