{
  config,
  lib,
  ...
}: {
  services.libinput.touchpad.disableWhileTyping = true;
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    # NOTE: needed for Allium58
    keyboard.qmk.enable = true;
  };
services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="beeb", ATTRS{idProduct}=="0004", MODE="0666"
'';
}
