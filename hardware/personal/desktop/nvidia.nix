{ config, lib, pkgs, ... }:

{
  ## NVIDIA drivers start from here
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.allowUnfree = true;


  hardware.nvidia = {
    prime.nvidiaBusId = "PCI:29:00:0";
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
