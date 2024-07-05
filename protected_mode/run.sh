
# Define variables for the target and dependencies
KERNEL_BIN="kernel.bin"
KERNEL_ENTRY_O="kernel-entry.o"
KERNEL_O="kernel.o"
MBR_BIN="mbr.bin"
OS_IMAGE_BIN="os-image.bin"

# Function to build kernel.bin
build_kernel_bin() {
    ld -m elf_i386 -T linker.ld -o "$KERNEL_BIN" "$KERNEL_ENTRY_O" "$KERNEL_O"
}

# Function to build kernel-entry.o
build_kernel_entry_o() {
    nasm kernel-entry.asm -f elf -o "$KERNEL_ENTRY_O"
}

# Function to build kernel.o
build_kernel_o() {
    gcc -fno-pie -m32 -ffreestanding -c kernel.c -o "$KERNEL_O"
}

# Function to build mbr.bin
build_mbr_bin() {
    nasm mbr.asm -f bin -o "$MBR_BIN"
}

# Function to build os-image.bin
build_os_image_bin() {
    cat "$MBR_BIN" "$KERNEL_BIN" > "$OS_IMAGE_BIN"
}

# Function to run the OS image
run_os_image() {
    qemu-system-i386 -fda "$OS_IMAGE_BIN"
}

# Function to clean build artifacts
clean() {
    rm -f *.bin *.o *.dis
}

# Main function to handle targets
main() {
    if [ "$1" = "clean" ]; then
        clean
    else
        build_kernel_entry_o
        build_kernel_o
        build_kernel_bin
        build_mbr_bin
        build_os_image_bin
        run_os_image
    fi
}

# Call the main function with the first argument passed to the script
main "$1"

