{ pkgs, lib, config, user, ... }:
with lib;
let cfg = config.modules.dev.shell.bash;
in
{
  options.modules.dev.shell.bash = { enable = mkEnableOption "bash"; };

  config = mkIf cfg.enable (
    let
      common = pkgs.callPackage (../common) { inherit config user; };
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
