{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ curl ];
}
