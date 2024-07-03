#include "print.h"

void print_memmap();


void main() {
    init_screen();
    
    print_memmap();
}

void print_memmap() {
    printstr_col("{{ Hello, Strict Potato ^^ }}\n", light_red, blue);
    printstr("Hey, mmkn nt3rf?");
    printnl();
    
}

