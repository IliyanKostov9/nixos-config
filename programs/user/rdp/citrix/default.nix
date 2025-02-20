{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.rdp.citrix;
in
{
  options.modules.rdp.citrix = { enable = mkEnableOption "citrix"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.citrix_workspace
    ];
  };

  # NOTE: instructions
  # 1. download the version package:  https://www.citrix.com/downloads/workspace-app/legacy-workspace-app-for-linux/workspace-app-for-linux-latest1.html
  # 2. then use the command: `nix-prefetch-url file://$(pwd)/linuxx64-24.5.0.76.tar.gz --type sha256 `
  # 3. Rerun make home-update
}
