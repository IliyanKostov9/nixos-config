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
    kubernetes-helm
    kind
    k3s
  ];
}
