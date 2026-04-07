/* FPC Runtime stubs for bare-metal RP2040
   These bypass the FPC runtime initialization that hangs on bare-metal */

void __wrap_fpc_initializeunits(void) {
    // Do nothing - skip FPC unit initialization
}

void __wrap_fpc_do_exit(void) {
    // Infinite loop on exit
    while(1);
}

void fpc_libc_exit(int code) {
    while(1);
}

/* Memory functions that FPC might need */
void* memset(void* s, int c, unsigned long n) {
    unsigned char* p = (unsigned char*)s;
    while(n--) *p++ = (unsigned char)c;
    return s;
}

void* memcpy(void* dest, const void* src, unsigned long n) {
    unsigned char* d = (unsigned char*)dest;
    const unsigned char* s = (const unsigned char*)src;
    while(n--) *d++ = *s++;
    return dest;
}

void* memmove(void* dest, const void* src, unsigned long n) {
    unsigned char* d = (unsigned char*)dest;
    const unsigned char* s = (const unsigned char*)src;
    if (d < s) {
        while(n--) *d++ = *s++;
    } else {
        d += n;
        s += n;
        while(n--) *--d = *--s;
    }
    return dest;
}
