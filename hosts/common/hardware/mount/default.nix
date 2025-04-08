_: {
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/NIXOS_BOOT";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };

  swapDevices = [
  ];

  # swapDevices = [
  #   {
  #     device = "/dev/disk/by-label/swap";
  #     priority = 3;
  #     randomEncryption.enable = false;
  # size = 12288;
  # }
  # ];

  zramSwap = {
    priority = 4;
    enable = true;
    memoryPercent = 40;
    algorithm = "zstd";
  };
}
