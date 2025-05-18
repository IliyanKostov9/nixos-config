{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages32 = [pkgs.driversi686Linux.amdvlk];
    extraPackages = with pkgs; [
      libGL
      libvdpau-va-gl
      amdvlk
      rocmPackages.clr.icd
    ];
  };
}
