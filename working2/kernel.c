void main() {
    char *message = "Hello from C program!";
    volatile char *video_memory = (volatile char*) 0xB8000;
    
    // Print message to video memory
    for (int i = 0; message[i] != '\0'; ++i) {
        video_memory[i * 2] = message[i];
        video_memory[i * 2 + 1] = 0x0F; // White text on black background
    }
    
}
