{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.k8s;
in
{
  options.modules.k8s = { enable = mkEnableOption "k8s"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # kompose
      kubectx
      kubernetes-helm
      kind
      k3s
      # k9s
    ];
  };

}

