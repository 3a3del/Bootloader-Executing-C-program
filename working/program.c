#include "print.h"
#include "memory.h"

//TODO: the vidchar get/set's are not working u skid
//TODO: printnl() does not scroll
//TODO: colors are messed up for a moment when scrolling

void print_memmap();
void test_prints();
void test_memory();

void main() {
    init_screen();
    
    print_memmap();
}

void print_memmap() {
    printstr_col("{{ Hello, Strict Potato ^^ }}\n", light_red, blue);
    printstr("Hey, mmkn nt3rf?");
    printnl();
    
}

void print_tests() {
    printstr("test10\n");
    printstr_col("{{ testing prints }}\n", light_red, blue);
    printhex8(0xFEEDFACECAFEBEEF);
    printnl();
    printhex4(0xDEADBEEF);
    printnl();
    printhex2(0x1337);
    printnl();
    printhex1(0xAB);
    printnl();
}

void test_memory() {
    printstr_col("{{ Mariam }}\n", light_red, blue);
    const int64_t* check_amount = (int64_t*)0x40000000;
    volatile long garbage;
    for(int64_t* c = 0; c < check_amount; c++ /*memed*/)
        garbage = *c;
    printhex8((intptr_t)check_amount);
    printstr(" Mariam2 :3\n");
}