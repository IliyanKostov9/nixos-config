{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.virtualisation.virt-manager;
in {
  options.modules.virtualisation.virt-manager = {enable = mkEnableOption "virt-manager";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      virt-manager
      virtio-win
    ];
  };
}
# NOTE: Commands
# sudo virsh net-list --all
# sudo virsh net-start default
# sudo virsh net-autostart default

