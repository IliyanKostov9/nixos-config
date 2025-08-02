{lib, ...}: {
  imports = [
    ../default.nix
  ];

  hardware.nvidia.prime = {
    sync.enable = true;
    nvidiaBusId = "PCI:1:0:0";
  };
  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = ["on-the-go"];
      hardware.nvidia = {
        open = true;
        prime = {
          sync.enable = lib.mkDefault true;
          offload = {
            # enable = lib.mkDefault true;
            # enableOffloadCmd = lib.mkDefault true;
          };
        };
      };
    };
  };
}
