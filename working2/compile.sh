mkdir -p bin

# compile the bootloader
nasm -f bin bootloader.asm -o bin/bootloader.bin 

# compile program and link it
nasm centry.asm -f elf64 -o bin/centry.o 
gcc -ffreestanding -c kernel.c -o bin/kernel.o -march=x86-64
ld -o bin/kernel.bin -T link.ld --oformat binary bin/centry.o bin/kernel.o
cat bin/bootloader.bin bin/kernel.bin > bin/image
