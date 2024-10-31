{ pkgs, lib, config, user, ... }:
with lib;
let cfg = config.modules.bash;
in
{
  options.modules.bash = { enable = mkEnableOption "bash"; };

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
