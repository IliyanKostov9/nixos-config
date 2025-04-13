{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.security.login;
in {
  options.modules.security.login = {enable = mkEnableOption "login";};

  config = mkIf cfg.enable {
    environment.shells = with pkgs; [zsh];
  };
}
