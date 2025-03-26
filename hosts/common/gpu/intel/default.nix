{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libGL
      libvdpau-va-gl
      intel-media-driver
      intel-vaapi-driver
      vpl-gpu-rt # WARN: Do not remove this one
      intel-compute-runtime
    ];
  };
}
