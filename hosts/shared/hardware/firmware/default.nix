{
  config,
  lib,
  ...
}: {
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    # NOTE: needed for Allium58
    keyboard.qmk.enable = false;
  };
}
