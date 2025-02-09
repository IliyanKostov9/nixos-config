{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.dev.container.k8s;
in
{
  options.modules.dev.container.k8s = { enable = mkEnableOption "k8s"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kubectl
      # kubectx
      kubernetes-helm
      kind
      # k3s
      # k9s
      # kompose
    ];
  };

}

