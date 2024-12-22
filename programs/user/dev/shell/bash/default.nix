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
        Enable BASH shell 
      '';
    };

    env-vars = mkOption {
      type = attrsOf str;
      default = { };
      description = mkDoc ''
        Additional env-vars
      '';
    };
  };

  config = mkIf cfg.enable (
    let
      common = pkgs.callPackage (../common) { inherit config user; inherit (cfg) env-vars; };
    in
    {
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
