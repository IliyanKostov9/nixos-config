{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [
    # kubernetes
    # minikube
    # kompose
    kubectl
    kubectx
    kubernetes-helm
    kind
    k3s
  ];
}
