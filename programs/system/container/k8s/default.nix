{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [
    # kompose
    kubectl
    kubectx
    kubernetes-helm
    kind
    k3s
  ];
}
