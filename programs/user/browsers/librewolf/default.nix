{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.browsers.librewolf;

  settings = import ./about-config/settings;
  search = {
    force = true;
    default = "ddg";
    privateDefault = "ddg";

    engines = {
      ddg = {
        urls = lib.singleton {
          template = "https://duckduckgo.com";

          params = lib.singleton {
            name = "q";
            value = "{searchTerms}";
          };
        };
      };
      Mullvad-Leta = {
        urls = lib.singleton {
          template = "https://leta.mullvad.net/";

          params = lib.singleton {
            name = "q";
            value = "{searchTerms}";
          };
        };
      };
    };
  };
in {
  options.modules.browsers.librewolf = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable librewolf
      '';
    };

    package = mkOption {
      default = pkgs.librewolf;
      description = mkDoc ''
        Use librewolf package
      '';
    };

    profiles = mkOption {
      default = {};
      description = mkDoc ''
        Profiles in librewolf
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
      inherit (cfg) package;
      # package = pkgs-unstable.librewolf.override {
      #   extraPolicies = {
      #     DisablePocket = true;
      #     DisableAccounts = true;
      #     DisableTelemetry = true;
      #     DisableFirefoxStudies = true;
      #     DisableFirefoxAccounts = false; # E.g Firefox Sync
      #     DisableFeedbackCommands = true;
      #     DontCheckDefaultBrowser = true;
      #     NetworkPrediction = true;
      #     HttpsOnlyMode = "force_enabled";
      #     DNSOverHttps = {
      #       Enabled = true;
      #       Locked = true;
      #     };
      # cfg = {
      # speechSynthesisSupport = false;
      # extraNativeMessagingHosts = [ pkgs.passff-host ];
      # enableTridactylNative = true;
      # };
      # };
      # };

      profiles =
        builtins.mapAttrs
        (
          _name: profile:
            profile
            // {
              inherit settings search;
              inherit (profile) extensions;
            }
        )
        cfg.profiles;
    };
  };
}
