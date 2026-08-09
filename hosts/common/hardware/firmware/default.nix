{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hardware.firmware;
in {
  options.modules.hardware.firmware = {
    # NOTE: Maybe move this to laptop's specific module?
    disableTouchpad = mkOption {
      type = types.bool;
      default = false;
      description = mkDoc ''
        Disable Laptop's touchpad
      '';
    };
  };

  config = {
    services.libinput.touchpad.disableWhileTyping = cfg.disableTouchpad;
    hardware = {
      enableAllFirmware = true;
      cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      # NOTE: needed for Allium58.
      # Modify the firmware by using nix-shell -p vial && Vial
      keyboard.qmk.enable = true;
    };
    services.udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="beeb", ATTRS{idProduct}=="0004", MODE="0666"
    '';
  };
}
