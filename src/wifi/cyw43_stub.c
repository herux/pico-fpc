/* Minimal CYW43 stubs for Pico W LED control from Free Pascal
   
   This provides just the LED GPIO functionality without full WiFi support.
   For a simpler integration with Free Pascal.
*/

#include <stdint.h>
#include <stdbool.h>

/* ================================================================
   FPC Runtime Support
   ================================================================ */

/* FPC halt procedure - required by system unit */
void _haltproc(void) __attribute__((noreturn));
void _haltproc(void) {
    while (1) {
        /* Infinite loop - MCU halted */
        __asm__ volatile("wfi");  /* Wait for interrupt (low power) */
    }
}

/* ================================================================
   CYW43 Stubs  
   ================================================================ */

/* Pico W LED is on CYW43 GPIO 0 */
#define CYW43_WL_GPIO_LED_PIN 0

/* SPI communication with CYW43 chip */
/* These addresses are from the RP2040 datasheet */
#define SIO_BASE 0xD0000000
#define IO_BANK0_BASE 0x40014000

/* GPIO registers */
typedef struct {
    volatile uint32_t GPIO_OUT;
    volatile uint32_t GPIO_OUT_SET;
    volatile uint32_t GPIO_OUT_CLR;
    volatile uint32_t GPIO_OUT_XOR;
    volatile uint32_t GPIO_OE;
    volatile uint32_t GPIO_OE_SET;
    volatile uint32_t GPIO_OE_CLR;
    volatile uint32_t GPIO_OE_XOR;
} sio_hw_t;

#define sio_hw ((sio_hw_t*)SIO_BASE)

/* Pico W uses GPIO23 for CYW43 power control, GPIO24 for SPI data, GPIO25 for SPI clock, GPIO29 for CS */
#define CYW43_PIN_WL_REG_ON 23
#define CYW43_PIN_WL_DATA_OUT 24
#define CYW43_PIN_WL_DATA_IN  24
#define CYW43_PIN_WL_CLOCK    29

/* Simple globals for state */
static bool cyw43_initialized = false;
static bool cyw43_led_state = false;

/* Stub implementation - just track state locally */
int cyw43_arch_init(void) {
    /* In a real implementation, this would initialize SPI communication
       with the CYW43 chip. For now, we just return success. */
    cyw43_initialized = true;
    return 0;
}

int cyw43_arch_init_with_country(uint32_t country) {
    (void)country;
    return cyw43_arch_init();
}

void cyw43_arch_deinit(void) {
    cyw43_initialized = false;
}

void cyw43_arch_enable_sta_mode(void) {
    /* Stub */
}

void cyw43_arch_disable_sta_mode(void) {
    /* Stub */
}

void cyw43_arch_enable_ap_mode(const char* ssid, const char* password, uint32_t auth) {
    (void)ssid;
    (void)password;
    (void)auth;
    /* Stub */
}

void cyw43_arch_disable_ap_mode(void) {
    /* Stub */
}

/* LED control - this is what we mainly need */
void cyw43_arch_gpio_put(uint32_t gpio, bool value) {
    if (gpio == CYW43_WL_GPIO_LED_PIN) {
        cyw43_led_state = value;
        /* 
         * Real Pico W LED control requires SPI communication with CYW43.
         * For testing without the actual chip, we could toggle an RP2040 GPIO.
         * For now, just store the state.
         */
    }
}

bool cyw43_arch_gpio_get(uint32_t gpio) {
    if (gpio == CYW43_WL_GPIO_LED_PIN) {
        return cyw43_led_state;
    }
    return false;
}

/* Polling - stub */
void cyw43_arch_poll(void) {
    /* In a real implementation, this processes WiFi events */
}

void cyw43_arch_wait_for_work_until(int64_t until_time) {
    (void)until_time;
    /* Stub */
}

/* WiFi connection stubs - return errors since WiFi isn't implemented */
int cyw43_arch_wifi_connect_timeout_ms(const char* ssid, const char* password, 
                                        uint32_t auth, uint32_t timeout_ms) {
    (void)ssid;
    (void)password;
    (void)auth;
    (void)timeout_ms;
    return -1;  /* Not implemented */
}

int cyw43_arch_wifi_connect_async(const char* ssid, const char* password, uint32_t auth) {
    (void)ssid;
    (void)password;
    (void)auth;
    return -1;  /* Not implemented */
}

int cyw43_wifi_link_status(int itf) {
    (void)itf;
    return 0;  /* CYW43_LINK_DOWN */
}

bool cyw43_arch_wifi_is_connected(void) {
    return false;
}
