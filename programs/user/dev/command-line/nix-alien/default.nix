{
  self,
  system,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.command-line.nix-alien;
  is-alien-available =
    if cfg.enable && !(hasAttr "nix-alien" self.inputs)
    then builtins.warn "> nix-alien cannot be enabled, it's not added in inputs" false
    else true;
in {
  options.modules.dev.command-line.nix-alien = {enable = mkEnableOption "nix-alien";};

  config = mkIf (cfg.enable && is-alien-available) {
    home.packages = [
      self.inputs.nix-alien.packages.${system}.nix-alien
    ];
  };
}
