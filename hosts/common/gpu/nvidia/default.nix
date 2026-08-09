{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.nvidia;
  availableChannels = ["stable" "beta"];
in {
  options.modules.nvidia = {
    openSource = mkOption {
      type = types.bool;
      default = true;
      description = mkDoc ''
        Should I use the open source Nvidia's drivers?
      '';
    };

    channel = mkOption {
      type = types.str;
      default = "stable";
      description = mkDoc ''
        Nvidia's channel to use
      '';
    };

    version = mkOption {
      type = types.str;
      default = "";
      description = mkDoc ''
        Version of Nvidia's driver (if channel is not specified)
      '';
    };

    sha256_64bit = mkOption {
      type = types.str;
      default = "";
      description = mkDoc ''
        SHA256 Version of Nvidia's driver (if channel is not specified)
      '';
    };

    sha256_aarch64 = mkOption {
      type = types.str;
      default = "";
      description = mkDoc ''
        SHA256 Version of Nvidia's driver (if channel is not specified)
      '';
    };

    openSha256 = mkOption {
      type = types.str;
      default = "";
      description = mkDoc ''
        SHA256 Version of Nvidia's driver (if channel is not specified)
      '';
    };

    settingsSha256 = mkOption {
      type = types.str;
      default = "";
      description = mkDoc ''
        SHA256 Version of Nvidia's driver (if channel is not specified)
      '';
    };

    persistencedSha256 = mkOption {
      type = types.str;
      default = "";
      description = mkDoc ''
        SHA256 Version of Nvidia's driver (if channel is not specified)
      '';
    };
  };

  config = {
    assertions = [
      {
        assertion = (cfg.channel != "" && cfg.version == "") || (cfg.channel == "" && cfg.version != "");
        message = ''
          Both channel and version should not be used at the same time!
        '';
      }
      {
        assertion = cfg.channel == "" || builtins.elem cfg.channel availableChannels;
        message = ''
          Channel ${cfg.channel} is incorrect. Availible channels: ${lib.concatStringsSep '', '' availableChannels}
        '';
      }
      {
        assertion = cfg.version != "" && cfg.sha256_64bit != "" && cfg.sha256_aarch64 != "" && cfg.openSha256 != "" && cfg.settingsSha256 != "" && cfg.persistencedSha256 != "";
        message = ''
          The Version ${cfg.version} should include sha256 hashes to pin it!
        '';
      }
    ];
    services.xserver.videoDrivers = [
      "nvidia"
    ];

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
        ];
      };

      nvidia-container-toolkit.enable = true;
      nvidia = {
        open = cfg.openSource;
        powerManagement.enable = true;
        modesetting.enable = true;
        nvidiaSettings = true;
        package =
          if cfg.channel != ""
          then config.boot.kernelPackages.nvidiaPackages.${cfg.channel}
          else
            config.boot.kernelPackages.nvidiaPackages.mkDriver {
              inherit (cfg) version sha256_64bit sha256_aarch64 openSha256 settingsSha256 persistencedSha256;
            };
      };
    };
  };
}
