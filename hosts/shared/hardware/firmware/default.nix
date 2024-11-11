{ config, lib, ... }:

{
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    # Enable sound with pipewire.
    pulseaudio.enable = false;
  };
}

