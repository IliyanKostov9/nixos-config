{ config, lib, ... }:

{
  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
}

