{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nvidia.prime;
in {
  options.modules.nvidia.prime = {
    enableSync = mkOption {
      type = types.bool;
      default = true;
      description = mkDoc ''
        Enable sync mode to offload to Nvidia's GPU 
      '';
    };

    enableOffload = mkOption {
      type = types.bool;
      default = false;
      description = mkDoc ''
        Enable sync mode to offload to AMD's GPU 
      '';
    };
  };

  config = {
    imports = [
      ../default.nix
    ];

    hardware.nvidia.prime = {
      nvidiaBusId = "PCI:1:0:0";
      sync.enable = cfg.enableSync;
      offload = {
        enable = cfg.enableOffload;
        enableOffloadCmd = cfg.enableOffload;;
      };
    };
    specialisation = {
      on-the-go.configuration = {
        system.nixos.tags = ["on-the-go"];
        hardware.nvidia.prime = {
          sync.enable = false;
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
      };
    };
  };
}
