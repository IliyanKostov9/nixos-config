{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.virt-manager;
in
{
  options.modules.virt-manager = { enable = mkEnableOption "virt-manager"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      virt-manager
      virtio-win
    ];
  };

}
