{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.dev.command-line.ggshield;
in {
  options.modules.dev.command-line.ggshield = {enable = mkEnableOption "ggshield";};

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.ggshield
      # (pkgs-unstable.ggshield.overrideAttrs {
      #   version = "1.33.0";
      #   src = pkgs-unstable.fetchFromGitHub {
      #     owner = "GitGuardian";
      #     repo = "ggshield";
      #     rev = "537dbb82c54b792a2149e6b50a86de3025e10268";
      #     sha256 = "sha256-qvvCBJ56wC56p6tOCb5hh+J7Y/Hec/YgDKNmDbbWNig=";
      #   };
      # })
    ];
  };
}
