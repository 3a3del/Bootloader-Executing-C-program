void main() {
    char *message = "Bootloader done";
    volatile char *video_memory = (volatile char*) 0xB8000;

    // Define screen dimensions for VGA text mode (80 columns x 25 rows)
    const int SCREEN_WIDTH = 80;
    const int SCREEN_HEIGHT = 25;
    const int SCREEN_SIZE = SCREEN_WIDTH * SCREEN_HEIGHT;

    // Attribute byte for white text on blue background
    const char attribute_byte = 0x1F; // Foreground: White (0xF), Background: Blue (0x1)

    // Fill the entire screen with spaces (ASCII 0x20) and blue background
    for (int i = 0; i < SCREEN_SIZE; ++i) {
        video_memory[i * 2] = ' ';
        video_memory[i * 2 + 1] = attribute_byte;
    }

    // Print the message over the blue background
    for (int i = 0; message[i] != '\0'; ++i) {
        video_memory[i * 2] = message[i];
        video_memory[i * 2 + 1] = attribute_byte;
    }

    // Halt CPU after printing
    __asm__ __volatile__("cli; hlt");
}

