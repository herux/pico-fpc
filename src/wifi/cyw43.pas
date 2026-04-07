{
  CYW43 WiFi Driver Bindings for Free Pascal
  
  This unit provides Pascal bindings to the CYW43 WiFi driver
  from the Pico SDK. The actual implementation is in libpico_wifi.a
  
  Usage:
    uses cyw43;
    
    begin
      if cyw43_arch_init = 0 then
        WriteLn('WiFi initialized');
    end.
}
unit cyw43;

{$mode objfpc}
{$H+}

{$linklib cyw43_stub}

interface

{ ============================================================
  Constants
  ============================================================ }

const
  // WiFi authentication modes
  CYW43_AUTH_OPEN         = 0;
  CYW43_AUTH_WPA_TKIP_PSK = $00200002;
  CYW43_AUTH_WPA2_AES_PSK = $00400004;
  CYW43_AUTH_WPA2_MIXED_PSK = $00400006;
  
  // Country codes (subset)
  CYW43_COUNTRY_INDONESIA = $4944;  // 'ID'
  CYW43_COUNTRY_USA       = $5553;  // 'US'
  CYW43_COUNTRY_UK        = $4742;  // 'GB'
  
  // Link status
  CYW43_LINK_DOWN    = 0;
  CYW43_LINK_JOIN    = 1;
  CYW43_LINK_NOIP    = 2;
  CYW43_LINK_UP      = 3;
  CYW43_LINK_FAIL    = -1;
  CYW43_LINK_NONET   = -2;
  CYW43_LINK_BADAUTH = -3;

{ ============================================================
  Type Definitions
  ============================================================ }

type
  // IP address (4 bytes)
  TIPAddr = record
    case Boolean of
      True:  (addr: LongWord);
      False: (b: array[0..3] of Byte);
  end;
  PIPAddr = ^TIPAddr;

{ ============================================================
  Core Functions - from cyw43_arch.h
  ============================================================ }

// Initialize the CYW43 WiFi driver
// Returns: 0 on success, non-zero on failure
function cyw43_arch_init: Integer; cdecl; external;

// Initialize with specific country code
function cyw43_arch_init_with_country(country: LongWord): Integer; cdecl; external;

// Deinitialize the CYW43 driver
procedure cyw43_arch_deinit; cdecl; external;

// Enable station mode (connect to access point)
procedure cyw43_arch_enable_sta_mode; cdecl; external;

// Enable access point mode (create hotspot)
procedure cyw43_arch_enable_ap_mode(ssid: PChar; password: PChar; auth: LongWord); cdecl; external;

// Disable WiFi (both STA and AP)
procedure cyw43_arch_disable_sta_mode; cdecl; external;
procedure cyw43_arch_disable_ap_mode; cdecl; external;

{ ============================================================
  Connection Functions
  ============================================================ }

// Connect to WiFi network (blocking, with timeout in ms)
// Returns: 0 on success
function cyw43_arch_wifi_connect_timeout_ms(
  ssid: PChar;
  password: PChar;
  auth: LongWord;
  timeout_ms: LongWord
): Integer; cdecl; external;

// Connect to WiFi network (non-blocking, starts connection)
// Returns: 0 if connection started
function cyw43_arch_wifi_connect_async(
  ssid: PChar;
  password: PChar;
  auth: LongWord
): Integer; cdecl; external;

// Get WiFi link status
// Returns: CYW43_LINK_* constant
function cyw43_wifi_link_status(itf: Integer): Integer; cdecl; external;

// Check if connected
function cyw43_arch_wifi_is_connected: Boolean; cdecl; external;

{ ============================================================
  GPIO Functions (for onboard LED on Pico W)
  ============================================================ }

// On Pico W, the LED is connected to CYW43 GPIO, not RP2040 GPIO
// GPIO 0 = LED
procedure cyw43_arch_gpio_put(gpio: LongWord; value: Boolean); cdecl; external;
function cyw43_arch_gpio_get(gpio: LongWord): Boolean; cdecl; external;

{ ============================================================
  Polling (for non-blocking operations)
  ============================================================ }

// Must be called regularly when using non-blocking functions
procedure cyw43_arch_poll; cdecl; external;

// Wait for work with timeout
procedure cyw43_arch_wait_for_work_until(until_time: Int64); cdecl; external;

implementation

// No implementation needed - all functions are external

end.
