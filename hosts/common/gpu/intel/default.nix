{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libGL
      libvdpau-va-gl
      intel-media-driver
      intel-compute-runtime
    ];
  };
}
