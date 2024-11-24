{ self, system, pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.command-line.nix-alien;
in
{
  options.modules.dev.command-line.nix-alien = { enable = mkEnableOption "nix-alien"; };

  config = mkIf cfg.enable {
    home.packages = [
      self.inputs.nix-alien.packages.${system}.nix-alien
    ];
  };

}

