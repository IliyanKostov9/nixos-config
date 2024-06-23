{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [
    docker
  ];
}
