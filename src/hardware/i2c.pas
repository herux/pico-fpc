{
  Minimal I2C Unit for RP2040

  Based on Raspberry Pi Pico SDK - hardware/i2c
  Copyright (c) 2020 Raspberry Pi (Trading) Ltd.
  SPDX-License-Identifier: BSD-3-Clause

  Converted to Free Pascal
}
unit i2c;

{$mode objfpc}
{$H+}

interface

uses
  rp2040, gpio, resets, clocks;

type
  TI2C_HW = record
    con: LongWord;                { 0x00 }
    tar: LongWord;                { 0x04 }
    sar: LongWord;                { 0x08 }
    _pad0: LongWord;              { 0x0C }
    data_cmd: LongWord;           { 0x10 }
    ss_scl_hcnt: LongWord;        { 0x14 }
    ss_scl_lcnt: LongWord;        { 0x18 }
    fs_scl_hcnt: LongWord;        { 0x1C }
    fs_scl_lcnt: LongWord;        { 0x20 }
    _pad1: array[0..1] of LongWord; { 0x24..0x28 }
    intr_stat: LongWord;          { 0x2C }
    intr_mask: LongWord;          { 0x30 }
    raw_intr_stat: LongWord;      { 0x34 }
    rx_tl: LongWord;              { 0x38 }
    tx_tl: LongWord;              { 0x3C }
    clr_intr: LongWord;           { 0x40 }
    clr_rx_under: LongWord;       { 0x44 }
    clr_rx_over: LongWord;        { 0x48 }
    clr_tx_over: LongWord;        { 0x4C }
    clr_rd_req: LongWord;         { 0x50 }
    clr_tx_abrt: LongWord;        { 0x54 }
    clr_rx_done: LongWord;        { 0x58 }
    clr_activity: LongWord;       { 0x5C }
    clr_stop_det: LongWord;       { 0x60 }
    clr_start_det: LongWord;      { 0x64 }
    clr_gen_call: LongWord;       { 0x68 }
    enable: LongWord;             { 0x6C }
    status: LongWord;             { 0x70 }
    txflr: LongWord;              { 0x74 }
    rxflr: LongWord;              { 0x78 }
    sda_hold: LongWord;           { 0x7C }
    tx_abrt_source: LongWord;     { 0x80 }
    slv_data_nack_only: LongWord; { 0x84 }
    dma_cr: LongWord;             { 0x88 }
    dma_tdlr: LongWord;           { 0x8C }
    dma_rdlr: LongWord;           { 0x90 }
    sda_setup: LongWord;          { 0x94 }
    ack_general_call: LongWord;   { 0x98 }
    enable_status: LongWord;      { 0x9C }
    fs_spklen: LongWord;          { 0xA0 }
    _pad2: LongWord;              { 0xA4 }
    clr_restart_det: LongWord;    { 0xA8 }
  end;
  PI2C_HW = ^TI2C_HW;

var
  i2c0_hw: PI2C_HW = PI2C_HW(I2C0_BASE);
  i2c1_hw: PI2C_HW = PI2C_HW(I2C1_BASE);

function i2c_init(i2c: PI2C_HW; baudrate: LongWord): LongWord;
procedure i2c_deinit(i2c: PI2C_HW);
function i2c_set_baudrate(i2c: PI2C_HW; baudrate: LongWord): LongWord;

function i2c_write_blocking(i2c: PI2C_HW; addr: Byte; src: PByte; len: LongWord; nostop: Boolean): LongInt;
function i2c_read_blocking(i2c: PI2C_HW; addr: Byte; dst: PByte; len: LongWord; nostop: Boolean): LongInt;
function i2c_get_last_abort_reason: LongWord;

procedure i2c_set_pin(i2c: PI2C_HW; sda_pin, scl_pin: LongWord);

implementation

var
  g_last_abort_reason: LongWord = 0;
  g_i2c_dummy_read: LongWord = 0;

procedure i2c_reg_write_masked(reg: PLongWord; values, mask: LongWord); inline;
begin
  reg^ := (reg^ and not mask) or (values and mask);
end;

const
  I2C_IC_CON_MASTER_MODE_BITS    = $00000001;
  I2C_IC_CON_SPEED_BITS          = $00000006;
  I2C_IC_CON_SPEED_FAST_BITS     = $00000004; { speed=2 at bits [2:1] }
  I2C_IC_CON_SPEED_STD_BITS      = $00000002; { speed=1 at bits [2:1] }
  I2C_IC_CON_IC_RESTART_EN_BITS  = $00000020;
  I2C_IC_CON_IC_SLAVE_DISABLE_BITS = $00000040;
  I2C_IC_CON_TX_EMPTY_CTRL_BITS  = $00000100;

  I2C_IC_DMA_CR_RDMAE_BITS       = $00000001;
  I2C_IC_DMA_CR_TDMAE_BITS       = $00000002;

  I2C_IC_DATA_CMD_DAT_BITS       = $000000FF;
  I2C_IC_DATA_CMD_CMD_BITS       = $00000100; { 1=read, 0=write }
  I2C_IC_DATA_CMD_STOP_BITS      = $00000200;
  I2C_IC_DATA_CMD_RESTART_BITS   = $00000400;

  I2C_IC_RAW_INTR_STAT_TX_ABRT_BITS = $00000040;
  I2C_IC_RAW_INTR_STAT_TX_EMPTY_BITS = $00000010;
  I2C_IC_RAW_INTR_STAT_STOP_DET_BITS = $00000200;

  I2C_IC_STATUS_TFNF_BITS        = $00000002;
  I2C_IC_STATUS_RFNE_BITS        = $00000008;
  I2C_IC_STATUS_MST_ACTIVITY_BITS = $00000020;

  I2C_TRANSFER_TIMEOUT = 1000000;

function i2c_get_index(i2c: PI2C_HW): LongWord;
begin
  if i2c = i2c0_hw then
    Result := 0
  else
    Result := 1;
end;

procedure i2c_clear_intr(i2c: PI2C_HW); inline;
begin
  g_i2c_dummy_read := i2c^.clr_intr;
end;

procedure i2c_clear_tx_abrt(i2c: PI2C_HW); inline;
begin
  g_i2c_dummy_read := i2c^.clr_tx_abrt;
end;

procedure i2c_clear_stop_det(i2c: PI2C_HW); inline;
begin
  g_i2c_dummy_read := i2c^.clr_stop_det;
end;

procedure i2c_disable(i2c: PI2C_HW);
var
  t: LongWord;
begin
  i2c^.enable := 0;
  t := 0;
  while ((i2c^.enable_status and 1) <> 0) and (t < I2C_TRANSFER_TIMEOUT) do
    Inc(t);
end;

procedure i2c_enable(i2c: PI2C_HW);
var
  t: LongWord;
begin
  i2c^.enable := 1;
  t := 0;
  while ((i2c^.enable_status and 1) = 0) and (t < I2C_TRANSFER_TIMEOUT) do
    Inc(t);
end;

procedure i2c_set_target_addr(i2c: PI2C_HW; addr: Byte);
var
  was_enabled: Boolean;
begin
  was_enabled := (i2c^.enable and 1) <> 0;
  if was_enabled then
    i2c_disable(i2c);

  i2c^.tar := addr and $7F;

  if was_enabled then
    i2c_enable(i2c);
end;

function i2c_set_baudrate(i2c: PI2C_HW; baudrate: LongWord): LongWord;
var
  freq_in: LongWord;
  period: LongWord;
  lcnt: LongWord;
  hcnt: LongWord;
  sda_tx_hold_count: LongWord;
begin
  if baudrate = 0 then
    baudrate := 100000;

  freq_in := clock_get_hz(clk_sys);
  if freq_in = 0 then
    freq_in := 125000000;

  period := (freq_in + (baudrate div 2)) div baudrate;
  if period < 16 then
    period := 16;

  lcnt := (period * 3) div 5;
  hcnt := period - lcnt;

  if lcnt < 8 then
    lcnt := 8;
  if hcnt < 6 then
    hcnt := 6;

  if baudrate < 1000000 then
    sda_tx_hold_count := ((freq_in * 3) div 10000000) + 1
  else
    sda_tx_hold_count := ((freq_in * 3) div 25000000) + 1;

  if sda_tx_hold_count < 1 then
    sda_tx_hold_count := 1;
  if sda_tx_hold_count > (lcnt - 2) then
    sda_tx_hold_count := lcnt - 2;

  i2c_disable(i2c);
  i2c_reg_write_masked(@i2c^.con, I2C_IC_CON_SPEED_FAST_BITS, I2C_IC_CON_SPEED_BITS);
  i2c^.fs_scl_hcnt := hcnt;
  i2c^.fs_scl_lcnt := lcnt;
  i2c^.fs_spklen := lcnt div 16;
  if i2c^.fs_spklen = 0 then
    i2c^.fs_spklen := 1;
  i2c_reg_write_masked(@i2c^.sda_hold, sda_tx_hold_count, $0000FFFF);

  i2c^.rx_tl := 0;
  i2c^.tx_tl := 0;
  i2c^.intr_mask := 0;
  i2c_clear_intr(i2c);
  i2c_enable(i2c);

  Result := freq_in div (i2c^.fs_scl_hcnt + i2c^.fs_scl_lcnt);
end;

function i2c_get_last_abort_reason: LongWord;
begin
  Result := g_last_abort_reason;
end;

function i2c_init(i2c: PI2C_HW; baudrate: LongWord): LongWord;
var
  reset_bits: LongWord;
begin
  if i2c = i2c0_hw then
    reset_bits := RESETS_RESET_I2C0_BITS
  else
    reset_bits := RESETS_RESET_I2C1_BITS;

  reset_block(reset_bits);
  unreset_block_wait(reset_bits);

  g_last_abort_reason := 0;
  i2c^.enable := 0;
  i2c^.con := I2C_IC_CON_MASTER_MODE_BITS or
              I2C_IC_CON_SPEED_FAST_BITS or
              I2C_IC_CON_IC_RESTART_EN_BITS or
              I2C_IC_CON_IC_SLAVE_DISABLE_BITS or
              I2C_IC_CON_TX_EMPTY_CTRL_BITS;
  i2c^.tx_tl := 0;
  i2c^.rx_tl := 0;
  i2c^.dma_cr := I2C_IC_DMA_CR_TDMAE_BITS or I2C_IC_DMA_CR_RDMAE_BITS;
  i2c^.sda_setup := $64;

  Result := i2c_set_baudrate(i2c, baudrate);
end;

procedure i2c_deinit(i2c: PI2C_HW);
var
  reset_bits: LongWord;
begin
  if i2c = i2c0_hw then
    reset_bits := RESETS_RESET_I2C0_BITS
  else
    reset_bits := RESETS_RESET_I2C1_BITS;

  reset_block(reset_bits);
end;

function i2c_write_blocking(i2c: PI2C_HW; addr: Byte; src: PByte; len: LongWord; nostop: Boolean): LongInt;
var
  i: LongWord;
  data_cmd: LongWord;
  wait_count: LongWord;
  abort_reason: LongWord;
  last: Boolean;
begin
  if len = 0 then
    Exit(0);

  g_last_abort_reason := 0;
  i2c_set_target_addr(i2c, addr);
  i2c_clear_tx_abrt(i2c);
  i2c_clear_stop_det(i2c);

  for i := 0 to len - 1 do
  begin
    wait_count := 0;
    while ((i2c^.status and I2C_IC_STATUS_TFNF_BITS) = 0) do
    begin
      if (i2c^.raw_intr_stat and I2C_IC_RAW_INTR_STAT_TX_ABRT_BITS) <> 0 then
      begin
        g_last_abort_reason := i2c^.tx_abrt_source;
        i2c_clear_tx_abrt(i2c);
        Exit(-1);
      end;
      Inc(wait_count);
      if wait_count >= I2C_TRANSFER_TIMEOUT then
        Exit(-1);
    end;

    data_cmd := src^ and I2C_IC_DATA_CMD_DAT_BITS;
    Inc(src);
    last := i = len - 1;

    if last and (not nostop) then
      data_cmd := data_cmd or I2C_IC_DATA_CMD_STOP_BITS;

    i2c^.data_cmd := data_cmd;

    wait_count := 0;
    while (i2c^.raw_intr_stat and I2C_IC_RAW_INTR_STAT_TX_EMPTY_BITS) = 0 do
    begin
      abort_reason := i2c^.tx_abrt_source;
      if (i2c^.raw_intr_stat and I2C_IC_RAW_INTR_STAT_TX_ABRT_BITS) <> 0 then
      begin
        g_last_abort_reason := abort_reason;
        i2c_clear_tx_abrt(i2c);
        Exit(-1);
      end;
      Inc(wait_count);
      if wait_count >= I2C_TRANSFER_TIMEOUT then
        Exit(-1);
    end;

    abort_reason := i2c^.tx_abrt_source;
    if ((i2c^.raw_intr_stat and I2C_IC_RAW_INTR_STAT_TX_ABRT_BITS) <> 0) or (abort_reason <> 0) then
    begin
      g_last_abort_reason := abort_reason;
      i2c_clear_tx_abrt(i2c);
      Exit(-1);
    end;

    if last and (not nostop) then
    begin
      wait_count := 0;
      while (i2c^.raw_intr_stat and I2C_IC_RAW_INTR_STAT_STOP_DET_BITS) = 0 do
      begin
        Inc(wait_count);
        if wait_count >= I2C_TRANSFER_TIMEOUT then
          Exit(-1);
      end;
      i2c_clear_stop_det(i2c);
    end;
  end;

  Result := LongInt(len);
end;

function i2c_read_blocking(i2c: PI2C_HW; addr: Byte; dst: PByte; len: LongWord; nostop: Boolean): LongInt;
var
  tx_remaining: LongWord;
  rx_remaining: LongWord;
  wait_count: LongWord;
  data_cmd: LongWord;
  abort_reason: LongWord;
  first_cmd: Boolean;
begin
  if len = 0 then
    Exit(0);

  g_last_abort_reason := 0;
  i2c_set_target_addr(i2c, addr);
  i2c_clear_tx_abrt(i2c);
  i2c_clear_stop_det(i2c);

  tx_remaining := len;
  rx_remaining := len;

  while (tx_remaining > 0) or (rx_remaining > 0) do
  begin
    while (tx_remaining > 0) and
          ((i2c^.status and I2C_IC_STATUS_TFNF_BITS) <> 0) and
          ((rx_remaining - tx_remaining) < 16) do
    begin
      data_cmd := I2C_IC_DATA_CMD_CMD_BITS;
      first_cmd := tx_remaining = len;

      if first_cmd then
        data_cmd := data_cmd or I2C_IC_DATA_CMD_RESTART_BITS;

      if (tx_remaining = 1) and (not nostop) then
        data_cmd := data_cmd or I2C_IC_DATA_CMD_STOP_BITS;

      i2c^.data_cmd := data_cmd;
      Dec(tx_remaining);

      wait_count := 0;
      while ((i2c^.raw_intr_stat and I2C_IC_RAW_INTR_STAT_TX_EMPTY_BITS) = 0) and
            ((i2c^.status and I2C_IC_STATUS_RFNE_BITS) = 0) do
      begin
        abort_reason := i2c^.tx_abrt_source;
        if (i2c^.raw_intr_stat and I2C_IC_RAW_INTR_STAT_TX_ABRT_BITS) <> 0 then
        begin
          g_last_abort_reason := abort_reason;
          i2c_clear_tx_abrt(i2c);
          Exit(-1);
        end;
        Inc(wait_count);
        if wait_count >= I2C_TRANSFER_TIMEOUT then
          Exit(-1);
      end;
    end;

    abort_reason := i2c^.tx_abrt_source;
    if ((i2c^.raw_intr_stat and I2C_IC_RAW_INTR_STAT_TX_ABRT_BITS) <> 0) or (abort_reason <> 0) then
    begin
      g_last_abort_reason := abort_reason;
      i2c_clear_tx_abrt(i2c);
      Exit(-1);
    end;

    if rx_remaining > 0 then
    begin
      wait_count := 0;
      while ((i2c^.status and I2C_IC_STATUS_RFNE_BITS) = 0) do
      begin
        if (i2c^.raw_intr_stat and I2C_IC_RAW_INTR_STAT_TX_ABRT_BITS) <> 0 then
        begin
          g_last_abort_reason := i2c^.tx_abrt_source;
          i2c_clear_tx_abrt(i2c);
          Exit(-1);
        end;

        Inc(wait_count);
        if wait_count >= I2C_TRANSFER_TIMEOUT then
          Exit(-1);
      end;

      dst^ := Byte(i2c^.data_cmd and $FF);
      Inc(dst);
      Dec(rx_remaining);
    end;
  end;

  if not nostop then
  begin
    wait_count := 0;
    while (i2c^.raw_intr_stat and I2C_IC_RAW_INTR_STAT_STOP_DET_BITS) = 0 do
    begin
      Inc(wait_count);
      if wait_count >= I2C_TRANSFER_TIMEOUT then
        Exit(-1);
    end;
    i2c_clear_stop_det(i2c);
  end;

  abort_reason := i2c^.tx_abrt_source;
  if ((i2c^.raw_intr_stat and I2C_IC_RAW_INTR_STAT_TX_ABRT_BITS) <> 0) or (abort_reason <> 0) then
  begin
    g_last_abort_reason := abort_reason;
    i2c_clear_tx_abrt(i2c);
    Exit(-1);
  end;

  Result := LongInt(len);
end;

procedure i2c_set_pin(i2c: PI2C_HW; sda_pin, scl_pin: LongWord);
begin
  if sda_pin < NUM_BANK0_GPIOS then
  begin
    gpio_set_function(sda_pin, gfI2C);
    gpio_set_input_enabled(sda_pin, True);
    gpio_pull_up(sda_pin);
  end;

  if scl_pin < NUM_BANK0_GPIOS then
  begin
    gpio_set_function(scl_pin, gfI2C);
    gpio_set_input_enabled(scl_pin, True);
    gpio_pull_up(scl_pin);
  end;
end;

end.
