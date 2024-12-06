{ pkgs, lib, config, user, ... }:
with lib;
with lib.types;

let cfg = config.modules.dev.shell.bash;
in
{
  options.modules.dev.shell.bash = {

    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable bash
      '';
    };

    env-vars = mkOption {
      type = attrsOf str;
      default = { };
      description = mkDoc ''
        Additional environment variables
      '';
    };
  };

  config = mkIf cfg.enable (
    let
      common = pkgs.callPackage (../common/variables) {
        inherit lib pkgs user;
        inherit (cfg) env-vars;
      };
    in
    {
      home.packages = [
        pkgs.bash
      ];

      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
      home = {
        inherit (common) shellAliases;
        inherit (common) sessionVariables;
      };

      programs = {
        direnv = {
          enable = true;
          enableBashIntegration = true;
          nix-direnv.enable = true;
        };
      };
    }
  );
}
