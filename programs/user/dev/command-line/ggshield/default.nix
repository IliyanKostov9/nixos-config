{ pkgs_unstable, lib, config, ... }:
with lib;
let cfg = config.modules.ggshield;
in
{
  options.modules.ggshield = { enable = mkEnableOption "ggshield"; };

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs_unstable.ggshield.overrideAttrs (old: {
        version = "1.32.0";
        src = pkgs_unstable.fetchFromGitHub {
          owner = "GitGuardian";
          repo = "ggshield";
          rev = "767ecca08e4cec0e1ffcdfb2d1c63a8fadc2454f";
          sha256 = "sha256-yqR5kgXhR4YUih46RuSlOmD2CgdN40QpUho6WTha60U=";
        };
      }))
    ];
  };

}
