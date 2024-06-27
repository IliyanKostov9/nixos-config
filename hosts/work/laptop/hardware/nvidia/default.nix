{ config, lib, pkgs, ... }:

{
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime= {
    intelBusId="PCI:0:2:0";
    nvidiaBusId="PCI:1:0:0";
    };
  };
}
