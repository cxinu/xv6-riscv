// #define UART_BASE 0x10000000
// #define UART_THR ((volatile unsigned char*)(UART_BASE + 0))
// #define UART_LSR ((volatile unsigned char*)(UART_BASE + 5))
//
// void uart_print(const char *str){
//
// }


// Allocate a 4096-byte stack per CPU core (allowing up to 4 cores here)
__attribute__((aligned(16))) char stack0[4096 * 4];

void main() {
    // We are officially executing C code inside our own custom kernel space.
    // In actual xv6, you would initialize console, page tables, and traps here.
    while(1) {
        // Loop infinitely to keep the CPU alive
    }
}
