{ pkgs
, config
, ...
}:

{
  environment.systemPackages = with pkgs; [ home-manager ];
}
