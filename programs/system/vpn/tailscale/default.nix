{
  pkgs-unstable,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.vpn.tailscale;
in {
  options.modules.vpn.tailscale = {enable = mkEnableOption "tailscale";};

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      package = pkgs-unstable.tailscale;
    };
  };
}
