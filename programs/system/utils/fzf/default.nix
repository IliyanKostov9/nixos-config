{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.utils.fzf;
in {
  options.modules.utils.fzf = {enable = mkEnableOption "fzf";};

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fzf
      ripgrep
    ];
  };
}
