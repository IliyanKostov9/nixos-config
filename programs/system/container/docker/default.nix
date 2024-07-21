{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [
    docker
    docker-buildx
    docker-credential-helpers
  ];
}
