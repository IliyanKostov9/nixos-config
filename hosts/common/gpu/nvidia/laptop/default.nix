_: let
  enable_sync = true;
  enable_offload = false;
in {
  imports = [
    ../default.nix
  ];

  hardware.nvidia.prime = {
    sync.enable = enable_sync;
    offload = {
      enable = enable_offload;
      enableOffloadCmd = enable_offload;
    };
    nvidiaBusId = "PCI:1:0:0";
  };
  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = ["on-the-go"];
      hardware.nvidia.prime = {
        sync.enable = enable_sync;
        offload = {
          enable = enable_offload;
          enableOffloadCmd = enable_offload;
        };
      };
    };
  };
}
