{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nvidia.prime;
in {
  imports = [
    ../../default.nix
  ];

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
    assertions = [
      {
        assertion = cfg.enableSync != cfg.enableOffload;
        message = ''
          You cannot have both enableSync and enableOffload both set to ${boolToString cfg.enableSync}
        '';
      }
    ];

    hardware.nvidia = {
      powerManagement.finegrained = cfg.enableOffload;
      prime = {
        nvidiaBusId = "PCI:1:0:0";
        sync.enable = cfg.enableSync;
        offload = {
          enable = cfg.enableOffload;
          enableOffloadCmd = cfg.enableOffload;
        };
      };
    };
    specialisation = {
      on-the-go.configuration = {
        system.nixos.tags = ["on-the-go"];
        hardware.nvidia.prime = {
          sync.enable = mkForce false;
          offload = {
            enable = mkForce true;
            enableOffloadCmd = mkForce true;
          };
        };
      };
    };
  };
}
