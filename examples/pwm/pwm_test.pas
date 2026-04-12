{
  PWM Test Example for Raspberry Pi Pico

  Demonstrates basic PWM API compatible with pico-sdk naming.
  Sweeps duty cycle up/down continuously.

  Note: Uses GPIO25 (on-board LED on Raspberry Pi Pico, not Pico W).
}
program pwm_test;

{$mode objfpc}
{$H+}

uses
  pico,
  gpio,
  pwm;

const
  PWM_PIN = 25;
  PWM_WRAP = 9999;
  STEP = 200;
  STEP_DELAY_MS = 20;

var
  slice_num: LongWord;
  level: LongInt;
  up_dir: Boolean;
  cfg: TPwmConfig;

begin
  stdio_init_all;

  pwm_gpio_init(PWM_PIN);
  slice_num := pwm_gpio_to_slice_num(PWM_PIN);

  cfg := pwm_get_default_config;
  pwm_init(slice_num, cfg, False);

  { 125MHz / 125 = 1MHz PWM counter clock }
  pwm_set_clkdiv_int(slice_num, 125);
  pwm_set_wrap(slice_num, PWM_WRAP);
  pwm_set_gpio_level(PWM_PIN, 0);
  pwm_set_enabled(slice_num, True);

  level := 0;
  up_dir := True;

  while True do
  begin
    pwm_set_gpio_level(PWM_PIN, Word(level));

    if up_dir then
    begin
      Inc(level, STEP);
      if level >= PWM_WRAP then
      begin
        level := PWM_WRAP;
        up_dir := False;
      end;
    end
    else
    begin
      Dec(level, STEP);
      if level <= 0 then
      begin
        level := 0;
        up_dir := True;
      end;
    end;

    sleep_ms(STEP_DELAY_MS);
  end;
end.
