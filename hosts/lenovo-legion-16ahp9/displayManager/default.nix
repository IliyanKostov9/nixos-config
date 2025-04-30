_: {
  # NOTE: Needed for Pi HDMI
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';
}
