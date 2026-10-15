{
  lib,
  config,
  host_attr,
  ...
}:
with lib; let
  cfg = config.modules.nvidia.prime;

  isGpuAmdOrIntel = builtins.hasAttr "gpu" host_attr && elem host_attr.gpu ["amd" "intel"];
  hasThisGpu = gpu: builtins.hasAttr "gpu" host_attr && host_attr.gpu == gpu;
in {
  options.modules.nvidia.prime = {
    enableSync = mkOption {
      type = types.bool;
      default = false;
      description = mkDoc ''
        Enable sync mode to offload to Nvidia's GPU
      '';
    };

    enableOffload = mkOption {
      type = types.bool;
      default = true;
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
      powerManagement.finegrained = isGpuAmdOrIntel && cfg.enableOffload;
      prime =
        {
          nvidiaBusId = "PCI:1:0:0";
          sync.enable = isGpuAmdOrIntel && cfg.enableSync;
          offload = {
            enable = isGpuAmdOrIntel && cfg.enableOffload;
            enableOffloadCmd = isGpuAmdOrIntel && cfg.enableOffload;
          };
        }
        // optionalAttrs (hasThisGpu "amd") {
          amdgpuBusId = host_attr.gpuBusId;
        }
        // optionalAttrs (hasThisGpu "intel") {
          intelBusId = host_attr.gpuBusId;
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
