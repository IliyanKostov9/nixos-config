{ pkgs, lib, config, ... }:
with lib;
with lib.types;
let
  cfg = config.modules.browsers.librewolf;

  settings = import ./about-config/settings;
  search = {
    force = true;
    default = "DuckDuckGo";
    privateDefault = "DuckDuckGo";

    engines = {
      DuckDuckGo = {
        urls = lib.singleton {
          template = "https://duckduckgo.com";

          params = lib.singleton {
            name = "q";
            value = "{searchTerms}";
          };
        };
      };
    };
  };
in
{
  options.modules.browsers.librewolf = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable librewolf
      '';
    };
    profiles = mkOption {
      default = { };
      description = mkDoc ''
        Profiles in librewolf
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
      package = pkgs.librewolf.override {
        extraPolicies = {
          DisablePocket = true;
          DisableAccounts = true;
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          DisableFirefoxAccounts = false; # E.g Firefox Sync
          DisableFeedbackCommands = true;
          DontCheckDefaultBrowser = true;
          NetworkPrediction = true;
          HttpsOnlyMode = "force_enabled";
          DNSOverHttps = {
            Enabled = true;
            Locked = true;
          };
          cfg = {
            speechSynthesisSupport = false;
            # extraNativeMessagingHosts = [ pkgs.passff-host ];
            # enableTridactylNative = true;
          };
        };
      };

      profiles = builtins.mapAttrs
        (_name: profile:
          profile //
          {
            inherit settings search;
            inherit (profile) extensions;
          }
        )
        cfg.profiles;
    };
  };
}
