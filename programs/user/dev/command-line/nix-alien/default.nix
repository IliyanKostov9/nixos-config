{ self, system, pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.nix-alien;
in
{
  options.modules.nix-alien = { enable = mkEnableOption "nix-alien"; };

  config = mkIf cfg.enable {
    home.packages = [
      self.inputs.nix-alien.packages.${system}.nix-alien
    ];
  };

}

