{
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver.videoDrivers = [
    "nvidia"
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libGL
        libvdpau-va-gl
      ];
    };

    nvidia = {
      open = false;
      modesetting.enable = true;
      nvidiaSettings = true;
      forceFullCompositionPipeline = true;
      # package = config.boot.kernelPackages.nvidiaPackages.beta;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        # Nvidia broke many things in 580 driver (e.g., Zed)
        version = "575.64.05";
        sha256_64bit = "sha256-hfK1D5EiYcGRegss9+H5dDr/0Aj9wPIJ9NVWP3dNUC0=";
        settingsSha256 = "sha256-o2zUnYFUQjHOcCrB0w/4L6xI1hVUXLAWgG2Y26BowBE=";
        openSha256 = "sha256-mcbMVEyRxNyRrohgwWNylu45vIqF+flKHnmt47R//KU=";

        # for some reason it refuses to build without them
        sha256_aarch64 = lib.fakeHash;
        persistencedSha256 = lib.fakeHash;

        ibtSupport = true;
      };
      # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "565.57.01";
      #   sha256_64bit = "sha256-buvpTlheOF6IBPWnQVLfQUiHv4GcwhvZW3Ks0PsYLHo=";
      #   sha256_aarch64 = "sha256-aDVc3sNTG4O3y+vKW87mw+i9AqXCY29GVqEIUlsvYfE=";
      #   openSha256 = "sha256-/tM3n9huz1MTE6KKtTCBglBMBGGL/GOHi5ZSUag4zXA=";
      #   settingsSha256 = "sha256-H7uEe34LdmUFcMcS6bz7sbpYhg9zPCb/5AmZZFTx1QA=";
      #   persistencedSha256 = "sha256-hdszsACWNqkCh8G4VBNitDT85gk9gJe1BlQ8LdrYIkg=";
      # };
    };
  };
}
